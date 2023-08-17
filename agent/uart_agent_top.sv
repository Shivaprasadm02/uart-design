class uart_agent_top extends uvm_env;
    `uvm_component_utils(uart_agent_top)
    
    uart_agent agnth[];
    
    uart_env_config tb_cfg;
    
    function new(string name = "uart_agent_top", uvm_component parent);
        super.new(name,parent);
    endfunction
    
    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        if(!uvm_config_db #(uart_env_config) :: get(this,"","uart_env_config",tb_cfg))
            `uvm_fatal(get_type_name(),"Couldn't get ENV CONFIG")
        
        agnth = new[tb_cfg.no_of_agents];
        foreach(agnth[i])
            begin
                agnth[i] = uart_agent::type_id::create($sformatf("agnth[%0d]",i),this);
            end
    endfunction
    
    function void end_of_elaboration_phase(uvm_phase phase);
        super.end_of_elaboration_phase(phase);
        uvm_top.print_topology();
    endfunction
endclass