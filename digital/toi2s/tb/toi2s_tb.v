// Test bench: Amplifier Frontend 
// Simulate:
//   Startup process 
//   Error conditon on amp (glitch/amp reset) 
// Copyright Jørgen Kragh Jakobsen, November 2021 

`define FPGA

`timescale 1ns/1ns
module toi2s_tb();


reg clk, resetb;
reg nerror_in;
reg enable_input = 1;
reg rx_in;

wire rx_gated; 
assign rx_gated = (enable_input) ? rx_in : 0 ;    

toi2s dut(clk,
          resetb,
          rx_gated,
          nerror_in,
          i2s_bck, 
          i2s_ws, 
          i2s_d0, 
          i2c_sda, 
          i2c_scl, 
          nenable_out,
          nmute_out,
          rx_out );

          initial 
begin 
    clk=0;
  forever #10 clk=~clk;     // 50 MHz
end

initial
begin
    rx_in = 0 ; 
  forever #162 rx_in = ~rx_in; 
end     

initial
begin
 $dumpfile( "toi2s_tb.vcd" );
 $dumpvars;
 $display("hello");
 resetb       = 1;
 nerror_in    = 1;
 enable_input = 0;
 
 #200;
 resetb=0;

 #400;
 resetb=1;
#1000000;   
 enable_input = 1;
 #1000000;
 $display("End");
 $finish;
end

endmodule 