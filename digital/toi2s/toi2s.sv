//  O-Audio controller 
//  
//  Splits an audio single datastream to audio and controllogic 
//  Written by Jørgen Kragh Jakobsen, November 2021

module toi2s (
    input clk,
    input btn1_reset,     //! Push button reset on fpga board - input on TinyTapeout    
    input btn2,
    output [5:0] debug_led, //! Debug led on fpga board 
   
    input rx_in,    //! Optial input from spdif source 
    
    //Interface to MA12070P, fully integrated class D amplifier 
    input nerror_in,  //! Error signal from amplifier
    
    output i2s_bck,   //! I2S clock signal
    output i2s_ws,    //! I2S word select signal
    output i2s_d0,    //! I2S data signal

    inout i2c_sda,    //! I2C data to/from amplifier 
    inout i2c_scl,    //! I2C clock to amplifier
   
    output nenable_out, //! Enable signal to amplifier
    output nmute_out,  //! Mute signal to amplifier
        
    output rx_out    //! Output from spdif decoder
    
    );

    wire resetb; 
    assign resetb = ~btn1_reset;

    assign debug_led = (btn2 == 1'b0) ? 6'b110011 : 6'b001100;

    wire audio_locked;
    wire send_config;
    wire rx_out_tmp;
    wire i2s_bck_tmp, i2s_ws_tmp, i2s_d0_tmp; 
    
    spdif_decoder spdif(
      .clk_in(clk),
      .resetb(resetb),
      .rx_in(rx_in),
      .i2s_bck(i2s_bck_tmp),
      .i2s_ws(i2s_ws_tmp),
      .i2s_d0(i2s_d0_tmp),
      .audio_locked(audio_locked),
      .edgedetect(rx_out_tmp)); 
   
    assign i2s_d0 = i2s_d0_tmp & nmute_out;
    assign i2s_ws = i2s_ws_tmp & nmute_out;
    assign i2s_bck = i2s_bck_tmp & nmute_out;
    
    assign rx_out = rx_out_tmp; 

    amp_state_control ctrl ( 
        .clk_in(clk),
        .resetb(resetb),
        .audio_locked_in(audio_locked),
        .nerror_in(nerror_in), 
        .nenable_out(nenable_out),
        .nmute_out(nmute_out),
        .send_config_out(send_config)); 
        
    amp_i2c_master i2c_amp (
        .clk_in(clk),
        .resetb(resetb),
        .send_cfg(send_config),
        .sda(i2c_sda),
        .scl(i2c_scl)); 
    //assign nenable_out = send_config;  
endmodule