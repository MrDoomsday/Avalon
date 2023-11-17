class avst_source_sequence_item extends uvm_sequence_item;

    bit [`CHANNEL_WIDTH-1:0] channel;
    bit [`DATA_WIDTH-1:0] data;
    bit valid;
    bit sop;
    bit eop;
    bit [`EMPTY_WIDTH-1:0] empty;
    bit ready;

  // Use utility macros to implement standard functions
  // like print, copy, clone, etc
  `uvm_object_utils_begin(avst_source_sequence_item)
  	`uvm_field_int (channel, UVM_DEFAULT)
  	`uvm_field_int (data, UVM_DEFAULT)
  	`uvm_field_int (valid, UVM_DEFAULT)
  	`uvm_field_int (sop, UVM_DEFAULT)
    `uvm_field_int (eop, UVM_DEFAULT)
    `uvm_field_int (empty, UVM_DEFAULT)
    //`uvm_field_int (ready, UVM_DEFAULT)
  `uvm_object_utils_end

function new (string name = "avst_source_sequence_item");
    super.new(name);
endfunction


endclass