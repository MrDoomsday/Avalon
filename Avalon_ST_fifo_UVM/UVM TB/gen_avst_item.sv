class gen_avst_item extends uvm_sequence;
    `uvm_object_utils(gen_avst_item)

    function new (string name = "gen_avst_item");
        super.new(name);
    endfunction

    rand int num;//size one packet
    constraint constr_num {num inside {[1:40]}; };


    virtual task body();


        for (int i = 0; i < num; i++) begin
            avst_sink_sequence_item m_item = avst_sink_sequence_item::type_id::create("m_item");
            start_item(m_item);
            m_item.randomize();
            
            
            if(i == 0) begin//первое слово - старт пакета
                m_item.sop = 1'b1;
                m_item.valid = 1'b1;
            end
            else begin
                m_item.sop = 1'b0;
                m_item.sop = 1'b0;
            end

            if(i == num - 1) begin//подбежали к концу пакета
                m_item.valid = 1'b1;
                m_item.eop = 1'b1; 
            end
            else begin
                m_item.eop = 1'b0;
                m_item.empty = 'h0; 
            end

            m_item.print();//печатаем содержимое сгенерированного пакетика
            finish_item(m_item);
        end
        `uvm_info("SEQ", $sformatf("Done generation packet size = %0d", num), UVM_LOW);
    endtask

endclass