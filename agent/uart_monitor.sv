class uart_monitor extends uvm_monitor;
    `uvm_component_utils(uart_monitor)
    
    uvm_analysis_port #(uart_xtn) monitor_port;
    virtual uart_if vif;
    
    uart_agent_config m_cfg;
    
    uart_xtn mon_data;
    int FIFO_SIZE = 1;
    
    extern function new(string name = "uart_monitor", uvm_component parent);
    extern function void build_phase(uvm_phase phase);
    extern function void connect_phase(uvm_phase phase);
    extern task run_phase(uvm_phase phase);
    extern task collect_data();
    extern function void check_phase(uvm_phase phase);    
    extern function void report_phase(uvm_phase phase);
endclass

function uart_monitor::new(string name = "uart_monitor", uvm_component parent);
    super.new(name,parent);
    monitor_port = new("uart_monitor",this);
endfunction

function void uart_monitor::build_phase(uvm_phase phase);
    super.build_phase(phase);
    if(!uvm_config_db #(uart_agent_config) :: get(this,"","uart_agent_config",m_cfg))
        `uvm_fatal(get_type_name(),"Couldn't AGENT CONFIG")
    
endfunction

function void uart_monitor::connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    vif = m_cfg.vif; 
endfunction

task uart_monitor::run_phase(uvm_phase phase);
    mon_data = uart_xtn::type_id::create("mon_data");
    forever
        collect_data();   
endtask

task uart_monitor::collect_data();
    @(vif.mon_cb);  
    wait(vif.mon_cb.WB_ACK_O)
    mon_data.address = vif.mon_cb.WB_ADDR_I;
    mon_data.write_enb = vif.mon_cb.WB_WE_I;
    mon_data.data_in = vif.mon_cb.WB_DAT_I;
    
    if(mon_data.address==3 && mon_data.write_enb==1)                            //LCR
        mon_data.LCR_REG = vif.mon_cb.WB_DAT_I;
        
    if(mon_data.address==0 && mon_data.write_enb==1 && mon_data.LCR_REG[7]==1)  //DLR_LSB
        mon_data.DLR_REG = vif.mon_cb.WB_DAT_I;
        
    if(mon_data.address==1 && mon_data.write_enb==1)                            //IER
        mon_data.IER_REG = vif.mon_cb.WB_DAT_I;
        
    if(mon_data.address==2 && mon_data.write_enb==1)                            //FCR
        begin
            mon_data.FCR_REG = vif.mon_cb.WB_DAT_I;
            case(mon_data.FCR_REG[7:6])
                2'b00 : FIFO_SIZE = 1;
                2'b01 : FIFO_SIZE = 4;
                2'b10 : FIFO_SIZE = 8;
                2'b11 : FIFO_SIZE = 14;
            endcase
            //`uvm_info(get_type_name(),$sformatf("FIFO SIZE IN MONITOR = %0d",FIFO_SIZE),UVM_LOW)
        end
        
    if(mon_data.address==4 && mon_data.write_enb==1)                            //MCR
        mon_data.MCR_REG = vif.mon_cb.WB_DAT_I;
        
    if(mon_data.address==0 && mon_data.write_enb==1 && mon_data.LCR_REG[7]==0)  //THR
        mon_data.THR_REG.push_back(vif.mon_cb.WB_DAT_I);
        
    if(mon_data.address==2 && mon_data.write_enb==0)                            //IIR
        begin
            wait(vif.mon_cb.INT_O)
            @(vif.drv_cb);
            mon_data.IIR_REG = vif.mon_cb.WB_DAT_O;                       
        end
    
    if(mon_data.address==5 && mon_data.write_enb==0)                            //LSR
        mon_data.LSR_REG = vif.mon_cb.WB_DAT_O;
        
    if(mon_data.address==0 && mon_data.write_enb==0)                            //RB
        begin
            mon_data.RB_REG.push_back(vif.mon_cb.WB_DAT_O);
            mon_data.data_out = vif.mon_cb.WB_DAT_O;            
        end
endtask

function void uart_monitor::check_phase(uvm_phase phase);
    super.check_phase(phase);
    `uvm_info(get_type_name(),$sformatf("\nMONITOR DATA\n%s",mon_data.sprint()),UVM_LOW)
    monitor_port.write(mon_data);
endfunction

function void uart_monitor::report_phase(uvm_phase phase);
    super.report_phase(phase);   
endfunction