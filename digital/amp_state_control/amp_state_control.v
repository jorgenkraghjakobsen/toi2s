module amp_state_control (
    input clk_in,
    input resetb,
    input audio_locked_in,
    input nerror_in,
    output nenable_out, 
    output nmute_out,
    output send_config_out);
  
  wire mute;
  wire enable_delayed; 
  wire timer_timeout;
  reg send_config,         send_config_next;  
  reg send_config_delayed, send_config_delayed_next;
  reg timer_start,         timer_start_next;
  reg nenable_reg,         nenable_reg_next;

  
  timer_simple tim(
      .clk_in(clk_in),
      .resetb(resetb),
      .timer_start(timer_start),
      .timer_timeout(timer_timeout)); 

  localparam [3:0] // Amp states 
    INIT_ST          = 4'b0000,
    ENABLED_0_ST     = 4'b0001,
    ENABLED_1_ST     = 4'b0010,
    ENABLED_WAIT_ST  = 4'b0011,
    SEND_CFG_0_ST    = 4'b0100,
    SEND_CFG_1_ST    = 4'b0101,
    SEND_CFG_WAIT_ST = 4'b0110,
    UNMUTE_ST        = 4'b0111,
    MUTE_ST          = 4'b1000; 

  reg [3:0] amp_state_reg,  amp_state_next; 
  
  always @(posedge clk_in , negedge resetb)
  begin 
    if (!resetb) 
    begin
      amp_state_reg <= INIT_ST; 
      send_config         <= 1'b0;
      send_config_delayed <= 1'b0;
      nenable_reg         <= 1'b1;
      timer_start         <= 1'b0;
    end 
    else 
    begin
      amp_state_reg <= amp_state_next; 
      send_config          <= send_config_next;  
      send_config_delayed  <= send_config_delayed_next;
      timer_start          <= timer_start_next;
      nenable_reg          <= nenable_reg_next; 
    end
  end 

  always @* 
  begin  
    amp_state_next           = amp_state_reg;
    send_config_next         = send_config; 
    send_config_delayed_next = send_config_delayed;
    timer_start_next         = timer_start;
    nenable_reg_next         = nenable_reg; 

    case(amp_state_reg) 
      INIT_ST : // Startup system 
        begin
          send_config_next         = 1'b0;  
          send_config_delayed_next = 1'b0;
          nenable_reg_next         = 1'b1;
          timer_start_next         = 1'b0;
          amp_state_next      = ENABLED_0_ST; 
        end
      ENABLED_0_ST: 
        begin 
         send_config_next         = 1'b0;  
         send_config_delayed_next = 1'b0;
         nenable_reg_next         = 1'b0;
         timer_start_next         = 1'b1;   
         amp_state_next      = ENABLED_1_ST; 
        end 
      ENABLED_1_ST: 
        begin 
         send_config_next         = 1'b0;  
         send_config_delayed_next = 1'b0;
         nenable_reg_next         = 1'b0;
         timer_start_next         = 1'b0;   
         amp_state_next      = ENABLED_WAIT_ST; 
        end 
      
      ENABLED_WAIT_ST: 
        begin 
         send_config_next         = 1'b0;  
         send_config_delayed_next = 1'b0;
         nenable_reg_next         = 1'b0;
         timer_start_next         = 1'b0;   
         if(timer_timeout) 
         begin 
             amp_state_next = SEND_CFG_0_ST; 
         end 
        end

      SEND_CFG_0_ST:
        begin
          send_config_next         = 1'b1;  
          send_config_delayed_next = 1'b0;
          nenable_reg_next         = 1'b0;
          timer_start_next         = 1'b1;
          amp_state_next    = SEND_CFG_1_ST; 
        end
      
      SEND_CFG_1_ST:
        begin
          send_config_next         = 1'b1;  
          send_config_delayed_next = 1'b0;
          nenable_reg_next         = 1'b0;
          timer_start_next         = 1'b0;
          amp_state_next   = SEND_CFG_WAIT_ST; 
        end
      
      SEND_CFG_WAIT_ST: 
        begin
          send_config_next         = 1'b1;  
          send_config_delayed_next = 1'b0;
          nenable_reg_next         = 1'b0;
          timer_start_next         = 1'b0;
          if (timer_timeout) 
            amp_state_next = UNMUTE_ST; 
          else  
            amp_state_next = SEND_CFG_WAIT_ST; 
        end

      UNMUTE_ST: 
        begin
         send_config_next         = 1'b0;  
         send_config_delayed_next = 1'b1;
         nenable_reg_next         = 1'b0;
         timer_start_next         = 1'b0;
         if (nerror_in) 
           amp_state_next = MUTE_ST; 
         else  
           amp_state_next = UNMUTE_ST; 
        end
    endcase
  end 
  assign nenable_out = nenable_reg ; 
  assign mute      = ~audio_locked_in | ~send_config_delayed;  
  assign nmute_out = ~mute;  
  assign send_config_out = send_config; 
endmodule 