class uart_virtual_base_seqs extends uvm_sequence#(uvm_sequence_item);
    `uvm_object_utils(uart_virtual_base_seqs)
    
    u1_FD_seq FD1_h;
    u2_FD_seq FD2_h;
    
    u1_HD_seq HD1_h;
    u2_HD_seq HD2_h;
    
    u1_LBM_seq LBM1_h;
    u2_LBM_seq LBM2_h;
    
//  ERROR TEST-CASE SEQS    
    u1_PE_seq PE1_h;
    u2_PE_seq PE2_h;
    
    u1_OR_seq OR1_h;
    u2_OR_seq OR2_h;
    
    u1_FM_seq FM1_h;
    u2_FM_seq FM2_h;
    
    u1_BI_seq BI1_h;
    u2_BI_seq BI2_h;
    
    u1_TO_seq TO1_h;
    u2_TO_seq TO2_h;
    
    u1_THR_seq THR1_h;
    u2_THR_seq THR2_h;
    
    uart_seqr seqrh[];
    uart_virtual_seqr v_seqrh;
    uart_env_config tb_cfg;
    
    function new(string name = "uart_virtual_base_seqs");
        super.new(name);
    endfunction
    
    task body();
        begin            
            if(!uvm_config_db #(uart_env_config) :: get(null,get_full_name(),"uart_env_config",tb_cfg))
                `uvm_fatal(get_type_name(), "Couldn't get ENV CONFIG")
            
            if(!$cast(v_seqrh,m_sequencer))
                `uvm_fatal(get_type_name(),"Couldn't CAST V_SEQUENCER")
            
            seqrh = new[tb_cfg.no_of_agents];
            foreach(seqrh[i])
                begin
                    seqrh[i] = v_seqrh.seqrh[i];
                end
        end
    endtask
    
endclass
//=======================================================Full-Duplex V-SEQS
class uart_virtual_fd extends uart_virtual_base_seqs;
    `uvm_object_utils(uart_virtual_fd)
    
    function new(string name = "uart_virtual_fd");
        super.new(name);
    endfunction
    
    task body();
        super.body();
        fork
            begin
                if(tb_cfg.has_agent)
                    fork
                        begin
                            FD1_h = u1_FD_seq::type_id::create("FD1_h");
                            FD1_h.start(seqrh[0]);
                        end
                        begin
                            FD2_h = u2_FD_seq::type_id::create("FD2_h");
                            FD2_h.start(seqrh[1]);
                        end
                    join
            end
        join
    endtask
endclass
//=======================================================Half-Duplex V-SEQS
class uart_virtual_hd extends uart_virtual_base_seqs;
    `uvm_object_utils(uart_virtual_hd)
    
    function new(string name = "uart_virtual_hd");
        super.new(name);
    endfunction
    //UART1 Transmitting and UART2 Receiving
    task body();
        super.body();
        fork
            begin
                if(tb_cfg.has_agent)
                    fork
                        begin
                            HD1_h = u1_HD_seq::type_id::create("HD1_h");
                            HD1_h.start(seqrh[0]);
                        end
                        begin
                            HD2_h = u2_HD_seq::type_id::create("HD2_h");
                            HD2_h.start(seqrh[1]);
                        end
                    join
            end
        join
    endtask
endclass

//=======================================================Loop-Back-Mode V-SEQS

class uart_virtual_lbm extends uart_virtual_base_seqs;
    `uvm_object_utils(uart_virtual_lbm)
    
    function new(string name = "uart_virtual_lbm");
        super.new(name);
    endfunction
    //LOOP_BACK_MODE
    task body();
        super.body();
        fork
            begin
                if(tb_cfg.has_agent)
                    fork
                        begin
                            LBM1_h = u1_LBM_seq::type_id::create("LBM1_h");
                            LBM1_h.start(seqrh[0]);
                        end
                        begin
                            LBM2_h = u2_LBM_seq::type_id::create("LBM2_h");
                            LBM2_h.start(seqrh[1]);
                        end
                    join
            end
        join
    endtask
endclass

