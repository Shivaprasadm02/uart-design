class uart_xtn extends uvm_sequence_item;
    `uvm_object_utils(uart_xtn)
    
    rand bit [2:0] address;
    rand bit [3:0] select;    
    rand bit write_enb;
    rand bit strobe;
    rand bit cycle;
    
    rand bit [7:0] data_in;
    
    logic [7:0] data_out;
    logic ackw;
    
    rand enum {TYPE,LCR,DLRMSB,DLRLSB,THR,RB,IER,IIR,FCR,MCR,LSR}regs;
    
    //REISTERS
    bit [7:0] THR_REG [$];
    bit [7:0] RB_REG [$];
    bit [7:0] LCR_REG;
    bit [7:0] DLR_REG;
    bit [7:0] MCR_REG;
    bit [7:0] IIR_REG;
    bit [7:0] IER_REG;
    bit [7:0] LSR_REG;
    bit [7:0] FCR_REG;
    
    function new(string name = "uart_xtn");
        super.new(name);
    endfunction
    
    function void do_print(uvm_printer printer);
        super.do_print(printer);
        
        printer.print_generic("REGISTER", "regs", $bits(regs), regs.name);
        printer.print_field("ADDRESS",  this.address,   5, UVM_BIN);
        printer.print_field("ENABLE",   this.write_enb, 1, UVM_BIN);          
                
        printer.print_field("LCR_REG",  this.LCR_REG,   8, UVM_BIN);
        printer.print_field("DLR_REG",  this.DLR_REG,   8, UVM_DEC);
        printer.print_field("IER_REG",  this.IER_REG,   8, UVM_BIN);
        printer.print_field("FCR_REG",  this.FCR_REG,   8, UVM_BIN);
        if(write_enb == 1 && address == 4)
            printer.print_field("MCR_REG",  this.MCR_REG,   8, UVM_BIN);
        printer.print_field("IIR_REG",  this.IIR_REG,   8, UVM_BIN);
        if(write_enb == 0 && address == 5)
            printer.print_field("LSR_REG",  this.LSR_REG,   8, UVM_BIN); 
        foreach(THR_REG[i])
            printer.print_field($sformatf("THR_REG[%0d]",i),  this.THR_REG[i],   8, UVM_DEC);
        foreach(RB_REG[j])
            printer.print_field($sformatf("RB_REG[%0d]",j),  this.RB_REG[j],   8, UVM_DEC);
                
    endfunction
endclass