//1.2
// Register bank 
// Auto generated code from toi2s version 1 
// Written by Jørgen Kragh Jakobsen, All right reserved 
//-----------------------------------------------------------------------------
`include "../rb_toi2s/rb_toi2s_struct.svh"
//import toi2s_pkg::*;

module rb_toi2s
#(parameter ADR_BITS = 8
 )
(
	input  logic				clk,
	input  logic				resetb,
	input  logic [ADR_BITS-1:0]		address,
	input  logic [7:0]			data_write_in,
	output logic [7:0] 			data_read_out,
	input  logic 				reg_en,
	input  logic 				write_en,
//---------------------------------------------
	inout rb_sys_cfg_wire_t              sys_cfg,
	inout rb_bootamp_cfg_wire_t          bootamp_cfg,
	inout rb_debug_wire_t                debug 
);
//------------------------------------------------Write to registers and reset-
// Create registers

    // --- Section: sys_cfg  Offset: 0x0000  Size: 8
reg        reg__sys_cfg__mute;                                   //Mute output
reg        reg__sys_cfg__mute_l;                                 //Mute Left
reg        reg__sys_cfg__mute_r;                                 //Mute Right
reg [7:0]  reg__sys_cfg__debug_led;                              //Debug led signals

    // --- Section: bootamp_cfg  Offset: 0x0010  Size: 16
reg [7:0]  reg__bootamp_cfg__bootmem0;                           //Bootmem send to amp on startup
reg [7:0]  reg__bootamp_cfg__bootmem1;                           //Bootmem send to amp on startup
reg [7:0]  reg__bootamp_cfg__bootmem2;                           //Bootmem send to amp on startup
reg [7:0]  reg__bootamp_cfg__bootmem3;                           //Bootmem send to amp on startup
reg [7:0]  reg__bootamp_cfg__bootmem4;                           //Bootmem send to amp on startup
reg [7:0]  reg__bootamp_cfg__bootmem5;                           //Bootmem send to amp on startup
reg [7:0]  reg__bootamp_cfg__bootmem6;                           //Bootmem send to amp on startup
reg [7:0]  reg__bootamp_cfg__bootmem7;                           //Bootmem send to amp on startup

    // --- Section: debug  Offset: 0x0020  Size: 16
reg        reg__debug__dummy_bit;                                //Dummy bit

always_ff @(posedge clk)
begin
  if (resetb == 0)
  begin

    // --- Section: sys_cfg  Offset: 0x0000  Size: 8
    reg__sys_cfg__mute                                    <=  1'b00000000;   //Mute output
    reg__sys_cfg__mute_l                                  <=  1'b00000000;   //Mute Left
    reg__sys_cfg__mute_r                                  <=  1'b00000000;   //Mute Right
    reg__sys_cfg__debug_led                               <=  8'b01010101;   //Debug led signals

    // --- Section: bootamp_cfg  Offset: 0x0010  Size: 16
    reg__bootamp_cfg__bootmem0                            <=  8'b01000000;   //Bootmem send to amp on startup
    reg__bootamp_cfg__bootmem1                            <=  8'b00011000;   //Bootmem send to amp on startup
    reg__bootamp_cfg__bootmem2                            <=  8'b01010011;   //Bootmem send to amp on startup
    reg__bootamp_cfg__bootmem3                            <=  8'b00001000;   //Bootmem send to amp on startup
    reg__bootamp_cfg__bootmem4                            <=  8'b11111111;   //Bootmem send to amp on startup
    reg__bootamp_cfg__bootmem5                            <=  8'b11111111;   //Bootmem send to amp on startup
    reg__bootamp_cfg__bootmem6                            <=  8'b11111111;   //Bootmem send to amp on startup
    reg__bootamp_cfg__bootmem7                            <=  8'b11111111;   //Bootmem send to amp on startup

    // --- Section: debug  Offset: 0x0020  Size: 16
    reg__debug__dummy_bit                                 <=  1'b00000000;   //Dummy bit
  end
  else
  begin
    if (write_en)
    begin
      case (address)
        000 : begin 
              reg__sys_cfg__mute                                <=   data_write_in[0:0];  // Mute output
              reg__sys_cfg__mute_l                              <=   data_write_in[1:1];  // Mute Left
              reg__sys_cfg__mute_r                              <=   data_write_in[2:2];  // Mute Right
              end
        003 : reg__sys_cfg__debug_led                           <=   data_write_in[7:0];  // Debug led signals
 
        016 : reg__bootamp_cfg__bootmem0                        <=   data_write_in[7:0];  // Bootmem send to amp on startup
 
        017 : reg__bootamp_cfg__bootmem1                        <=   data_write_in[7:0];  // Bootmem send to amp on startup
 
        018 : reg__bootamp_cfg__bootmem2                        <=   data_write_in[7:0];  // Bootmem send to amp on startup
 
        019 : reg__bootamp_cfg__bootmem3                        <=   data_write_in[7:0];  // Bootmem send to amp on startup
 
        020 : reg__bootamp_cfg__bootmem4                        <=   data_write_in[7:0];  // Bootmem send to amp on startup
 
        021 : reg__bootamp_cfg__bootmem5                        <=   data_write_in[7:0];  // Bootmem send to amp on startup
 
        022 : reg__bootamp_cfg__bootmem6                        <=   data_write_in[7:0];  // Bootmem send to amp on startup
 
        023 : reg__bootamp_cfg__bootmem7                        <=   data_write_in[7:0];  // Bootmem send to amp on startup
 
        032 : reg__debug__dummy_bit                             <=   data_write_in[0:0];  // Dummy bit
 
      endcase 
    end
  end
end
//---------------------------------------------
always @(posedge clk )
begin
  if (resetb == 0)
    data_read_out <= 8'b00000000;
  else
  begin
    data_read_out <= 8'b00000000;
    case (address)
        000 : begin 
              data_read_out[0:0]  <=  reg__sys_cfg__mute;                       // Mute output
              data_read_out[1:1]  <=  reg__sys_cfg__mute_l;                     // Mute Left
              data_read_out[2:2]  <=  reg__sys_cfg__mute_r;                     // Mute Right
              end
        003 : data_read_out[7:0]  <=  reg__sys_cfg__debug_led;                  // Debug led signals
 
        016 : data_read_out[7:0]  <=  reg__bootamp_cfg__bootmem0;               // Bootmem send to amp on startup
 
        017 : data_read_out[7:0]  <=  reg__bootamp_cfg__bootmem1;               // Bootmem send to amp on startup
 
        018 : data_read_out[7:0]  <=  reg__bootamp_cfg__bootmem2;               // Bootmem send to amp on startup
 
        019 : data_read_out[7:0]  <=  reg__bootamp_cfg__bootmem3;               // Bootmem send to amp on startup
 
        020 : data_read_out[7:0]  <=  reg__bootamp_cfg__bootmem4;               // Bootmem send to amp on startup
 
        021 : data_read_out[7:0]  <=  reg__bootamp_cfg__bootmem5;               // Bootmem send to amp on startup
 
        022 : data_read_out[7:0]  <=  reg__bootamp_cfg__bootmem6;               // Bootmem send to amp on startup
 
        023 : data_read_out[7:0]  <=  reg__bootamp_cfg__bootmem7;               // Bootmem send to amp on startup
 
        032 : data_read_out[0:0]  <=  reg__debug__dummy_bit;                    // Dummy bit
 
      default : data_read_out <= 8'b00000000;
    endcase
  end
end
//-------------------------------------Assign symbols to structs
assign sys_cfg.mute                             = reg__sys_cfg__mute ;
assign sys_cfg.mute_l                           = reg__sys_cfg__mute_l ;
assign sys_cfg.mute_r                           = reg__sys_cfg__mute_r ;
assign sys_cfg.debug_led                        = reg__sys_cfg__debug_led ;
assign bootamp_cfg.bootmem0                     = reg__bootamp_cfg__bootmem0 ;
assign bootamp_cfg.bootmem1                     = reg__bootamp_cfg__bootmem1 ;
assign bootamp_cfg.bootmem2                     = reg__bootamp_cfg__bootmem2 ;
assign bootamp_cfg.bootmem3                     = reg__bootamp_cfg__bootmem3 ;
assign bootamp_cfg.bootmem4                     = reg__bootamp_cfg__bootmem4 ;
assign bootamp_cfg.bootmem5                     = reg__bootamp_cfg__bootmem5 ;
assign bootamp_cfg.bootmem6                     = reg__bootamp_cfg__bootmem6 ;
assign bootamp_cfg.bootmem7                     = reg__bootamp_cfg__bootmem7 ;
assign debug.dummy_bit                          = reg__debug__dummy_bit ;
endmodule
