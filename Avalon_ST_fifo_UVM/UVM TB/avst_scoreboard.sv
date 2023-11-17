//добавляем два метода write
`uvm_analysis_imp_decl(_sink)
`uvm_analysis_imp_decl(_source)

class avst_scoreboard extends uvm_scoreboard;
    `uvm_component_utils(avst_scoreboard)


    function new (string name = "avst_scoreboard", uvm_component parent = null);
        super.new(name, parent);
    endfunction


    avst_sink_sequence_item sink_item[$];//хранилище для пришедших транзакций, которые подавались на DUT
    //avst_source_sequence_item source_item[$];

    //для приема транзакций 
    uvm_analysis_imp_sink #(avst_sink_sequence_item, avst_scoreboard) sink_analysis_imp;
    uvm_analysis_imp_source #(avst_source_sequence_item, avst_scoreboard) source_analysis_imp;
    

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        sink_analysis_imp = new("sink_analysis_imp", this);
        source_analysis_imp = new("source_analysis_imp", this);
    endfunction


    virtual function write_sink(avst_sink_sequence_item snk_item);
        if(snk_item.valid) begin
            sink_item.push_back(snk_item);
            `uvm_info("SCB", $sformatf("Scoreboard receive transaction"), UVM_LOW)
        end
    endfunction

    virtual function write_source(avst_source_sequence_item src_item);
        if(src_item.valid) begin
            avst_sink_sequence_item snk_item = new;
            snk_item = sink_item.pop_front();

            if((src_item.channel == snk_item.channel) && 
            (src_item.data == snk_item.data) && 
            (src_item.sop == snk_item.sop) && 
            (src_item.eop == snk_item.eop) && 
            (src_item.empty == snk_item.empty)) begin
                `uvm_info("SCB", $sformatf("Transaction OK"), UVM_LOW)
            end
            else begin
                `uvm_info("SCB", $sformatf("Transaction FAIL"), UVM_LOW)
                src_item.print();
                snk_item.print();
                `uvm_fatal("SCB", "Transaction failed")
            end
        end
    endfunction

endclass