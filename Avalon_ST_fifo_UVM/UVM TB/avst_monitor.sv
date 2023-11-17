class avst_monitor extends uvm_monitor;
    `uvm_component_utils(avst_monitor)

    function new (string name = "avst_monitor", uvm_component parent = null);
        super.new(name, parent);
    endfunction

    //объявляем виртуальный интерфейс
    virtual avst_if avst_sink_vif;
    virtual avst_if avst_source_vif;

    uvm_analysis_port #(avst_sink_sequence_item) mon_analysis_port_avsi;
    uvm_analysis_port #(avst_source_sequence_item) mon_analysis_port_avso;
    


    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        if(!uvm_config_db#(virtual avst_if)::get(this, "", "avst_sink_vir", avst_sink_vif))//вытаскиваем двайвер из фабрики по имени
            `uvm_fatal("DRV", "Could not get virtual avst_sink_vir interface")

        if(!uvm_config_db#(virtual avst_if)::get(this, "", "avst_source_vir", avst_source_vif))//вытаскиваем двайвер из фабрики по имени
            `uvm_fatal("DRV", "Could not get virtual avst_source_vir interface")

        mon_analysis_port_avsi = new("mon_analysis_port_avsi", this);
        mon_analysis_port_avso = new("mon_analysis_port_avso", this);
    endfunction



virtual task run_phase(uvm_phase phase);
    super.run_phase(phase);
    forever begin
        @(posedge avst_sink_vif.clk);
        if(avst_sink_vif.ready && avst_sink_vif.valid) begin
            avst_sink_sequence_item item_sink = new;
            item_sink.channel = avst_sink_vif.channel;
            item_sink.data = avst_sink_vif.data;
            item_sink.valid = avst_sink_vif.valid;
            item_sink.sop = avst_sink_vif.sop;
            item_sink.eop = avst_sink_vif.eop;
            item_sink.empty = avst_sink_vif.empty;
            `uvm_info("MON", $sformatf("Monitor found packet for avsi interface"), UVM_LOW);
            mon_analysis_port_avsi.write(item_sink);
        end
        
        if(avst_source_vif.ready && avst_source_vif.valid) begin
            avst_source_sequence_item item_source = new;
            item_source.channel = avst_source_vif.channel;
            item_source.data = avst_source_vif.data;
            item_source.valid = avst_source_vif.valid;
            item_source.sop = avst_source_vif.sop;
            item_source.eop = avst_source_vif.eop;
            item_source.empty = avst_source_vif.empty;
            `uvm_info("MON", $sformatf("Monitor found packet for avso interface"), UVM_LOW);
            mon_analysis_port_avso.write(item_source);
        end
    end
endtask




endclass