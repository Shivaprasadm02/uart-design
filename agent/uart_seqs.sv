//  FULL_DUPLEX    = Line No : 21 - 181 ;       //  BREAK_INTERRUPT  = Line No : 829 - 971;
//  HALF_DUPLEX    = Line No : 184 - 325;       //  TIME_OUT         = Line No : 974 - 1105;
//  LOOP_BACK_MODE = Line No : 327 - 507;
//  PARITY ERROR   = Line No : 510 - 687;
//  FRAMING ERROR  = Line No : 690 - 827;

class uart1_base_seqs extends uvm_sequence#(uart_xtn);
    `uvm_object_utils(uart1_base_seqs)
    function new(string name = "uart1_base_seqs");
        super.new(name);
    endfunction
endclass

class uart2_base_seqs extends uvm_sequence#(uart_xtn);
    `uvm_object_utils(uart2_base_seqs)
    function new(string name = "uart2_base_seqs");
        super.new(name);
    endfunction
endclass 
//=======================================================Full-Duplex SEQS UART1
class u1_FD_seq extends uart1_base_seqs;
   `uvm_object_utils(u1_FD_seq)
    
    function new(string name = "u1_FD_seq");
        super.new(name);
    endfunction
    
    task body();        
        begin
            begin
                //Configure LCR
                req = uart_xtn::type_id::create("req");
                start_item(req);              
                assert(req.randomize() with {write_enb == 1'b1; address == 3'd3; regs == LCR; data_in == 8'b10000000;});
                finish_item(req);
                `uvm_info(get_type_name(),$sformatf("DATA FROM THE SEQUENCE \n%s",req.sprint()),UVM_HIGH)
            end
            begin
                //Configure DLR(MSB)                
                start_item(req);           
                assert(req.randomize() with {write_enb == 1'b1; address == 3'd1; regs == DLRMSB; data_in == 8'b00000000;});
                finish_item(req);
                `uvm_info(get_type_name(),$sformatf("DATA FROM THE SEQUENCE \n%s",req.sprint()),UVM_HIGH)
            end
            begin
                //Configure DLR(LSB)
                start_item(req);             
                assert(req.randomize() with {write_enb == 1'b1; address == 3'd0; regs == DLRLSB; data_in == 8'd54;});
                finish_item(req);
                `uvm_info(get_type_name(),$sformatf("DATA FROM THE SEQUENCE \n%s",req.sprint()),UVM_HIGH)
            end
            begin
                //Configure LCR
                start_item(req);              
                assert(req.randomize() with {write_enb == 1'b1; address == 3'd3; regs == LCR; data_in == 8'b00000011;});
                finish_item(req);
                `uvm_info(get_type_name(),$sformatf("DATA FROM THE SEQUENCE \n%s",req.sprint()),UVM_HIGH)
            end
            begin
                //Configure IER
                start_item(req);              
                assert(req.randomize() with {write_enb == 1'b1; address == 3'd1; regs == IER; data_in == 8'b00000001;});
                finish_item(req);
                `uvm_info(get_type_name(),$sformatf("DATA FROM THE SEQUENCE \n%s",req.sprint()),UVM_HIGH)
            end
            begin
                //Configure FCR
                start_item(req);              
                assert(req.randomize() with {write_enb == 1'b1; address == 3'd2; regs == FCR; data_in == 8'b00000110;});
                finish_item(req);
                `uvm_info(get_type_name(),$sformatf("DATA FROM THE SEQUENCE \n%s",req.sprint()),UVM_HIGH)
            end
            begin
                //Putting DATA into THR
                start_item(req);              
                assert(req.randomize() with {write_enb == 1'b1; address == 3'd0; regs == THR; });
                finish_item(req);
                `uvm_info(get_type_name(),$sformatf("DATA FROM THE SEQUENCE \n%s",req.sprint()),UVM_HIGH)
            end
            begin
                //Reading IIR                              
                start_item(req);              
                assert(req.randomize() with {write_enb == 1'b0; address == 3'd2; regs == IIR; });
                finish_item(req);
                get_response(req);
                `uvm_info(get_type_name(),$sformatf("DATA FROM THE SEQUENCE \n%s",req.sprint()),UVM_HIGH)
            end
            begin
                //Read RB
                if(req.IIR_REG[3:1] == 3'b010)
                begin
                    start_item(req);              
                    assert(req.randomize() with {write_enb == 1'b0; address == 3'd0; regs == RB; });
                    finish_item(req);
                end
                `uvm_info(get_type_name(),$sformatf("DATA FROM THE SEQUENCE \n%s",req.sprint()),UVM_HIGH)
            end
        end
    endtask
endclass
//=======================================================Full-Duplex SEQS UART2
class u2_FD_seq extends uart2_base_seqs;
   `uvm_object_utils(u2_FD_seq)
    
    function new(string name = "u2_FD_seq");
        super.new(name);
    endfunction
    
    task body();        
        begin
            begin
                //Configure LCR
                req = uart_xtn::type_id::create("req");
                start_item(req);              
                assert(req.randomize() with {write_enb == 1'b1; address == 3'd3; regs == LCR; data_in == 8'b10000000;});
                finish_item(req);
                `uvm_info(get_type_name(),$sformatf("DATA FROM THE SEQUENCE \n%s",req.sprint()),UVM_HIGH)
            end
            begin
                //Configure DLR(MSB)
                start_item(req);           
                assert(req.randomize() with {write_enb == 1'b1; address == 3'd1; regs == DLRMSB; data_in == 8'b00000000;});
                finish_item(req);
                `uvm_info(get_type_name(),$sformatf("DATA FROM THE SEQUENCE \n%s",req.sprint()),UVM_HIGH)
            end
            begin
                //Configure DLR(LSB)
                start_item(req);             
                assert(req.randomize() with {write_enb == 1'b1; address == 3'd0; regs == DLRLSB; data_in == 8'd27;});
                finish_item(req);
                `uvm_info(get_type_name(),$sformatf("DATA FROM THE SEQUENCE \n%s",req.sprint()),UVM_HIGH)
            end
            begin
                //Configure LCR
                start_item(req);              
                assert(req.randomize() with {write_enb == 1'b1; address == 3'd3; regs == LCR; data_in == 8'b00000011;});
                finish_item(req);
                `uvm_info(get_type_name(),$sformatf("DATA FROM THE SEQUENCE \n%s",req.sprint()),UVM_HIGH)
            end
            begin
                //Configure IER
                start_item(req);              
                assert(req.randomize() with {write_enb == 1'b1; address == 3'd1; regs == IER; data_in == 8'b00000001;});
                finish_item(req);
                `uvm_info(get_type_name(),$sformatf("DATA FROM THE SEQUENCE \n%s",req.sprint()),UVM_HIGH)
            end
            begin
                //Configure FCR
                start_item(req);              
                assert(req.randomize() with {write_enb == 1'b1; address == 3'd2; regs == FCR; data_in == 8'b00000110;});
                finish_item(req);
                `uvm_info(get_type_name(),$sformatf("DATA FROM THE SEQUENCE \n%s",req.sprint()),UVM_HIGH)
            end
            begin
                //Putting DATA into THR
                start_item(req);              
                assert(req.randomize() with {write_enb == 1'b1; address == 3'd0; regs == THR; });
                finish_item(req);
                `uvm_info(get_type_name(),$sformatf("DATA FROM THE SEQUENCE \n%s",req.sprint()),UVM_HIGH)
            end
            begin
                //Reading IIR                
                start_item(req);              
                assert(req.randomize() with {write_enb == 1'b0; address == 3'd2; regs == IIR; });
                finish_item(req);
                get_response(req);
                `uvm_info(get_type_name(),$sformatf("DATA FROM THE SEQUENCE \n%s",req.sprint()),UVM_HIGH)
            end
            begin
                //Read RB
                if(req.IIR_REG[3:1] == 3'b010)
                begin
                    start_item(req);              
                    assert(req.randomize() with {write_enb == 1'b0; address == 3'd0; regs == RB; });
                    finish_item(req);
                end
                `uvm_info(get_type_name(),$sformatf("DATA FROM THE SEQUENCE \n%s",req.sprint()),UVM_HIGH)
            end
        end
    endtask
endclass


//=======================================================================================HD SEQS UART1
class u1_HD_seq extends uart1_base_seqs;
   `uvm_object_utils(u1_HD_seq)
    
    function new(string name = "u1_HD_seq");
        super.new(name);
    endfunction
    //UART1 is Transmitting
    task body();        
        begin
            begin
                //Configure LCR
                req = uart_xtn::type_id::create("req");
                start_item(req);              
                assert(req.randomize() with {write_enb == 1'b1; address == 3'd3; regs == LCR; data_in == 8'b10000000;});
                finish_item(req);
                `uvm_info(get_type_name(),$sformatf("DATA FROM THE SEQUENCE \n%s",req.sprint()),UVM_HIGH)
            end
            begin
                //Configure DLR(MSB)                
                start_item(req);           
                assert(req.randomize() with {write_enb == 1'b1; address == 3'd1; regs == DLRMSB; data_in == 8'b00000000;});
                finish_item(req);
                `uvm_info(get_type_name(),$sformatf("DATA FROM THE SEQUENCE \n%s",req.sprint()),UVM_HIGH)
            end
            begin
                //Configure DLR(LSB)
                start_item(req);             
                assert(req.randomize() with {write_enb == 1'b1; address == 3'd0; regs == DLRLSB; data_in == 8'd54;});
                finish_item(req);
                `uvm_info(get_type_name(),$sformatf("DATA FROM THE SEQUENCE \n%s",req.sprint()),UVM_HIGH)
            end
            begin
                //Configure LCR
                start_item(req);              
                assert(req.randomize() with {write_enb == 1'b1; address == 3'd3; regs == LCR; data_in == 8'b00000011;});
                finish_item(req);
                `uvm_info(get_type_name(),$sformatf("DATA FROM THE SEQUENCE \n%s",req.sprint()),UVM_HIGH)
            end
            begin
                //Configure IER
                start_item(req);              
                assert(req.randomize() with {write_enb == 1'b1; address == 3'd1; regs == IER; data_in == 8'b00000001;});
                finish_item(req);
                `uvm_info(get_type_name(),$sformatf("DATA FROM THE SEQUENCE \n%s",req.sprint()),UVM_HIGH)
            end
            begin
                //Configure FCR(4 Bytes)
                start_item(req);              
                assert(req.randomize() with {write_enb == 1'b1; address == 3'd2; regs == FCR; data_in == 8'b01000110;});
                finish_item(req);
                `uvm_info(get_type_name(),$sformatf("DATA FROM THE SEQUENCE \n%s",req.sprint()),UVM_HIGH)
            end
            repeat(4)
            begin
                //Putting DATA into THR
                start_item(req);              
                assert(req.randomize() with {write_enb == 1'b1; address == 3'd0; regs == THR; });
                finish_item(req);
                `uvm_info(get_type_name(),$sformatf("DATA FROM THE SEQUENCE \n%s",req.sprint()),UVM_HIGH)
            end            
        end
    endtask
endclass

//=======================================================================================HD SEQS UART2
class u2_HD_seq extends uart2_base_seqs;
   `uvm_object_utils(u2_HD_seq)
    
    function new(string name = "u2_HD_seq");
        super.new(name);
    endfunction
    //UART2 is Receiving
    task body();        
        begin
            begin
                //Configure LCR
                req = uart_xtn::type_id::create("req");
                start_item(req);              
                assert(req.randomize() with {write_enb == 1'b1; address == 3'd3; regs == LCR; data_in == 8'b10000000;});
                finish_item(req);
                `uvm_info(get_type_name(),$sformatf("DATA FROM THE SEQUENCE \n%s",req.sprint()),UVM_HIGH)
            end
            begin
                //Configure DLR(MSB)
                start_item(req);           
                assert(req.randomize() with {write_enb == 1'b1; address == 3'd1; regs == DLRMSB; data_in == 8'b00000000;});
                finish_item(req);
                `uvm_info(get_type_name(),$sformatf("DATA FROM THE SEQUENCE \n%s",req.sprint()),UVM_HIGH)
            end
            begin
                //Configure DLR(LSB)
                start_item(req);             
                assert(req.randomize() with {write_enb == 1'b1; address == 3'd0; regs == DLRLSB; data_in == 8'd27;});
                finish_item(req);
                `uvm_info(get_type_name(),$sformatf("DATA FROM THE SEQUENCE \n%s",req.sprint()),UVM_HIGH)
            end
            begin
                //Configure LCR
                start_item(req);              
                assert(req.randomize() with {write_enb == 1'b1; address == 3'd3; regs == LCR; data_in == 8'b00000011;});
                finish_item(req);
                `uvm_info(get_type_name(),$sformatf("DATA FROM THE SEQUENCE \n%s",req.sprint()),UVM_HIGH)
            end
            begin
                //Configure IER
                start_item(req);              
                assert(req.randomize() with {write_enb == 1'b1; address == 3'd1; regs == IER; data_in == 8'b00000001;});
                finish_item(req);
                `uvm_info(get_type_name(),$sformatf("DATA FROM THE SEQUENCE \n%s",req.sprint()),UVM_HIGH)
            end
            begin
                //Configure FCR(4 Bytes)
                start_item(req);              
                assert(req.randomize() with {write_enb == 1'b1; address == 3'd2; regs == FCR; data_in == 8'b01000110;});
                finish_item(req);
                `uvm_info(get_type_name(),$sformatf("DATA FROM THE SEQUENCE \n%s",req.sprint()),UVM_HIGH)
            end            
            begin
                //Reading IIR               
                start_item(req);              
                assert(req.randomize() with {write_enb == 1'b0; address == 3'd2; regs == IIR; });
                finish_item(req);
                get_response(req);
                `uvm_info(get_type_name(),$sformatf("DATA FROM THE SEQUENCE \n%s",req.sprint()),UVM_HIGH)
            end
            begin
                //Read RB               
                if(req.IIR_REG[3:1] == 3'b010)
                begin
                    repeat(4)
                    begin
                    start_item(req);              
                    assert(req.randomize() with {write_enb == 1'b0; address == 3'd0; regs == RB; });
                    finish_item(req);
                    end
                end
                `uvm_info(get_type_name(),$sformatf("DATA FROM THE SEQUENCE \n%s",req.sprint()),UVM_HIGH)
            end
        end
    endtask
endclass

//=======================================================================================LBM1 SEQS
class u1_LBM_seq extends uart1_base_seqs;
   `uvm_object_utils(u1_LBM_seq)
    
    function new(string name = "u1_LBM_seq");
        super.new(name);
    endfunction
    
    task body();        
        begin
            begin
                //Configure LCR
                req = uart_xtn::type_id::create("req");
                start_item(req);              
                assert(req.randomize() with {write_enb == 1'b1; address == 3'd3; regs == LCR; data_in == 8'b10000000;});
                finish_item(req);
                `uvm_info(get_type_name(),$sformatf("DATA FROM THE SEQUENCE \n%s",req.sprint()),UVM_HIGH)
            end
            begin
                //Configure DLR(MSB)
                start_item(req);           
                assert(req.randomize() with {write_enb == 1'b1; address == 3'd1; regs == DLRMSB; data_in == 8'b00000000;});
                finish_item(req);
                `uvm_info(get_type_name(),$sformatf("DATA FROM THE SEQUENCE \n%s",req.sprint()),UVM_HIGH)
            end
            begin
                //Configure DLR(LSB)
                start_item(req);             
                assert(req.randomize() with {write_enb == 1'b1; address == 3'd0; regs == DLRLSB; data_in == 8'd54;});
                finish_item(req);
                `uvm_info(get_type_name(),$sformatf("DATA FROM THE SEQUENCE \n%s",req.sprint()),UVM_HIGH)
            end
            begin
                //Configure LCR
                start_item(req);              
                assert(req.randomize() with {write_enb == 1'b1; address == 3'd3; regs == LCR; data_in == 8'b00000011;});
                finish_item(req);
                `uvm_info(get_type_name(),$sformatf("DATA FROM THE SEQUENCE \n%s",req.sprint()),UVM_HIGH)
            end
            begin
                //Configure IER
                start_item(req);              
                assert(req.randomize() with {write_enb == 1'b1; address == 3'd1; regs == IER; data_in == 8'b00000001;});
                finish_item(req);
                `uvm_info(get_type_name(),$sformatf("DATA FROM THE SEQUENCE \n%s",req.sprint()),UVM_HIGH)
            end
            begin
                //Configure FCR
                start_item(req);              
                assert(req.randomize() with {write_enb == 1'b1; address == 3'd2; regs == FCR; data_in == 8'b00000110;});
                finish_item(req);
                `uvm_info(get_type_name(),$sformatf("DATA FROM THE SEQUENCE \n%s",req.sprint()),UVM_HIGH)
            end
            begin
                //Configure MCR
                start_item(req);              
                assert(req.randomize() with {write_enb == 1'b1; address == 3'd4; regs == MCR; data_in == 8'b00011100;});
                finish_item(req);
                `uvm_info(get_type_name(),$sformatf("DATA FROM THE SEQUENCE \n%s",req.sprint()),UVM_HIGH)
            end
            begin
                //Putting DATA into THR
                start_item(req);              
                assert(req.randomize() with {write_enb == 1'b1; address == 3'd0; regs == THR; });
                finish_item(req);
                `uvm_info(get_type_name(),$sformatf("DATA FROM THE SEQUENCE \n%s",req.sprint()),UVM_HIGH)
            end
            begin
                //Reading IIR             
                start_item(req);              
                assert(req.randomize() with {write_enb == 1'b0; address == 3'd2; regs == IIR; });
                finish_item(req);
                get_response(req);
                `uvm_info(get_type_name(),$sformatf("DATA FROM THE SEQUENCE \n%s",req.sprint()),UVM_HIGH)
            end
            begin
                //Read RB
                if(req.IIR_REG[3:1] == 3'b010)
                begin
                    start_item(req);              
                    assert(req.randomize() with {write_enb == 1'b0; address == 3'd0; regs == RB; });
                    finish_item(req);
                end
                `uvm_info(get_type_name(),$sformatf("DATA FROM THE SEQUENCE \n%s",req.sprint()),UVM_HIGH)
            end
        end
    endtask
endclass

//=======================================================================================LBM2 SEQS
class u2_LBM_seq extends uart2_base_seqs;
   `uvm_object_utils(u2_LBM_seq)
    
    function new(string name = "u2_LBM_seq");
        super.new(name);
    endfunction
    
    task body();        
        begin
            begin
                //Configure LCR
                req = uart_xtn::type_id::create("req");
                start_item(req);              
                assert(req.randomize() with {write_enb == 1'b1; address == 3'd3; regs == LCR; data_in == 8'b10000000;});
                finish_item(req);
                `uvm_info(get_type_name(),$sformatf("DATA FROM THE SEQUENCE \n%s",req.sprint()),UVM_HIGH)
            end
            begin
                //Configure DLR(MSB)
                start_item(req);           
                assert(req.randomize() with {write_enb == 1'b1; address == 3'd1; regs == DLRMSB; data_in == 8'b00000000;});
                finish_item(req);
                `uvm_info(get_type_name(),$sformatf("DATA FROM THE SEQUENCE \n%s",req.sprint()),UVM_HIGH)
            end
            begin
                //Configure DLR(LSB)
                start_item(req);             
                assert(req.randomize() with {write_enb == 1'b1; address == 3'd0; regs == DLRLSB; data_in == 8'd27;});
                finish_item(req);
                `uvm_info(get_type_name(),$sformatf("DATA FROM THE SEQUENCE \n%s",req.sprint()),UVM_HIGH)
            end
            begin
                //Configure LCR
                start_item(req);              
                assert(req.randomize() with {write_enb == 1'b1; address == 3'd3; regs == LCR; data_in == 8'b00000011;});
                finish_item(req);
                `uvm_info(get_type_name(),$sformatf("DATA FROM THE SEQUENCE \n%s",req.sprint()),UVM_HIGH)
            end
            begin
                //Configure IER
                start_item(req);              
                assert(req.randomize() with {write_enb == 1'b1; address == 3'd1; regs == IER; data_in == 8'b00000001;});
                finish_item(req);
                `uvm_info(get_type_name(),$sformatf("DATA FROM THE SEQUENCE \n%s",req.sprint()),UVM_HIGH)
            end
            begin
                //Configure FCR
                start_item(req);              
                assert(req.randomize() with {write_enb == 1'b1; address == 3'd2; regs == FCR; data_in == 8'b00000110;});
                finish_item(req);
                `uvm_info(get_type_name(),$sformatf("DATA FROM THE SEQUENCE \n%s",req.sprint()),UVM_HIGH)
            end
            begin
                //Configure MCR
                start_item(req);              
                assert(req.randomize() with {write_enb == 1'b1; address == 3'd4; regs == MCR; data_in == 8'b00011100;});
                finish_item(req);
                `uvm_info(get_type_name(),$sformatf("DATA FROM THE SEQUENCE \n%s",req.sprint()),UVM_HIGH)
            end
            begin
                //Putting DATA into THR
                begin
                start_item(req);              
                assert(req.randomize() with {write_enb == 1'b1; address == 3'd0; regs == THR; });
                finish_item(req);
                end
                `uvm_info(get_type_name(),$sformatf("DATA FROM THE SEQUENCE \n%s",req.sprint()),UVM_HIGH)
            end
            begin
                //Reading IIR              
                start_item(req);              
                assert(req.randomize() with {write_enb == 1'b0; address == 3'd2; regs == IIR; });
                finish_item(req);
                get_response(req);
                `uvm_info(get_type_name(),$sformatf("DATA FROM THE SEQUENCE \n%s",req.sprint()),UVM_HIGH)
            end
            begin
                //Read RB                
                if(req.IIR_REG[3:1] == 3'b010)
                begin
                    begin
                    start_item(req);              
                    assert(req.randomize() with {write_enb == 1'b0; address == 3'd0; regs == RB; });
                    finish_item(req);
                    end
                end
                `uvm_info(get_type_name(),$sformatf("DATA FROM THE SEQUENCE \n%s",req.sprint()),UVM_HIGH)
            end
        end
    endtask
endclass


//=======================================================================================PARITY-ERROR1 SEQS
class u1_PE_seq extends uart1_base_seqs;//EVEN
   `uvm_object_utils(u1_PE_seq)
    
    function new(string name = "u1_PE_seq");
        super.new(name);
    endfunction
    
    task body();        
        begin
            begin
                //Configure LCR
                req = uart_xtn::type_id::create("req");
                start_item(req);              
                assert(req.randomize() with {write_enb == 1'b1; address == 3'd3; regs == LCR; data_in == 8'b10000000;});
                finish_item(req);
                `uvm_info(get_type_name(),$sformatf("DATA FROM THE SEQUENCE \n%s",req.sprint()),UVM_HIGH)
            end
            begin
                //Configure DLR(MSB)
                start_item(req);           
                assert(req.randomize() with {write_enb == 1'b1; address == 3'd1; regs == DLRMSB; data_in == 8'b00000000;});
                finish_item(req);
                `uvm_info(get_type_name(),$sformatf("DATA FROM THE SEQUENCE \n%s",req.sprint()),UVM_HIGH)
            end
            begin
                //Configure DLR(LSB)
                start_item(req);             
                assert(req.randomize() with {write_enb == 1'b1; address == 3'd0; regs == DLRLSB; data_in == 8'd54;});
                finish_item(req);
                `uvm_info(get_type_name(),$sformatf("DATA FROM THE SEQUENCE \n%s",req.sprint()),UVM_HIGH)
            end
            begin
                //Configure LCR-Even Parity Enabled
                start_item(req);              
                assert(req.randomize() with {write_enb == 1'b1; address == 3'd3; regs == LCR; data_in == 8'b00011011;});
                finish_item(req);
                `uvm_info(get_type_name(),$sformatf("DATA FROM THE SEQUENCE \n%s",req.sprint()),UVM_HIGH)
            end
            begin
                //Configure IER
                start_item(req);              
                assert(req.randomize() with {write_enb == 1'b1; address == 3'd1; regs == IER; data_in == 8'b00000100;});
                finish_item(req);
                `uvm_info(get_type_name(),$sformatf("DATA FROM THE SEQUENCE \n%s",req.sprint()),UVM_HIGH)
            end
            begin
                //Configure FCR
                start_item(req);              
                assert(req.randomize() with {write_enb == 1'b1; address == 3'd2; regs == FCR; data_in == 8'b00000110;});
                finish_item(req);
                `uvm_info(get_type_name(),$sformatf("DATA FROM THE SEQUENCE \n%s",req.sprint()),UVM_HIGH)
            end            
            begin
                //Putting DATA into THR
                start_item(req);              
                assert(req.randomize() with {write_enb == 1'b1; address == 3'd0; regs == THR; });
                finish_item(req);
                `uvm_info(get_type_name(),$sformatf("DATA FROM THE SEQUENCE \n%s",req.sprint()),UVM_HIGH)
            end
            begin
                //Reading IIR             
                start_item(req);              
                assert(req.randomize() with {write_enb == 1'b0; address == 3'd2; regs == IIR; });
                finish_item(req);
                get_response(req);
                `uvm_info(get_type_name(),$sformatf("DATA FROM THE SEQUENCE \n%s",req.sprint()),UVM_HIGH)
            end
            begin
                //Read RB                
                if(req.IIR_REG[3:1] == 3'b010)
                begin
                    start_item(req);              
                    assert(req.randomize() with {write_enb == 1'b0; address == 3'd0; regs == RB; });
                    finish_item(req);
                end
                //Read LSR
                if(req.IIR_REG[3:1] == 3'b011)
                begin
                    start_item(req);              
                    assert(req.randomize() with {write_enb == 1'b0; address == 3'd5; regs == LSR; });
                    finish_item(req);
                end
                `uvm_info(get_type_name(),$sformatf("DATA FROM THE SEQUENCE \n%s",req.sprint()),UVM_HIGH)
            end
        end
    endtask
endclass

//=======================================================================================PARITY-ERROR-2 SEQS
class u2_PE_seq extends uart2_base_seqs;//ODD
   `uvm_object_utils(u2_PE_seq)
    
    function new(string name = "u2_PE_seq");
        super.new(name);
    endfunction
    
    task body();        
        begin
            begin
                //Configure LCR
                req = uart_xtn::type_id::create("req");
                start_item(req);              
                assert(req.randomize() with {write_enb == 1'b1; address == 3'd3; regs == LCR; data_in == 8'b10000000;});
                finish_item(req);
                `uvm_info(get_type_name(),$sformatf("DATA FROM THE SEQUENCE \n%s",req.sprint()),UVM_HIGH)
            end
            begin
                //Configure DLR(MSB)
                start_item(req);           
                assert(req.randomize() with {write_enb == 1'b1; address == 3'd1; regs == DLRMSB; data_in == 8'b00000000;});
                finish_item(req);
                `uvm_info(get_type_name(),$sformatf("DATA FROM THE SEQUENCE \n%s",req.sprint()),UVM_HIGH)
            end
            begin
                //Configure DLR(LSB)
                start_item(req);             
                assert(req.randomize() with {write_enb == 1'b1; address == 3'd0; regs == DLRLSB; data_in == 8'd27;});
                finish_item(req);
                `uvm_info(get_type_name(),$sformatf("DATA FROM THE SEQUENCE \n%s",req.sprint()),UVM_HIGH)
            end
            begin
                //Configure LCR-Odd Parity Enabled
                start_item(req);              
                assert(req.randomize() with {write_enb == 1'b1; address == 3'd3; regs == LCR; data_in == 8'b00001011;});
                finish_item(req);
                `uvm_info(get_type_name(),$sformatf("DATA FROM THE SEQUENCE \n%s",req.sprint()),UVM_HIGH)
            end
            begin
                //Configure IER
                start_item(req);              
                assert(req.randomize() with {write_enb == 1'b1; address == 3'd1; regs == IER; data_in == 8'b00000100;});
                finish_item(req);
                `uvm_info(get_type_name(),$sformatf("DATA FROM THE SEQUENCE \n%s",req.sprint()),UVM_HIGH)
            end
            begin
                //Configure FCR
                start_item(req);              
                assert(req.randomize() with {write_enb == 1'b1; address == 3'd2; regs == FCR; data_in == 8'b00000110;});
                finish_item(req);
                `uvm_info(get_type_name(),$sformatf("DATA FROM THE SEQUENCE \n%s",req.sprint()),UVM_HIGH)
            end
            begin
                //Putting DATA into THR
                start_item(req);              
                assert(req.randomize() with {write_enb == 1'b1; address == 3'd0; regs == THR; });
                finish_item(req);
                `uvm_info(get_type_name(),$sformatf("DATA FROM THE SEQUENCE \n%s",req.sprint()),UVM_HIGH)
            end
            begin
                //Reading IIR             
                start_item(req);              
                assert(req.randomize() with {write_enb == 1'b0; address == 3'd2; regs == IIR; });
                finish_item(req);
                get_response(req);
                `uvm_info(get_type_name(),$sformatf("DATA FROM THE SEQUENCE \n%s",req.sprint()),UVM_HIGH)
            end
            begin
                //Read RB                
                if(req.IIR_REG[3:1] == 3'b010)
                begin
                    start_item(req);              
                    assert(req.randomize() with {write_enb == 1'b0; address == 3'd0; regs == RB; });
                    finish_item(req);
                end
                //Read LSR
                if(req.IIR_REG[3:1] == 3'b011)
                begin
                    start_item(req);              
                    assert(req.randomize() with {write_enb == 1'b0; address == 3'd5; regs == LSR; });
                    finish_item(req);
                end
                `uvm_info(get_type_name(),$sformatf("DATA FROM THE SEQUENCE \n%s",req.sprint()),UVM_HIGH)
            end
        end
    endtask
endclass


//=======================================================================================FRAMING-ERROR1 SEQS
class u1_FM_seq extends uart1_base_seqs;
   `uvm_object_utils(u1_FM_seq)
    
    function new(string name = "u1_FM_seq");
        super.new(name);
    endfunction
    
    task body();        
        begin
            begin
                //Configure LCR
                req = uart_xtn::type_id::create("req");
                start_item(req);              
                assert(req.randomize() with {write_enb == 1'b1; address == 3'd3; regs == LCR; data_in == 8'b10000000;});
                finish_item(req);
                `uvm_info(get_type_name(),$sformatf("DATA FROM THE SEQUENCE \n%s",req.sprint()),UVM_HIGH)
            end
            begin
                //Configure DLR(MSB)
                start_item(req);           
                assert(req.randomize() with {write_enb == 1'b1; address == 3'd1; regs == DLRMSB; data_in == 8'b00000000;});
                finish_item(req);
                `uvm_info(get_type_name(),$sformatf("DATA FROM THE SEQUENCE \n%s",req.sprint()),UVM_HIGH)
            end
            begin
                //Configure DLR(LSB)
                start_item(req);             
                assert(req.randomize() with {write_enb == 1'b1; address == 3'd0; regs == DLRLSB; data_in == 8'd54;});
                finish_item(req);
                `uvm_info(get_type_name(),$sformatf("DATA FROM THE SEQUENCE \n%s",req.sprint()),UVM_HIGH)
            end
            begin
                //Configure LCR
                start_item(req);              
                assert(req.randomize() with {write_enb == 1'b1; address == 3'd3; regs == LCR; data_in == 8'b0000_0011;});
                finish_item(req);
                `uvm_info(get_type_name(),$sformatf("DATA FROM THE SEQUENCE \n%s",req.sprint()),UVM_HIGH)
            end
            begin
                //Configure IER
                start_item(req);              
                assert(req.randomize() with {write_enb == 1'b1; address == 3'd1; regs == IER; data_in == 8'b0000_0001;});
                finish_item(req);
                `uvm_info(get_type_name(),$sformatf("DATA FROM THE SEQUENCE \n%s",req.sprint()),UVM_HIGH)
            end
            begin
                //Configure FCR
                start_item(req);              
                assert(req.randomize() with {write_enb == 1'b1; address == 3'd2; regs == FCR; data_in == 8'b00000110;});
                finish_item(req);
                `uvm_info(get_type_name(),$sformatf("DATA FROM THE SEQUENCE \n%s",req.sprint()),UVM_HIGH)
            end
            begin
                //Putting DATA into THR
                start_item(req);              
                assert(req.randomize() with {write_enb == 1'b1; address == 3'd0; regs == THR; data_in == 8'b0000_1111; });
                finish_item(req);
                `uvm_info(get_type_name(),$sformatf("DATA FROM THE SEQUENCE \n%s",req.sprint()),UVM_HIGH)
            end                                    
        end
    endtask
endclass

//=======================================================================================FRAMING-ERROR-2 SEQS
class u2_FM_seq extends uart2_base_seqs;
   `uvm_object_utils(u2_FM_seq)
    
    function new(string name = "u2_FM_seq");
        super.new(name);
    endfunction
    
    task body();        
        begin
            begin
                //Configure LCR
                req = uart_xtn::type_id::create("req");
                start_item(req);              
                assert(req.randomize() with {write_enb == 1'b1; address == 3'd3; regs == LCR; data_in == 8'b10000000;});
                finish_item(req);
                `uvm_info(get_type_name(),$sformatf("DATA FROM THE SEQUENCE \n%s",req.sprint()),UVM_HIGH)
            end
            begin
                //Configure DLR(MSB)
                start_item(req);           
                assert(req.randomize() with {write_enb == 1'b1; address == 3'd1; regs == DLRMSB; data_in == 8'b00000000;});
                finish_item(req);
                `uvm_info(get_type_name(),$sformatf("DATA FROM THE SEQUENCE \n%s",req.sprint()),UVM_HIGH)
            end
            begin
                //Configure DLR(LSB)
                start_item(req);             
                assert(req.randomize() with {write_enb == 1'b1; address == 3'd0; regs == DLRLSB; data_in == 8'd27;});
                finish_item(req);
                `uvm_info(get_type_name(),$sformatf("DATA FROM THE SEQUENCE \n%s",req.sprint()),UVM_HIGH)
            end
            begin
                //Configure LCR
                start_item(req);              
                assert(req.randomize() with {write_enb == 1'b1; address == 3'd3; regs == LCR; data_in == 8'b00000000;});
                finish_item(req);
                `uvm_info(get_type_name(),$sformatf("DATA FROM THE SEQUENCE \n%s",req.sprint()),UVM_HIGH)
            end
            begin
                //Configure IER
                start_item(req);              
                assert(req.randomize() with {write_enb == 1'b1; address == 3'd1; regs == IER; data_in == 8'b00000100;});
                finish_item(req);
                `uvm_info(get_type_name(),$sformatf("DATA FROM THE SEQUENCE \n%s",req.sprint()),UVM_HIGH)
            end
            begin
                //Configure FCR
                start_item(req);              
                assert(req.randomize() with {write_enb == 1'b1; address == 3'd2; regs == FCR; data_in == 8'b00000110;});
                finish_item(req);
                `uvm_info(get_type_name(),$sformatf("DATA FROM THE SEQUENCE \n%s",req.sprint()),UVM_HIGH)
            end
            begin
                //Reading IIR             
                start_item(req);              
                assert(req.randomize() with {write_enb == 1'b0; address == 3'd2; regs == IIR; });
                finish_item(req);
                get_response(req);
                `uvm_info(get_type_name(),$sformatf("DATA FROM THE SEQUENCE \n%s",req.sprint()),UVM_HIGH)
            end
            begin
                //Reading LSR
                if(req.IIR_REG[3:1] == 3'b011)
                begin
                    start_item(req);              
                    assert(req.randomize() with {write_enb == 1'b0; address == 3'd5; regs == LSR; });
                    finish_item(req);
                end
                `uvm_info(get_type_name(),$sformatf("DATA FROM THE SEQUENCE \n%s",req.sprint()),UVM_HIGH)
            end 
        end
    endtask
endclass

//=======================================================================================BREAK-INTERRUPT SEQS
class u1_BI_seq extends uart1_base_seqs;
   `uvm_object_utils(u1_BI_seq)
    
    function new(string name = "u1_BI_seq");
        super.new(name);
    endfunction
    
    task body();        
        begin
            begin
                //Configure LCR
                req = uart_xtn::type_id::create("req");
                start_item(req);              
                assert(req.randomize() with {write_enb == 1'b1; address == 3'd3; regs == LCR; data_in == 8'b10000000;});
                finish_item(req);
                `uvm_info(get_type_name(),$sformatf("DATA FROM THE SEQUENCE \n%s",req.sprint()),UVM_HIGH)
            end
            begin
                //Configure DLR(MSB)
                start_item(req);           
                assert(req.randomize() with {write_enb == 1'b1; address == 3'd1; regs == DLRMSB; data_in == 8'b00000000;});
                finish_item(req);
                `uvm_info(get_type_name(),$sformatf("DATA FROM THE SEQUENCE \n%s",req.sprint()),UVM_HIGH)
            end
            begin
                //Configure DLR(LSB)
                start_item(req);             
                assert(req.randomize() with {write_enb == 1'b1; address == 3'd0; regs == DLRLSB; data_in == 8'd54;});
                finish_item(req);
                `uvm_info(get_type_name(),$sformatf("DATA FROM THE SEQUENCE \n%s",req.sprint()),UVM_HIGH)
            end
            begin
                //Configure LCR
                start_item(req);              
                assert(req.randomize() with {write_enb == 1'b1; address == 3'd3; regs == LCR; data_in == 8'b0100_0011;});
                finish_item(req);
                `uvm_info(get_type_name(),$sformatf("DATA FROM THE SEQUENCE \n%s",req.sprint()),UVM_HIGH)
            end
            begin
                //Configure IER
                start_item(req);              
                assert(req.randomize() with {write_enb == 1'b1; address == 3'd1; regs == IER; data_in == 8'b0000_0001;});
                finish_item(req);
                `uvm_info(get_type_name(),$sformatf("DATA FROM THE SEQUENCE \n%s",req.sprint()),UVM_HIGH)
            end
            begin
                //Configure FCR
                start_item(req);              
                assert(req.randomize() with {write_enb == 1'b1; address == 3'd2; regs == FCR; data_in == 8'b00000110;});
                finish_item(req);
                `uvm_info(get_type_name(),$sformatf("DATA FROM THE SEQUENCE \n%s",req.sprint()),UVM_HIGH)
            end
            begin
                //Putting DATA into THR
                start_item(req);              
                assert(req.randomize() with {write_enb == 1'b1; address == 3'd0; regs == THR; });
                finish_item(req);
                `uvm_info(get_type_name(),$sformatf("DATA FROM THE SEQUENCE \n%s",req.sprint()),UVM_HIGH)
            end                                    
        end
    endtask
endclass

//=======================================================================================BREAK-INTERRUPT-2 SEQS
class u2_BI_seq extends uart2_base_seqs;
   `uvm_object_utils(u2_BI_seq)
    
    function new(string name = "u2_BI_seq");
        super.new(name);
    endfunction
    
    task body();        
        begin
            begin
                //Configure LCR
                req = uart_xtn::type_id::create("req");
                start_item(req);              
                assert(req.randomize() with {write_enb == 1'b1; address == 3'd3; regs == LCR; data_in == 8'b10000000;});
                finish_item(req);
                `uvm_info(get_type_name(),$sformatf("DATA FROM THE SEQUENCE \n%s",req.sprint()),UVM_HIGH)
            end
            begin
                //Configure DLR(MSB)
                start_item(req);           
                assert(req.randomize() with {write_enb == 1'b1; address == 3'd1; regs == DLRMSB; data_in == 8'b00000000;});
                finish_item(req);
                `uvm_info(get_type_name(),$sformatf("DATA FROM THE SEQUENCE \n%s",req.sprint()),UVM_HIGH)
            end
            begin
                //Configure DLR(LSB)
                start_item(req);             
                assert(req.randomize() with {write_enb == 1'b1; address == 3'd0; regs == DLRLSB; data_in == 8'd27;});
                finish_item(req);
                `uvm_info(get_type_name(),$sformatf("DATA FROM THE SEQUENCE \n%s",req.sprint()),UVM_HIGH)
            end
            begin
                //Configure LCR
                start_item(req);              
                assert(req.randomize() with {write_enb == 1'b1; address == 3'd3; regs == LCR; data_in == 8'b00000011;});
                finish_item(req);
                `uvm_info(get_type_name(),$sformatf("DATA FROM THE SEQUENCE \n%s",req.sprint()),UVM_HIGH)
            end
            begin
                //Configure IER
                start_item(req);              
                assert(req.randomize() with {write_enb == 1'b1; address == 3'd1; regs == IER; data_in == 8'b00000100;});
                finish_item(req);
                `uvm_info(get_type_name(),$sformatf("DATA FROM THE SEQUENCE \n%s",req.sprint()),UVM_HIGH)
            end
            begin
                //Configure FCR
                start_item(req);              
                assert(req.randomize() with {write_enb == 1'b1; address == 3'd2; regs == FCR; data_in == 8'b00000110;});
                finish_item(req);
                `uvm_info(get_type_name(),$sformatf("DATA FROM THE SEQUENCE \n%s",req.sprint()),UVM_HIGH)
            end
            begin
                //Reading IIR             
                start_item(req);              
                assert(req.randomize() with {write_enb == 1'b0; address == 3'd2; regs == IIR; });
                finish_item(req);
                get_response(req);
                `uvm_info(get_type_name(),$sformatf("DATA FROM THE SEQUENCE \n%s",req.sprint()),UVM_HIGH)
            end
            begin
                //Reading LSR
                if(req.IIR_REG[3:1] == 3'b011)
                begin
                    //LSR
                    start_item(req);              
                    assert(req.randomize() with {write_enb == 1'b0; address == 3'd5; regs == LSR; });
                    finish_item(req);                    
                end
                `uvm_info(get_type_name(),$sformatf("DATA FROM THE SEQUENCE \n%s",req.sprint()),UVM_HIGH)
            end 
        end
    endtask
endclass


//=======================================================================================TIME-OUT-1 SEQS
// UART1: Making FCR as 8 bytes but sending 4 bytes
// UART2: Making FCR as 14 bytes. Expecting for the data from UART1
class u1_TO_seq extends uart1_base_seqs;
   `uvm_object_utils(u1_TO_seq)
    
    function new(string name = "u1_TO_seq");
        super.new(name);
    endfunction
    
    task body();        
        begin
            begin
                //Configure LCR
                req = uart_xtn::type_id::create("req");
                start_item(req);              
                assert(req.randomize() with {write_enb == 1'b1; address == 3'd3; regs == LCR; data_in == 8'b10000000;});
                finish_item(req);
                `uvm_info(get_type_name(),$sformatf("DATA FROM THE SEQUENCE \n%s",req.sprint()),UVM_HIGH)
            end
            begin
                //Configure DLR(MSB)
                start_item(req);           
                assert(req.randomize() with {write_enb == 1'b1; address == 3'd1; regs == DLRMSB; data_in == 8'b00000000;});
                finish_item(req);
                `uvm_info(get_type_name(),$sformatf("DATA FROM THE SEQUENCE \n%s",req.sprint()),UVM_HIGH)
            end
            begin
                //Configure DLR(LSB)
                start_item(req);             
                assert(req.randomize() with {write_enb == 1'b1; address == 3'd0; regs == DLRLSB; data_in == 8'd54;});
                finish_item(req);
                `uvm_info(get_type_name(),$sformatf("DATA FROM THE SEQUENCE \n%s",req.sprint()),UVM_HIGH)
            end
            begin
                //Configure LCR
                start_item(req);              
                assert(req.randomize() with {write_enb == 1'b1; address == 3'd3; regs == LCR; data_in == 8'b0000_0011;});
                finish_item(req);
                `uvm_info(get_type_name(),$sformatf("DATA FROM THE SEQUENCE \n%s",req.sprint()),UVM_HIGH)
            end
            begin
                //Configure IER
                start_item(req);              
                assert(req.randomize() with {write_enb == 1'b1; address == 3'd1; regs == IER; data_in == 8'b0000_0001;});
                finish_item(req);
                `uvm_info(get_type_name(),$sformatf("DATA FROM THE SEQUENCE \n%s",req.sprint()),UVM_HIGH)
            end
            begin
                //Configure FCR
                start_item(req);              
                assert(req.randomize() with {write_enb == 1'b1; address == 3'd2; regs == FCR; data_in == 8'b10000110;});
                finish_item(req);
                `uvm_info(get_type_name(),$sformatf("DATA FROM THE SEQUENCE \n%s",req.sprint()),UVM_HIGH)
            end
            repeat(4)
            begin
                //Putting DATA into THR
                start_item(req);              
                assert(req.randomize() with {write_enb == 1'b1; address == 3'd0; regs == THR; });
                finish_item(req);
                `uvm_info(get_type_name(),$sformatf("DATA FROM THE SEQUENCE \n%s",req.sprint()),UVM_HIGH)
            end                                    
        end
    endtask
endclass

//=======================================================================================TIME-OUT-2 SEQS
class u2_TO_seq extends uart2_base_seqs;
   `uvm_object_utils(u2_TO_seq)
    
    function new(string name = "u2_TO_seq");
        super.new(name);
    endfunction
    
    task body();        
        begin
            begin
                //Configure LCR
                req = uart_xtn::type_id::create("req");
                start_item(req);              
                assert(req.randomize() with {write_enb == 1'b1; address == 3'd3; regs == LCR; data_in == 8'b10000000;});
                finish_item(req);
                `uvm_info(get_type_name(),$sformatf("DATA FROM THE SEQUENCE \n%s",req.sprint()),UVM_HIGH)
            end
            begin
                //Configure DLR(MSB)
                start_item(req);           
                assert(req.randomize() with {write_enb == 1'b1; address == 3'd1; regs == DLRMSB; data_in == 8'b00000000;});
                finish_item(req);
                `uvm_info(get_type_name(),$sformatf("DATA FROM THE SEQUENCE \n%s",req.sprint()),UVM_HIGH)
            end
            begin
                //Configure DLR(LSB)
                start_item(req);             
                assert(req.randomize() with {write_enb == 1'b1; address == 3'd0; regs == DLRLSB; data_in == 8'd27;});
                finish_item(req);
                `uvm_info(get_type_name(),$sformatf("DATA FROM THE SEQUENCE \n%s",req.sprint()),UVM_HIGH)
            end
            begin
                //Configure LCR
                start_item(req);              
                assert(req.randomize() with {write_enb == 1'b1; address == 3'd3; regs == LCR; data_in == 8'b00000011;});
                finish_item(req);
                `uvm_info(get_type_name(),$sformatf("DATA FROM THE SEQUENCE \n%s",req.sprint()),UVM_HIGH)
            end
            begin
                //Configure IER
                start_item(req);              
                assert(req.randomize() with {write_enb == 1'b1; address == 3'd1; regs == IER; data_in == 8'b00000001;});
                finish_item(req);
                `uvm_info(get_type_name(),$sformatf("DATA FROM THE SEQUENCE \n%s",req.sprint()),UVM_HIGH)
            end
            begin
                //Configure FCR
                start_item(req);              
                assert(req.randomize() with {write_enb == 1'b1; address == 3'd2; regs == FCR; data_in == 8'b11000110;});
                finish_item(req);
                `uvm_info(get_type_name(),$sformatf("DATA FROM THE SEQUENCE \n%s",req.sprint()),UVM_HIGH)
            end
            begin
                //Reading IIR             
                start_item(req);              
                assert(req.randomize() with {write_enb == 1'b0; address == 3'd2; regs == IIR; });
                finish_item(req);
                get_response(req);
                `uvm_info(get_type_name(),$sformatf("DATA FROM THE SEQUENCE \n%s",req.sprint()),UVM_HIGH)
            end
             
        end
    endtask
endclass

//=======================================================================================OVERRUN-ERROR1 SEQS
class u1_OR_seq extends uart1_base_seqs;
   `uvm_object_utils(u1_OR_seq)
    
    function new(string name = "u1_OR_seq");
        super.new(name);
    endfunction
    
    task body();        
        begin
            begin
                //Configure LCR
                req = uart_xtn::type_id::create("req");
                start_item(req);              
                assert(req.randomize() with {write_enb == 1'b1; address == 3'd3; regs == LCR; data_in == 8'b10000000;});
                finish_item(req);
                `uvm_info(get_type_name(),$sformatf("DATA FROM THE SEQUENCE \n%s",req.sprint()),UVM_HIGH)
            end
            begin
                //Configure DLR(MSB)
                start_item(req);           
                assert(req.randomize() with {write_enb == 1'b1; address == 3'd1; regs == DLRMSB; data_in == 8'b00000000;});
                finish_item(req);
                `uvm_info(get_type_name(),$sformatf("DATA FROM THE SEQUENCE \n%s",req.sprint()),UVM_HIGH)
            end
            begin
                //Configure DLR(LSB)
                start_item(req);             
                assert(req.randomize() with {write_enb == 1'b1; address == 3'd0; regs == DLRLSB; data_in == 8'd54;});
                finish_item(req);
                `uvm_info(get_type_name(),$sformatf("DATA FROM THE SEQUENCE \n%s",req.sprint()),UVM_HIGH)
            end
            begin
                //Configure LCR
                start_item(req);              
                assert(req.randomize() with {write_enb == 1'b1; address == 3'd3; regs == LCR; data_in == 8'b0000_0011;});
                finish_item(req);
                `uvm_info(get_type_name(),$sformatf("DATA FROM THE SEQUENCE \n%s",req.sprint()),UVM_HIGH)
            end
            begin
                //Configure IER
                start_item(req);              
                assert(req.randomize() with {write_enb == 1'b1; address == 3'd1; regs == IER; data_in == 8'b0000_0010;});
                finish_item(req);
                `uvm_info(get_type_name(),$sformatf("DATA FROM THE SEQUENCE \n%s",req.sprint()),UVM_HIGH)
            end
            begin
                //Configure FCR
                start_item(req);              
                assert(req.randomize() with {write_enb == 1'b1; address == 3'd2; regs == FCR; data_in == 8'b11000110;});
                finish_item(req);
                `uvm_info(get_type_name(),$sformatf("DATA FROM THE SEQUENCE \n%s",req.sprint()),UVM_HIGH)
            end
            repeat(15)
            begin
                //Putting DATA into THR
                start_item(req);              
                assert(req.randomize() with {write_enb == 1'b1; address == 3'd0; regs == THR; });
                finish_item(req);
                `uvm_info(get_type_name(),$sformatf("DATA FROM THE SEQUENCE \n%s",req.sprint()),UVM_HIGH)
            end
            begin
                //Reading IIR             
                start_item(req);              
                assert(req.randomize() with {write_enb == 1'b0; address == 3'd2; regs == IIR; });
                finish_item(req);
                get_response(req);
                `uvm_info(get_type_name(),$sformatf("DATA FROM THE SEQUENCE \n%s",req.sprint()),UVM_HIGH)
            end
            begin
                //Putting DATA into THR
                if(req.IIR_REG[3:1]==3'b001)
                    begin
                        begin
                            //Configure FCR
                            start_item(req);              
                            assert(req.randomize() with {write_enb == 1'b1; address == 3'd2; regs == FCR; data_in == 8'b01000110;});
                            finish_item(req);
                            `uvm_info(get_type_name(),$sformatf("DATA FROM THE SEQUENCE \n%s",req.sprint()),UVM_HIGH)
                        end
                        repeat(4)
                            begin
                                start_item(req);              
                                assert(req.randomize() with {write_enb == 1'b1; address == 3'd0; regs == THR; });
                                finish_item(req);
                                `uvm_info(get_type_name(),$sformatf("DATA FROM THE SEQUENCE \n%s",req.sprint()),UVM_HIGH)
                            end
                    end
            end                        
        end
    endtask
endclass

//=======================================================================================OVERRUN-ERROR-2 SEQS
class u2_OR_seq extends uart2_base_seqs;
   `uvm_object_utils(u2_OR_seq)
    
    function new(string name = "u2_OR_seq");
        super.new(name);
    endfunction
    
    task body();        
        begin
            begin
                //Configure LCR
                req = uart_xtn::type_id::create("req");
                start_item(req);              
                assert(req.randomize() with {write_enb == 1'b1; address == 3'd3; regs == LCR; data_in == 8'b10000000;});
                finish_item(req);
                `uvm_info(get_type_name(),$sformatf("DATA FROM THE SEQUENCE \n%s",req.sprint()),UVM_HIGH)
            end
            begin
                //Configure DLR(MSB)
                start_item(req);           
                assert(req.randomize() with {write_enb == 1'b1; address == 3'd1; regs == DLRMSB; data_in == 8'b00000000;});
                finish_item(req);
                `uvm_info(get_type_name(),$sformatf("DATA FROM THE SEQUENCE \n%s",req.sprint()),UVM_HIGH)
            end
            begin
                //Configure DLR(LSB)
                start_item(req);             
                assert(req.randomize() with {write_enb == 1'b1; address == 3'd0; regs == DLRLSB; data_in == 8'd27;});
                finish_item(req);
                `uvm_info(get_type_name(),$sformatf("DATA FROM THE SEQUENCE \n%s",req.sprint()),UVM_HIGH)
            end
            begin
                //Configure LCR
                start_item(req);              
                assert(req.randomize() with {write_enb == 1'b1; address == 3'd3; regs == LCR; data_in == 8'b00000011;});
                finish_item(req);
                `uvm_info(get_type_name(),$sformatf("DATA FROM THE SEQUENCE \n%s",req.sprint()),UVM_HIGH)
            end
            begin
                //Configure IER
                start_item(req);              
                assert(req.randomize() with {write_enb == 1'b1; address == 3'd1; regs == IER; data_in == 8'b00000100;});
                finish_item(req);
                `uvm_info(get_type_name(),$sformatf("DATA FROM THE SEQUENCE \n%s",req.sprint()),UVM_HIGH)
            end
            begin
                //Configure FCR
                start_item(req);              
                assert(req.randomize() with {write_enb == 1'b1; address == 3'd2; regs == FCR; data_in == 8'b11000110;});
                finish_item(req);
                `uvm_info(get_type_name(),$sformatf("DATA FROM THE SEQUENCE \n%s",req.sprint()),UVM_HIGH)
            end
            begin
                //Reading IIR             
                start_item(req);              
                assert(req.randomize() with {write_enb == 1'b0; address == 3'd2; regs == IIR; });
                finish_item(req);
                get_response(req);
                `uvm_info(get_type_name(),$sformatf("DATA FROM THE SEQUENCE \n%s",req.sprint()),UVM_HIGH)
            end                        
            begin
                //Reading LSR
                if(req.IIR_REG[3:1] == 3'b011)
                begin
                    start_item(req);              
                    assert(req.randomize() with {write_enb == 1'b0; address == 3'd5; regs == LSR; });
                    finish_item(req);                    
                    `uvm_info(get_type_name(),$sformatf("DATA FROM THE SEQUENCE \n%s",req.sprint()),UVM_HIGH)
                end
            end
        end
    endtask
endclass


//=======================================================================================THR EMPTY-1 SEQS
class u1_THR_seq extends uart1_base_seqs;
   `uvm_object_utils(u1_THR_seq)
    
    function new(string name = "u1_THR_seq");
        super.new(name);
    endfunction
    //UART1 is Transmitting
    task body();        
        begin
            begin
                //Configure LCR
                req = uart_xtn::type_id::create("req");
                start_item(req);              
                assert(req.randomize() with {write_enb == 1'b1; address == 3'd3; regs == LCR; data_in == 8'b10000000;});
                finish_item(req);
                `uvm_info(get_type_name(),$sformatf("DATA FROM THE SEQUENCE \n%s",req.sprint()),UVM_HIGH)
            end
            begin
                //Configure DLR(MSB)
                start_item(req);           
                assert(req.randomize() with {write_enb == 1'b1; address == 3'd1; regs == DLRMSB; data_in == 8'b00000000;});
                finish_item(req);
                `uvm_info(get_type_name(),$sformatf("DATA FROM THE SEQUENCE \n%s",req.sprint()),UVM_HIGH)
            end
            begin
                //Configure DLR(LSB)
                start_item(req);             
                assert(req.randomize() with {write_enb == 1'b1; address == 3'd0; regs == DLRLSB; data_in == 8'd54;});
                finish_item(req);
                `uvm_info(get_type_name(),$sformatf("DATA FROM THE SEQUENCE \n%s",req.sprint()),UVM_HIGH)
            end
            begin
                //Configure LCR
                start_item(req);              
                assert(req.randomize() with {write_enb == 1'b1; address == 3'd3; regs == LCR; data_in == 8'b00000011;});
                finish_item(req);
                `uvm_info(get_type_name(),$sformatf("DATA FROM THE SEQUENCE \n%s",req.sprint()),UVM_HIGH)
            end
            begin
                //Configure IER
                start_item(req);              
                assert(req.randomize() with {write_enb == 1'b1; address == 3'd1; regs == IER; data_in == 8'b00000010;});
                finish_item(req);
                `uvm_info(get_type_name(),$sformatf("DATA FROM THE SEQUENCE \n%s",req.sprint()),UVM_HIGH)
            end
            begin
                //Configure FCR
                start_item(req);              
                assert(req.randomize() with {write_enb == 1'b1; address == 3'd2; regs == FCR; data_in == 8'b01000110;});
                finish_item(req);
                `uvm_info(get_type_name(),$sformatf("DATA FROM THE SEQUENCE \n%s",req.sprint()),UVM_HIGH)
            end
            repeat(4)
            begin
                //Putting DATA into THR
                start_item(req);              
                assert(req.randomize() with {write_enb == 1'b1; address == 3'd0; regs == THR; });
                finish_item(req);
                `uvm_info(get_type_name(),$sformatf("DATA FROM THE SEQUENCE \n%s",req.sprint()),UVM_HIGH)
            end
            begin
                //Reading IIR               
                start_item(req);              
                assert(req.randomize() with {write_enb == 1'b0; address == 3'd2; regs == IIR; });
                finish_item(req);
                get_response(req);
                `uvm_info(get_type_name(),$sformatf("DATA FROM THE SEQUENCE \n%s",req.sprint()),UVM_HIGH)
            end
            begin
                //Reading LSR
                if(req.IIR_REG[3:1] == 3'b001)
                begin
                    //LSR
                    start_item(req);              
                    assert(req.randomize() with {write_enb == 1'b0; address == 3'd5; regs == LSR; });
                    finish_item(req);                    
                end
                `uvm_info(get_type_name(),$sformatf("DATA FROM THE SEQUENCE \n%s",req.sprint()),UVM_HIGH)
            end
        end
    endtask
endclass

class u2_THR_seq extends uart2_base_seqs;
   `uvm_object_utils(u2_THR_seq)
    
    function new(string name = "u2_THR_seq");
        super.new(name);
    endfunction
    //UART2 is Receiving
    task body();        
        begin
            begin
                //Configure LCR
                req = uart_xtn::type_id::create("req");
                start_item(req);              
                assert(req.randomize() with {write_enb == 1'b1; address == 3'd3; regs == LCR; data_in == 8'b10000000;});
                finish_item(req);
                `uvm_info(get_type_name(),$sformatf("DATA FROM THE SEQUENCE \n%s",req.sprint()),UVM_HIGH)
            end
            begin
                //Configure DLR(MSB)
                start_item(req);           
                assert(req.randomize() with {write_enb == 1'b1; address == 3'd1; regs == DLRMSB; data_in == 8'b00000000;});
                finish_item(req);
                `uvm_info(get_type_name(),$sformatf("DATA FROM THE SEQUENCE \n%s",req.sprint()),UVM_HIGH)
            end
            begin
                //Configure DLR(LSB)
                start_item(req);             
                assert(req.randomize() with {write_enb == 1'b1; address == 3'd0; regs == DLRLSB; data_in == 8'd27;});
                finish_item(req);
                `uvm_info(get_type_name(),$sformatf("DATA FROM THE SEQUENCE \n%s",req.sprint()),UVM_HIGH)
            end
            begin
                //Configure LCR
                start_item(req);              
                assert(req.randomize() with {write_enb == 1'b1; address == 3'd3; regs == LCR; data_in == 8'b00000011;});
                finish_item(req);
                `uvm_info(get_type_name(),$sformatf("DATA FROM THE SEQUENCE \n%s",req.sprint()),UVM_HIGH)
            end
            begin
                //Configure IER
                start_item(req);              
                assert(req.randomize() with {write_enb == 1'b1; address == 3'd1; regs == IER; data_in == 8'b00000001;});
                finish_item(req);
                `uvm_info(get_type_name(),$sformatf("DATA FROM THE SEQUENCE \n%s",req.sprint()),UVM_HIGH)
            end
            begin
                //Configure FCR
                start_item(req);              
                assert(req.randomize() with {write_enb == 1'b1; address == 3'd2; regs == FCR; data_in == 8'b01000110;});
                finish_item(req);
                `uvm_info(get_type_name(),$sformatf("DATA FROM THE SEQUENCE \n%s",req.sprint()),UVM_HIGH)
            end            
            begin
                //Reading IIR               
                start_item(req);              
                assert(req.randomize() with {write_enb == 1'b0; address == 3'd2; regs == IIR; });
                finish_item(req);
                get_response(req);
                `uvm_info(get_type_name(),$sformatf("DATA FROM THE SEQUENCE \n%s",req.sprint()),UVM_HIGH)
            end
            begin
                //Read RB              
                if(req.IIR_REG[3:1] == 3'b010)
                begin
                    repeat(4)
                    begin
                    start_item(req);              
                    assert(req.randomize() with {write_enb == 1'b0; address == 3'd0; regs == RB; });
                    finish_item(req);
                    end
                end
                `uvm_info(get_type_name(),$sformatf("DATA FROM THE SEQUENCE \n%s",req.sprint()),UVM_HIGH)
            end
        end
    endtask
endclass

