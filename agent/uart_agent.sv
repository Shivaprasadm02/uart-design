class uart_agent extends uvm_agent;
    `uvm_component_utils(uart_agent)
    
    uart_drv        drvh;
    uart_monitor    monh;
    uart_seqr       seqrh;
    
    uart_agent_config  m_cfg;
    
    extern function new(string name = "uart_agent", uvm_component parent);
    extern function void build_phase(uvm_phase phase);
    extern function void connect_phase(uvm_phase phase);
endclass

function uart_agent::new(string name = "uart_agent", uvm_component parent);
    super.new(name,parent);    
endfunction

function void uart_agent::build_phase(uvm_phase phase);
    super.build_phase(phase);
    if(!uvm_config_db #(uart_agent_config) :: get(this,"","uart_agent_config",m_cfg))
        `uvm_fatal(get_type_name(),"Couldn't get the AGENT CONFIG")
    monh = uart_monitor::type_id::create("monh",this);
    if(m_cfg.is_active == UVM_ACTIVE)
        begin
            drvh = uart_drv::type_id::create("drvh",this);
            seqrh = uart_seqr::type_id::create("seqrh",this);
        end
endfunction

function void uart_agent::connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    if(m_cfg.is_active == UVM_ACTIVE)
        begin
            drvh.seq_item_port.connect(seqrh.seq_item_export);
        end
endfunction