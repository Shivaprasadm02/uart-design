class uart_drv extends uvm_driver#(uart_xtn);
    `uvm_component_utils(uart_drv)
    
    virtual uart_if.DRV vif;
    
    uart_agent_config m_cfg;
    
    extern function new(string name = "uart_drv", uvm_component parent);
    extern function void build_phase(uvm_phase phase);
    extern function void connect_phase(uvm_phase phase);
    extern task run_phase(uvm_phase phase);
    extern task send_to_dut(uart_xtn xtn);
    extern function void report_phase(uvm_phase phase);
endclass

function uart_drv::new(string name = "uart_drv", uvm_component parent);
    super.new(name,parent);
endfunction

function void uart_drv::build_phase(uvm_phase phase);
    if(!uvm_config_db #(uart_agent_config) :: get(this,"","uart_agent_config",m_cfg))
        `uvm_fatal(get_type_name(),"Couldn't get the AGENT CONFIG")
    super.build_phase(phase);
endfunction

function void uart_drv::connect_phase(uvm_phase phase);
    vif = m_cfg.vif;
    super.connect_phase(phase);
endfunction

task uart_drv::run_phase(uvm_phase phase);
    @(vif.drv_cb);
    vif.drv_cb.WB_RST_I <= 'b1;
    @(vif.drv_cb);
    vif.drv_cb.WB_RST_I <= 'b0;
    forever
        begin
            seq_item_port.get_next_item(req);            
            send_to_dut(req);            
            seq_item_port.item_done();
        end
endtask

task uart_drv::send_to_dut(uart_xtn xtn);    

    @(vif.drv_cb);
    if(xtn.write_enb)
        begin
            vif.drv_cb.WB_WE_I <= xtn.write_enb;
            vif.drv_cb.WB_ADDR_I <= xtn.address;
            vif.drv_cb.WB_DAT_I <= xtn.data_in;
        end
    else
        begin
            vif.drv_cb.WB_WE_I <= xtn.write_enb;
            vif.drv_cb.WB_ADDR_I <= xtn.address;
        end
    vif.drv_cb.WB_STB_I <= 1'b1;
    vif.drv_cb.WB_CYC_I <= 1'b1;
    vif.drv_cb.WB_SEL_I <= 4'b0001;
    
    wait(vif.drv_cb.WB_ACK_O)
    vif.drv_cb.WB_STB_I <= 1'b0;
    vif.drv_cb.WB_CYC_I <= 1'b0;
    
    if(xtn.write_enb==0 && xtn.address==3'd2)
        begin
            wait(vif.drv_cb.INT_O)
            @(vif.drv_cb);
            xtn.IIR_REG = vif.drv_cb.WB_DAT_O;
            seq_item_port.put_response(xtn);
        end    
    `uvm_info(get_type_name(),$sformatf("DRIVER DATA\n%s",xtn.sprint()),UVM_HIGH)
endtask

function void uart_drv::report_phase(uvm_phase phase);
    super.report_phase(phase);
endfunction