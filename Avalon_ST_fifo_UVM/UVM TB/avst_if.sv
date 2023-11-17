interface avst_if(input bit clk);

    logic reset_n;

    logic [`CHANNEL_WIDTH-1:0] channel;
    logic [`DATA_WIDTH-1:0] data;
    logic valid;
    logic sop;
    logic eop;
    logic [`EMPTY_WIDTH-1:0] empty;
    logic ready;

endinterface