class avst_env extends uvm_env;
    `uvm_component_utils(avst_env)

    function new (string name = "avst_env", uvm_component parent = null);
        super.new(name, parent);
    endfunction

    avst_agent avst_agent_inst;
    avst_scoreboard avst_scoreboard_inst;


    virtual function void connect_phase(uvm_phase phase);
        super.build_phase(phase);
        avst_agent_inst.avst_monitor_inst.mon_analysis_port_avsi.connect(avst_scoreboard_inst.sink_analysis_imp);
        avst_agent_inst.avst_monitor_inst.mon_analysis_port_avso.connect(avst_scoreboard_inst.source_analysis_imp);
    endfunction

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        avst_agent_inst = avst_agent::type_id::create("avst_agent_inst", this);
        avst_scoreboard_inst = avst_scoreboard::type_id::create("avst_scoreboard_inst", this);
    endfunction



endclass