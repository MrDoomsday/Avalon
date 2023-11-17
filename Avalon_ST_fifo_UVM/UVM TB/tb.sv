import uvm_pkg::*;
`include "uvm_macros.svh"
`include "user_define.svh"

module tb;

    bit clk;


    always begin
        clk = 1'b0;
        #10;
        clk = 1'b1;
        #10;
    end

    avst_if avst_if_sink(clk);
    avst_if avst_if_source(clk);

//Avalon-ST output----------------------------------------------------------------------
    wire [`CHANNEL_WIDTH-1:0] avst_channel_o;
    wire avst_sop_o;
    wire avst_eop_o;
    wire [`EMPTY_WIDTH-1:0] avst_empty_o;

    wire [`DATA_WIDTH-1:0] avst_data_o;
    wire avst_valid_o;
    reg avst_ready_i;

    reg avso_ready;

    avst_fifo #(
        .channel_width(`CHANNEL_WIDTH),
        .data_width(`DATA_WIDTH),
        .empty_width(`EMPTY_WIDTH),
        .fifo_depth(`FIFO_DEPTH)
    ) DUT
    (
        .clk(clk),
        .reset_n(avst_if_sink.reset_n),

    //Avalon-ST input----------------------------------------------------------------------
        .avst_channel_i (avst_if_sink.channel),
        .avst_sop_i     (avst_if_sink.sop),
        .avst_eop_i     (avst_if_sink.eop),
        .avst_empty_i   (avst_if_sink.empty),
        .avst_data_i    (avst_if_sink.data),
        .avst_valid_i   (avst_if_sink.valid),
        .avst_ready_o   (avst_if_sink.ready),



    //Avalon-ST output----------------------------------------------------------------------
        .avst_channel_o (avst_if_source.channel),
        .avst_sop_o     (avst_if_source.sop),
        .avst_eop_o     (avst_if_source.eop),
        .avst_empty_o   (avst_if_source.empty),
        .avst_data_o    (avst_if_source.data),
        .avst_valid_o   (avst_if_source.valid),
        .avst_ready_i   (avso_ready)
    );

//-------------------------------------------------------------------------
    always_ff @ (posedge clk or negedge avst_if_sink.reset_n)
        if(!avst_if_sink.reset_n) avso_ready <= 1'b0;
        else avso_ready <= ~avso_ready;

    assign avst_if_source.ready = avso_ready;
//-------------------------------------------------------------------------


    initial begin
        uvm_config_db#(virtual avst_if)::set(null, "*", "avst_sink_vir", avst_if_sink);
        uvm_config_db#(virtual avst_if)::set(null, "*", "avst_source_vir", avst_if_source);
        run_test("avst_test");
    end


  // Dump waves
  initial begin
    $dumpfile("dump.vcd");
    $dumpvars(0, tb);
  end

endmodule