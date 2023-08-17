class uart_virtual_seqr extends uvm_sequencer #(uvm_sequence_item);
    `uvm_component_utils(uart_virtual_seqr)
    
    uart_seqr seqrh[];
    uart_env_config tb_cfg;
    
    function new(string name = "uart_virtual_seqr",uvm_component parent);
        super.new(name,parent);
    endfunction
    
    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        if(!uvm_config_db #(uart_env_config) :: get(this,"","uart_env_config",tb_cfg))
            `uvm_fatal(get_type_name(),"Couldn't get ENV CONFIG")
        seqrh = new[tb_cfg.no_of_agents];
    endfunction
endclass