//=======================================================Parity Error V-SEQS
class uart_virtual_pe extends uart_virtual_base_seqs;
    `uvm_object_utils(uart_virtual_pe)
    
    function new(string name = "uart_virtual_pe");
        super.new(name);
    endfunction
    //PARITY ERROR SEQS
    task body();
        super.body();
        fork
            begin
                if(tb_cfg.has_agent)
                    fork
                        begin
                            PE1_h = u1_PE_seq::type_id::create("PE1_h");
                            PE1_h.start(seqrh[0]);
                        end
                        begin
                            PE2_h = u2_PE_seq::type_id::create("PE2_h");
                            PE2_h.start(seqrh[1]);
                        end
                    join
            end
        join
    endtask
endclass

class uart_virtual_or extends uart_virtual_base_seqs;
    `uvm_object_utils(uart_virtual_or)
    
    function new(string name = "uart_virtual_or");
        super.new(name);
    endfunction
    //OVERRUN ERROR SEQS
    task body();
        super.body();
            begin
                if(tb_cfg.has_agent)
                    fork
                        begin
                            OR1_h = u1_OR_seq::type_id::create("OR1_h");
                            OR1_h.start(seqrh[0]);
                        end
                        begin
                            OR2_h = u2_OR_seq::type_id::create("OR2_h");
                            OR2_h.start(seqrh[1]);
                        end
                    join
            end
    endtask
endclass

//=======================================================FRAMING ERROR V-SEQS
class uart_virtual_fm extends uart_virtual_base_seqs;
    `uvm_object_utils(uart_virtual_fm)
    
    function new(string name = "uart_virtual_fm");
        super.new(name);
    endfunction
    //FRAMING ERROR SEQS
    task body();
        super.body();
        fork
            begin
                if(tb_cfg.has_agent)
                    fork
                        begin
                            FM1_h = u1_FM_seq::type_id::create("FM1_h");
                            FM1_h.start(seqrh[0]);
                        end
                        begin
                            FM2_h = u2_FM_seq::type_id::create("FM2_h");
                            FM2_h.start(seqrh[1]);
                        end
                    join
            end
        join
    endtask
endclass

//=======================================================BREAK INTERRUPT V-SEQS
class uart_virtual_bi extends uart_virtual_base_seqs;
    `uvm_object_utils(uart_virtual_bi)
    
    function new(string name = "uart_virtual_bi");
        super.new(name);
    endfunction
    //BREAK INTERRUPT SEQS
    task body();
        super.body();
        fork
            begin
                if(tb_cfg.has_agent)
                    fork
                        begin
                            BI1_h = u1_BI_seq::type_id::create("BI1_h");
                            BI1_h.start(seqrh[0]);
                        end
                        begin
                            BI2_h = u2_BI_seq::type_id::create("BI2_h");
                            BI2_h.start(seqrh[1]);
                        end
                    join
            end
        join
    endtask
endclass

//=======================================================TIME-OUT V-SEQS
class uart_virtual_to extends uart_virtual_base_seqs;
    `uvm_object_utils(uart_virtual_to)
    
    function new(string name = "uart_virtual_to");
        super.new(name);
    endfunction
    //TIME-OUT SEQS
    task body();
        super.body();
        fork
            begin
                if(tb_cfg.has_agent)
                    fork
                        begin
                            TO1_h = u1_TO_seq::type_id::create("TO1_h");
                            TO1_h.start(seqrh[0]);
                        end
                        begin
                            TO2_h = u2_TO_seq::type_id::create("TO2_h");
                            TO2_h.start(seqrh[1]);
                        end
                    join
            end
        join
    endtask
endclass


class uart_virtual_thr extends uart_virtual_base_seqs;
    `uvm_object_utils(uart_virtual_thr)
    
    function new(string name = "uart_virtual_thr");
        super.new(name);
    endfunction
    //THR-EMPTY SEQS
    task body();
        super.body();
        fork
            begin
                if(tb_cfg.has_agent)
                    fork
                        begin
                            THR1_h = u1_THR_seq::type_id::create("THR1_h");
                            THR1_h.start(seqrh[0]);
                        end
                        begin
                            THR2_h = u2_THR_seq::type_id::create("THR2_h");
                            THR2_h.start(seqrh[1]);
                        end
                    join
            end
        join
    endtask
endclass

