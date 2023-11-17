module tb_classical;

    localparam channel_width = 4;
    localparam data_width = 32;
    localparam empty_width = 2;
    localparam fifo_depth = 10;




    reg clk;
    reg reset_n;

//Avalon-ST input----------------------------------------------------------------------
    reg [channel_width-1:0] avst_channel_i;
    reg avst_sop_i;
    reg avst_eop_i;
    reg [empty_width-1:0] avst_empty_i;
    reg [data_width-1:0] avst_data_i;
    reg avst_valid_i;
    wire avst_ready_o;



//Avalon-ST output----------------------------------------------------------------------
    wire [channel_width-1:0] avst_channel_o;
    wire avst_sop_o;
    wire avst_eop_o;
    wire [empty_width-1:0] avst_empty_o;

    wire [data_width-1:0] avst_data_o;
    wire avst_valid_o;
    reg avst_ready_i;



avst_fifo #(
    .channel_width(channel_width),
    .data_width(data_width),
    .empty_width(empty_width),
    .fifo_depth(fifo_depth)
) avst_fifo_inst
(
    .clk(clk),
    .reset_n(reset_n),

//Avalon-ST input----------------------------------------------------------------------
    .avst_channel_i (avst_channel_i),
    .avst_sop_i     (avst_sop_i),
    .avst_eop_i     (avst_eop_i),
    .avst_empty_i   (avst_empty_i),
    .avst_data_i    (avst_data_i),
    .avst_valid_i   (avst_valid_i),
    .avst_ready_o   (avst_ready_o),



//Avalon-ST output----------------------------------------------------------------------
    .avst_channel_o (avst_channel_o),
    .avst_sop_o     (avst_sop_o),
    .avst_eop_o     (avst_eop_o),
    .avst_empty_o   (avst_empty_o),
    .avst_data_o    (avst_data_o),
    .avst_valid_o   (avst_valid_o),
    .avst_ready_i   (avst_ready_i)


);


integer length;

initial begin
    clk = 1'b0;
    reset_n = 1'b0;

    avst_channel_i = {channel_width{1'b0}};
    avst_sop_i = 1'b0;
    avst_eop_i = 1'b0;
    avst_empty_i = {empty_width{1'b0}};
    avst_data_i = {data_width{1'b0}};
    avst_valid_i = 1'b0;
    avst_ready_i = 1'b0;

    repeat(10) @ (posedge clk);
    reset_n = 1'b1;
    avst_ready_i = 1'b1;
    repeat(10) @ (posedge clk);


    for(int i = 0; i < 100; i++) begin
        length = $urandom_range(5,30);        
        for(int j = 0; j < length; j++) begin
            avst_sop_i = j == 0;
            avst_eop_i = j == (length-1);
            avst_empty_i = avst_eop_i ? {empty_width{1'b0}} : $urandom_range(0,3);
            avst_data_i = $urandom;
            avst_valid_i = 1'b1;
            @(posedge clk);
        end
        
        avst_channel_i = {channel_width{1'b0}};
        avst_sop_i = 1'b0;
        avst_eop_i = 1'b0;
        avst_empty_i = {empty_width{1'b0}};
        avst_data_i = {data_width{1'b0}};
        avst_valid_i = 1'b0;
    end

    repeat(1000) @ (posedge clk);

    $stop();
end



always #10 clk = ~clk;



endmodule