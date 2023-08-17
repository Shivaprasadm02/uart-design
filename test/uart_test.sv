class uart_test extends uvm_test;
    `uvm_component_utils(uart_test)
    
    
    uart_env_config tb_cfg;
    uart_env envh;
    
    function new(string name = "uart_test",uvm_component parent);
        super.new(name,parent);
    endfunction
    
    function void build_phase(uvm_phase phase); 
        super.build_phase(phase);
    
        tb_cfg = uart_env_config::type_id::create("tb_cfg");
        uvm_config_db #(uart_env_config) :: set(this,"*","uart_env_config",tb_cfg);
    
        envh = uart_env::type_id::create("envh",this);
    endfunction
    
endclass

//=======================================================TEST CASE Full-Duplex
class uart_test_fd extends uart_test;
    `uvm_component_utils(uart_test_fd)
    
    uart_virtual_fd fd_vseqh; 
    
    function new(string name = "uart_test_fd", uvm_component parent);
        super.new(name,parent);
    endfunction
    
    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
    endfunction
    
    task run_phase(uvm_phase phase);
        phase.raise_objection(this);
            fd_vseqh = uart_virtual_fd::type_id::create("fd_vseqh");
            fd_vseqh.start(envh.v_seqrh);            
        phase.drop_objection(this);
    endtask
endclass

//=======================================================TEST CASE Half-Duplex
class uart_test_hd extends uart_test;
    `uvm_component_utils(uart_test_hd)
    
    uart_virtual_hd hd_vseqh; 
    
    function new(string name = "uart_test_hd", uvm_component parent);
        super.new(name,parent);
    endfunction
    
    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
    endfunction
    
    task run_phase(uvm_phase phase);
        phase.raise_objection(this);
            hd_vseqh = uart_virtual_hd::type_id::create("hd_vseqh");
            hd_vseqh.start(envh.v_seqrh);
        phase.drop_objection(this);
    endtask
endclass

//=======================================================TEST CASE Loop-Back-Mode
class uart_test_lbm extends uart_test;
    `uvm_component_utils(uart_test_lbm)
    
    uart_virtual_lbm lbm_vseqh; 
    
    function new(string name = "uart_test_lbm", uvm_component parent);
        super.new(name,parent);
    endfunction
    
    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
    endfunction
    
    task run_phase(uvm_phase phase);
        phase.raise_objection(this);
            lbm_vseqh = uart_virtual_lbm::type_id::create("lbm_vseqh");
            lbm_vseqh.start(envh.v_seqrh);
        phase.drop_objection(this);
    endtask
endclass

//=======================================================TEST CASE Parity Error
class uart_test_pe extends uart_test;
    `uvm_component_utils(uart_test_pe)
     
    uart_virtual_pe pe_vseqh;
    
    function new(string name = "uart_test_pe", uvm_component parent);
        super.new(name,parent);
    endfunction
    
    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
    endfunction
    
    task run_phase(uvm_phase phase);
        phase.raise_objection(this);
            pe_vseqh = uart_virtual_pe::type_id::create("pe_vseqh");
            pe_vseqh.start(envh.v_seqrh);
        phase.drop_objection(this);
    endtask
endclass

//=======================================================TEST CASE Over-run Error
class uart_test_or extends uart_test;
    `uvm_component_utils(uart_test_or)
     
    uart_virtual_or or_vseqh;
    
    function new(string name = "uart_test_or", uvm_component parent);
        super.new(name,parent);
    endfunction
    
    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
    endfunction
    
    task run_phase(uvm_phase phase);
        phase.raise_objection(this);
            or_vseqh = uart_virtual_or::type_id::create("or_vseqh");
            or_vseqh.start(envh.v_seqrh);
        phase.drop_objection(this);
    endtask
endclass

//=======================================================TEST CASE Framing Error
class uart_test_fm extends uart_test;
    `uvm_component_utils(uart_test_fm)
     
    uart_virtual_fm fm_vseqh;
    
    
    function new(string name = "uart_test_fm", uvm_component parent);
        super.new(name,parent);
    endfunction
    
    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
    endfunction
    
    task run_phase(uvm_phase phase);
        phase.raise_objection(this);
            fm_vseqh = uart_virtual_fm::type_id::create("fm_vseqh");
            fm_vseqh.start(envh.v_seqrh);
        phase.drop_objection(this);
    endtask
endclass

//=======================================================TEST CASE Break Interrupt
class uart_test_bi extends uart_test;
    `uvm_component_utils(uart_test_bi)
     
    uart_virtual_bi bi_vseqh;
    
    
    function new(string name = "uart_test_bi", uvm_component parent);
        super.new(name,parent);
    endfunction
    
    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
    endfunction
    
    task run_phase(uvm_phase phase);
        phase.raise_objection(this);
            bi_vseqh = uart_virtual_bi::type_id::create("bi_vseqh");
            bi_vseqh.start(envh.v_seqrh);
        phase.drop_objection(this);
    endtask
endclass

//=======================================================TEST CASE Time-Out
class uart_test_to extends uart_test;
    `uvm_component_utils(uart_test_to)
     
    uart_virtual_to to_vseqh;
    
    
    function new(string name = "uart_test_to", uvm_component parent);
        super.new(name,parent);
    endfunction
    
    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
    endfunction
    
    task run_phase(uvm_phase phase);
        phase.raise_objection(this);
            to_vseqh = uart_virtual_to::type_id::create("to_vseqh");
            to_vseqh.start(envh.v_seqrh);
        phase.drop_objection(this);
    endtask
endclass

//=======================================================TEST CASE THR
class uart_test_thr extends uart_test;
    `uvm_component_utils(uart_test_thr)
     
    uart_virtual_thr thr_vseqh;
    
    
    function new(string name = "uart_test_thr", uvm_component parent);
        super.new(name,parent);
    endfunction
    
    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
    endfunction
    
    task run_phase(uvm_phase phase);
        phase.raise_objection(this);
            thr_vseqh = uart_virtual_thr::type_id::create("thr_vseqh");
            thr_vseqh.start(envh.v_seqrh);
        phase.drop_objection(this);
    endtask
endclass
