class avst_agent extends uvm_agent;
    `uvm_component_utils(avst_agent)

    function new (string name = "avst_agent", uvm_component parent = null);
        super.new(name, parent);
    endfunction

    avst_driver avst_driver_inst;
    uvm_sequencer #(avst_sink_sequence_item) seq0;
    avst_monitor avst_monitor_inst;

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);

        seq0 = uvm_sequencer #(avst_sink_sequence_item)::type_id::create("seq0", this);
        avst_driver_inst = avst_driver::type_id::create("avst_driver_inst", this);
        avst_monitor_inst = avst_monitor::type_id::create("avst_monitor_inst", this);
    endfunction


    //коннектим секвенсор к драйверу
    virtual function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
        avst_driver_inst.seq_item_port.connect(seq0.seq_item_export);
    endfunction

endclass