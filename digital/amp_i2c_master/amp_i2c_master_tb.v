// Testbench i2c_master block for amp frontend 
// Simulate:
//   Send off i2c config setting when triggered 
// 
// Copyright Jørgen Kragh Jakobsen, November 2021 

`timescale 1ns/1ns


module amp_i2c_master_tb();

reg clk, resetb;
reg send_cfg;

amp_i2c_master dut(clk,resetb,send_cfg,
                   i2c_sda,i2c_scl);
                   
initial 
begin 
    clk=0;
  forever #10 clk=~clk;     // 50 MHz
end


initial
begin
 
 $dumpfile( "amp_i2c_master_tb.vcd") ;

 $dumpvars(0,amp_i2c_master_tb);
 resetb        = 1;
 send_cfg     = 0;
 #1000;
 resetb = 0;
  
 #1000;
 resetb = 1;
 
 #20000; 
 send_cfg = 1; 

 #400000;
 $display("End");
 $finish;
end

endmodule 