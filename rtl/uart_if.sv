`timescale 1ns/10ps
interface uart_if(input bit clock);
    logic WB_RST_I;
    logic [2:0] WB_ADDR_I;
    logic [3:0] WB_SEL_I;
    logic [7:0] WB_DAT_I;
    logic [7:0] WB_DAT_O;
    logic WB_WE_I;
    logic WB_STB_I;
    logic WB_CYC_I;
    logic WB_ACK_O;
    logic INT_O;
    logic BAUD_O;
    
    clocking drv_cb@(posedge clock);
    
        default input #1 output #1;
        output WB_RST_I;
        output WB_ADDR_I;
        output WB_SEL_I;
        output WB_DAT_I;
        output WB_WE_I;
        output WB_STB_I;
        output WB_CYC_I;
        
        input  WB_ACK_O;
        input  INT_O;
        input  WB_DAT_O;
        
    endclocking

    clocking mon_cb@(posedge clock);
    
        default input #1 output #1;
        input WB_RST_I;
        input WB_ADDR_I;
        input WB_SEL_I;
        input WB_DAT_I;
        input WB_WE_I;
        input WB_STB_I;
        input WB_CYC_I;
        
        input WB_DAT_O;
        input WB_ACK_O;
        input  INT_O;
    
    endclocking
    
    modport DRV(clocking drv_cb);
    modport MON(clocking mon_cb);
    
endinterface