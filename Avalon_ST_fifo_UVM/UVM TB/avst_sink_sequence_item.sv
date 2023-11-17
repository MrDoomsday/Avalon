class avst_sink_sequence_item extends uvm_sequence_item;

    rand bit [`CHANNEL_WIDTH-1:0] channel;
    rand bit [`DATA_WIDTH-1:0] data;
    rand bit valid;
    rand bit sop;
    rand bit eop;
    rand bit [`EMPTY_WIDTH-1:0] empty;
    bit ready;

  // Use utility macros to implement standard functions
  // like print, copy, clone, etc
  `uvm_object_utils_begin(avst_sink_sequence_item)
  	`uvm_field_int (channel, UVM_DEFAULT)
  	`uvm_field_int (data, UVM_DEFAULT)
  	`uvm_field_int (valid, UVM_DEFAULT)
  	`uvm_field_int (sop, UVM_DEFAULT)
    `uvm_field_int (eop, UVM_DEFAULT)
    `uvm_field_int (empty, UVM_DEFAULT)
    //`uvm_field_int (ready, UVM_DEFAULT)
  `uvm_object_utils_end

function new (string name = "avst_sink_sequence_item");
    super.new(name);
endfunction


endclass