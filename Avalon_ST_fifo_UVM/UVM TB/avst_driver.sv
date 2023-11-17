class avst_driver extends uvm_driver#(avst_sink_sequence_item);
    `uvm_component_utils(avst_driver)

    function new (string name = "avst_driver", uvm_component parent = null);
        super.new(name, parent);
    endfunction

    //объявляем виртуальный интерфейс
    virtual avst_if avst_sink_vif;
    virtual avst_if avst_source_vif;


    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        if(!uvm_config_db#(virtual avst_if)::get(this, "", "avst_sink_vir", avst_sink_vif))//вытаскиваем двайвер из фабрики по имени
            `uvm_fatal("DRV", "Could not get virtual avst_sink_vir interface")

        if(!uvm_config_db#(virtual avst_if)::get(this, "", "avst_source_vir", avst_source_vif))//вытаскиваем двайвер из фабрики по имени
            `uvm_fatal("DRV", "Could not get virtual avst_source_vir interface")

        

        avst_sink_vif.channel <= 'h0;
        avst_sink_vif.data <= 'h0;
        avst_sink_vif.valid <= 1'b0;
        avst_sink_vif.sop <= 1'b0;
        avst_sink_vif.eop <= 1'b0;
        avst_sink_vif.empty <= 'h0;
    endfunction

    virtual task run_phase(uvm_phase phase);
        super.run_phase(phase);

        forever begin
            avst_sink_sequence_item m_item;
            `uvm_info("DRV", $sformatf("Wait item from sequence"), UVM_LOW)
            seq_item_port.get_next_item(m_item);
            drive_item(m_item);
            seq_item_port.item_done();
        end
    endtask

    virtual task drive_item(avst_sink_sequence_item m_item);
        avst_sink_vif.channel <= m_item.channel;
        avst_sink_vif.data <= m_item.data;
        avst_sink_vif.valid <= m_item.valid;
        avst_sink_vif.sop <= m_item.sop;
        avst_sink_vif.eop <= m_item.eop;
        avst_sink_vif.empty <= m_item.empty;
        
        if(avst_sink_vif.ready) @(posedge avst_sink_vif.clk);
        else begin
            while(!avst_sink_vif.ready) begin
                `uvm_info("DRV", $sformatf("Wait ready from DUT"), UVM_LOW)
                @(posedge avst_sink_vif.clk);
            end
            @(posedge avst_sink_vif.clk);
        end
        /*
        @(posedge avst_sink_vif.clk);//здесь аккуратнее
        while(!avst_sink_vif.ready) begin
            `uvm_info("DRV", $sformatf("Wait ready from DUT"), UVM_LOW);
            @(posedge avst_sink_vif.clk);
        end*/
        avst_sink_vif.channel <= 'h0;
        avst_sink_vif.data <= 'h0;
        avst_sink_vif.valid <= 1'b0;
        avst_sink_vif.sop <= 1'b0;
        avst_sink_vif.eop <= 1'b0;
        avst_sink_vif.empty <= 'h0;
    endtask

endclass