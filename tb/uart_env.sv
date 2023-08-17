class uart_env extends uvm_env;
    `uvm_component_utils(uart_env)
    
    uart_agent_top      agnt_top;
    uart_virtual_seqr   v_seqrh;
    uart_scoreboard     sb;
    
    uart_env_config     tb_cfg;    
    uart_agent_config   m_cfg[];
    
    extern function new(string name = "uart_env", uvm_component parent);
    extern function void config_uart();
    extern function void build_phase(uvm_phase phase);
    extern function void connect_phase(uvm_phase phase);
    
endclass

function uart_env::new(string name = "uart_env", uvm_component parent);
    super.new(name,parent);
endfunction 

function void uart_env::build_phase(uvm_phase phase);
    super.build_phase(phase);
    if(!uvm_config_db #(uart_env_config) :: get(this,"","uart_env_config",tb_cfg))
        `uvm_fatal(get_type_name(),"Couldn't get ENV CONFIG")
        
    config_uart();
    
    if(tb_cfg.has_agent)
        agnt_top = uart_agent_top::type_id::create("agnt_top",this);
    if(tb_cfg.has_scoreboard)
        sb = uart_scoreboard::type_id::create("sb",this);
    if(tb_cfg.has_virtual_seqr)
        v_seqrh = uart_virtual_seqr::type_id::create("v_seqrh",this);
        
endfunction

function void uart_env::config_uart();    
        
    m_cfg = new[tb_cfg.no_of_agents];
    foreach(m_cfg[i])
        begin
            m_cfg[i] = uart_agent_config::type_id::create($sformatf("m_cfg[%0d]",i));            
        end
    assert(uvm_config_db #(virtual uart_if) :: get(this,"","vif_0",m_cfg[0].vif));
    assert(uvm_config_db #(virtual uart_if) :: get(this,"","vif_1",m_cfg[1].vif));
    uvm_config_db #(uart_agent_config) :: set(this,"agnt_top.agnth[0]*","uart_agent_config",m_cfg[0]);
    uvm_config_db #(uart_agent_config) :: set(this,"agnt_top.agnth[1]*","uart_agent_config",m_cfg[1]);
    
endfunction

function void uart_env::connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    if(tb_cfg.has_scoreboard && tb_cfg.has_agent)
        begin
            agnt_top.agnth[0].monh.monitor_port.connect(sb.fifo_h0.analysis_export);
            agnt_top.agnth[1].monh.monitor_port.connect(sb.fifo_h1.analysis_export);
        end
    if(tb_cfg.has_virtual_seqr)
        begin
            //foreach(agnt_top.agnth[i])
                v_seqrh.seqrh[0] = agnt_top.agnth[0].seqrh;
                v_seqrh.seqrh[1] = agnt_top.agnth[1].seqrh;
        end
endfunction