`timescale 1ns/10ps
module top();
    
    import test_pkg::*;
    import uvm_pkg::*;
    `include "uvm_macros.svh"
    
    bit clock1;
    bit clock2;
    
    always #5 clock1 = ~clock1;   //100MHz
    always #10 clock2 = ~clock2;  //50MHz
    wire W1, W2;
    uart_if in0(clock1);
    uart_if in1(clock2);
    
    uart_top UART1( .wb_clk_i(clock1),
	
                    .wb_rst_i(in0.WB_RST_I), .wb_adr_i(in0.WB_ADDR_I), .wb_dat_i(in0.WB_DAT_I), 
                    .wb_dat_o(in0.WB_DAT_O), .wb_we_i(in0.WB_WE_I), .wb_stb_i(in0.WB_STB_I), 
                    .wb_cyc_i(in0.WB_CYC_I), .wb_ack_o(in0.WB_ACK_O), .wb_sel_i(in0.WB_SEL_I),
                    .int_o(in0.INT_O), .stx_pad_o(W1), .srx_pad_i(W2), .baud_o(in0.BAUD_O) );
                    
    uart_top UART2( .wb_clk_i(clock2),
	
                    .wb_rst_i(in1.WB_RST_I), .wb_adr_i(in1.WB_ADDR_I), .wb_dat_i(in1.WB_DAT_I), 
                    .wb_dat_o(in1.WB_DAT_O), .wb_we_i(in1.WB_WE_I), .wb_stb_i(in1.WB_STB_I), 
                    .wb_cyc_i(in1.WB_CYC_I), .wb_ack_o(in1.WB_ACK_O), .wb_sel_i(in1.WB_SEL_I),
                    .int_o(in1.INT_O), .stx_pad_o(W2), .srx_pad_i(W1), .baud_o(in1.BAUD_O) );
	
    
    initial
        begin
            uvm_config_db #(virtual uart_if) :: set(null,"*","vif_0",in0);
            uvm_config_db #(virtual uart_if) :: set(null,"*","vif_1",in1);
            run_test();
            
        end
endmodule   