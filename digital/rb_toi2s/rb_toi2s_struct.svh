
// Interface structures for registerbank symbol access

// Wire interface for sys_cfg
typedef struct packed {
  logic       mute;                            // Mute output
  logic       mute_l;                          // Mute Left
  logic       mute_r;                          // Mute Right
  logic [7:0] debug_led;                       // Debug led signals
} rb_sys_cfg_wire_t;

// Wire interface for bootamp_cfg
typedef struct packed {
  logic [7:0] bootmem0;                        // Bootmem send to amp on startup
  logic [7:0] bootmem1;                        // Bootmem send to amp on startup
  logic [7:0] bootmem2;                        // Bootmem send to amp on startup
  logic [7:0] bootmem3;                        // Bootmem send to amp on startup
  logic [7:0] bootmem4;                        // Bootmem send to amp on startup
  logic [7:0] bootmem5;                        // Bootmem send to amp on startup
  logic [7:0] bootmem6;                        // Bootmem send to amp on startup
  logic [7:0] bootmem7;                        // Bootmem send to amp on startup
} rb_bootamp_cfg_wire_t;

// Wire interface for debug
typedef struct packed {
  logic       dummy_bit;                       // Dummy bit
} rb_debug_wire_t;

