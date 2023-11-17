class avst_test extends uvm_test;
    `uvm_component_utils(avst_test)

    function new (string name = "avst_test", uvm_component parent = null);
        super.new(name, parent);
    endfunction

    avst_env avst_env_inst;
    //объявляем виртуальный интерфейс
    virtual avst_if avst_vif;


    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        avst_env_inst = avst_env::type_id::create("avst_env_inst", this);
        if(!uvm_config_db#(virtual avst_if)::get(this, "", "avst_sink_vir", avst_vif))//вытаскиваем двайвер из фабрики по имени
            `uvm_fatal("TEST", "Could not get virtual interface")

        //uvm_config_db#(virtual avst_if)::set(this, "avst_env_inst.avst_agent_inst.*", "avst_sink_vir", avst_vif);//этот этап мне не совсем понятен если честно
        /*
        как оказалось работает и без этого участка кода, не совсем понятно чем он занимался, по факту должен был инициализировать интерфейс в агенте? Но ведь там имеется извлечение из фабрики
        */
    endfunction


    virtual task run_phase(uvm_phase phase);
        gen_avst_item avst_item_seq = gen_avst_item::type_id::create("avst_item_seq");

        //генерим кучу транзакций с разными длинами пакетов, для полноценной проверки
        for (int i = 1; i < 100; i++) begin
            phase.raise_objection(this);
            if(i== 1) begin
                apply_reset();
                #200;
            end
            avst_item_seq.randomize() with {num inside {[1:i]}; };
            avst_item_seq.start(avst_env_inst.avst_agent_inst.seq0);
            phase.drop_objection(this);
        end
        #2000;
    endtask


    virtual task apply_reset();
        avst_vif.reset_n <= 1'b0;
        repeat(10) @ (posedge avst_vif.clk);
        avst_vif.reset_n <= 1'b1;
        repeat(10) @ (posedge avst_vif.clk);
    endtask;

endclass