class uart_scoreboard extends uvm_scoreboard;
    `uvm_component_utils(uart_scoreboard)
    
    uvm_tlm_analysis_fifo #(uart_xtn) fifo_h0;
    uvm_tlm_analysis_fifo #(uart_xtn) fifo_h1;
    
    uart_xtn UART1, UART2;
    extern function new(string name = "uart_scoreboard", uvm_component parent);    
    extern function void build_phase(uvm_phase phase);
    extern task run_phase(uvm_phase phase);
    extern function void check_phase(uvm_phase phase);
    extern function void compare();
endclass

function uart_scoreboard::new(string name = "uart_scoreboard", uvm_component parent);
    super.new(name,parent);
    fifo_h0 = new("fifo_h0",this);
    fifo_h1 = new("fifo_h1",this);
endfunction

function void uart_scoreboard::build_phase(uvm_phase phase);
    super.build_phase(phase);   
endfunction


task uart_scoreboard::run_phase(uvm_phase phase);
    
endtask

function void uart_scoreboard::check_phase(uvm_phase phase);
        begin
            fork
                fifo_h0.get(UART1);
                fifo_h1.get(UART2);
            join
            compare();
        end
endfunction

function void uart_scoreboard::compare();
    
    if(UART1.LSR_REG != 8'd0 || UART2.LSR_REG != 8'd0)
        begin            
            if(UART1.LSR_REG[4]== 1'b1 || UART2.LSR_REG[4] == 1'b1)
                `uvm_info(get_type_name(),"Break-Interrupt Testcase Succesfull",UVM_LOW)
            else if(UART1.LSR_REG[3]== 1'b1 || UART2.LSR_REG[3] == 1'b1)
                `uvm_info(get_type_name(),"Framing-Error Testcase Succesfull",UVM_LOW)
            else if(UART1.LSR_REG[2]== 1'b1 || UART2.LSR_REG[2] == 1'b1)
                `uvm_info(get_type_name(),"Parity-Error Testcase Succesfull",UVM_LOW)
            else if(UART1.LSR_REG[1]== 1'b1 || UART2.LSR_REG[1] == 1'b1)
                `uvm_info(get_type_name(),"Overrun-Error Testcase Succesfull",UVM_LOW)
            else if(UART1.LSR_REG[5]== 1'b1 || UART2.LSR_REG[5] == 1'b1)
                `uvm_info(get_type_name(),"THR Empty Testcase Succesfull",UVM_LOW)
        end
    
    else if(UART1.IIR_REG[3:1] == 3'b110 || UART2.IIR_REG[3:1] == 3'b110)
        `uvm_info(get_type_name(),"Time-Out Testcase Succesfull",UVM_LOW)
    
    else if(UART1.MCR_REG[4] == 1'b0 && UART2.MCR_REG[4] == 1'b0)
        begin
            if(UART1.RB_REG.size() == 0 || UART2.RB_REG.size() == 0)
                begin
                    if(UART1.THR_REG == UART2.RB_REG || UART1.RB_REG == UART2.THR_REG)
                        begin
                            `uvm_info(get_type_name(),"HALF-DUPLEX COMPARISSION SUCCESSFULL",UVM_LOW)                            
                        end
                    else
                        `uvm_info(get_type_name(),"HALF-DUPLEX COMPARISSION FAILED",UVM_LOW)                            
                end
            else
                begin
                    if(UART1.THR_REG == UART2.RB_REG && UART1.RB_REG == UART2.THR_REG)
                        `uvm_info(get_type_name(),"FULL-DUPLEX COMPARISSION SUCCESSFULL",UVM_LOW)
                    else
                        `uvm_info(get_type_name(),"FULL-DUPLEX COMPARISSION FAILED",UVM_LOW)
                end
        end
    else if(UART1.MCR_REG[4] == 1'b1 || UART2.MCR_REG[4] == 1'b1)
        begin
            if(UART1.THR_REG == UART1.RB_REG)
                `uvm_info(get_type_name(),"LOOP-BACK-MODE COMPARISSION SUCCESSFULL",UVM_LOW)
            else
                `uvm_info(get_type_name(),"LOOP-BACK_MODE COMPARISSION FAILED",UVM_LOW)
        end
    
endfunction
