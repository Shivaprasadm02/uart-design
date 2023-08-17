class uart_env_config extends uvm_object;
    `uvm_object_utils(uart_env_config)
    
    bit has_scoreboard = 1;
    bit has_agent     = 1;
    bit has_virtual_seqr = 1;
    int no_of_agents = 2;
    uart_agent_config m_agent_cfg;
    
    function new(string name = "uart_env_config");
        super.new(name);
    endfunction
    
endclass