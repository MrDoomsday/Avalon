`define PACKET_ON 
`define CHANNEL_ON

module avst_fifo #(
    parameter channel_width = 4,
    parameter data_width = 32,
    parameter empty_width = 2,
    parameter fifo_depth = 10
)
(
    input logic clk,
    input logic reset_n,

//Avalon-ST input----------------------------------------------------------------------
`ifdef CHANNEL_ON
    input logic [channel_width-1:0] avst_channel_i,
`endif

`ifdef PACKET_ON
    input logic avst_sop_i,
    input logic avst_eop_i,
    input logic [empty_width-1:0] avst_empty_i,
`endif

    input logic [data_width-1:0] avst_data_i,
    input logic avst_valid_i,
    output logic avst_ready_o,



//Avalon-ST output----------------------------------------------------------------------
`ifdef CHANNEL_ON
    output logic [channel_width-1:0] avst_channel_o,
`endif

`ifdef PACKET_ON
    output logic avst_sop_o,
    output logic avst_eop_o,
    output logic [empty_width-1:0] avst_empty_o,
`endif

    output logic [data_width-1:0] avst_data_o,
    output logic avst_valid_o,
    input logic avst_ready_i


);

typedef struct packed {
    logic [channel_width-1:0] channel;
    logic [data_width-1:0] data;
    logic valid;
    logic sop, eop;
    logic [empty_width-1:0] empty;
} stream;


stream stream_in, stream_out;


always_ff @ (posedge clk)
    if(avst_ready_o) begin
        stream_in.data <= avst_data_i;
        `ifdef CHANNEL_ON
            stream_in.channel <= avst_channel_i;
        `endif
        `ifdef PACKET_ON
            stream_in.sop <= avst_sop_i;
            stream_in.eop <= avst_eop_i;
            stream_in.empty <= avst_empty_i;
        `endif
    end

always_ff @ (posedge clk or negedge reset_n)
    if(!reset_n) stream_in.valid <= 1'b0;
    else if(avst_ready_o) stream_in.valid <= avst_valid_i;



/*************************************************************INSTANCE*************************************************************/

`ifdef PACKET_ON
    `ifdef CHANNEL_ON
        localparam fifo_width = channel_width + data_width + 1 + 1 + empty_width;
        wire [fifo_width-1:0] data_in = {stream_in.channel, stream_in.data, stream_in.sop, stream_in.eop, stream_in.empty};
        wire [fifo_width-1:0] data_out;
    `else
        localparam fifo_width = data_width + 1 + 1 + empty_width;
        wire [fifo_width-1:0] = {stream_in.data, stream_in.sop, stream_in.eop, stream_in.empty};
        wire [fifo_width-1:0] data_out;
    `endif
`else 
    `ifdef CHANNEL_ON
        localparam fifo_width = channel_width + data_width;
        wire [fifo_width-1:0] data_in = {stream_in.channel, stream_in.data};
        wire [fifo_width-1:0] data_out;
    `else
        localparam fifo_width = data_width;
        wire [fifo_width-1:0] data_in = stream_in.data;
        wire [fifo_width-1:0] data_out;
    `endif
`endif


wire full;
wire empty;
wire wr = stream_in.valid & avst_ready_o;
wire rd = ~empty & avst_ready_i;
assign avst_ready_o = ~full;


fifo fifo_inst
(
	.clk(clk),
	.reset_n(reset_n),
		
	.wr     (wr),
	.rd     (rd),
	.data_in(data_in),
		
	.data_out   (data_out),
	.full       (full),
	.empty      (empty),
		
	.almost_full    (),
	.almost_empty   ()
	
);

defparam 	fifo_inst.data_width = fifo_width,
			fifo_inst.fifo_depth = fifo_depth;
			//fifo_inst.fifo_almost_full = 2130,
			//fifo_inst.fifo_almost_empty = 12;

logic rd_r;

always_ff @ (posedge clk or negedge reset_n)
    if(!reset_n) rd_r <= 1'b0;
    else if(avst_ready_i) rd_r <= ~empty;


`ifdef PACKET_ON
    `ifdef CHANNEL_ON
        assign {stream_out.channel, stream_out.data, stream_out.sop, stream_out.eop, stream_out.empty} = data_out;
    `else
        assign {stream_out.data, stream_out.sop, stream_out.eop, stream_out.empty} = data_out;
    `endif
`else 
    `ifdef CHANNEL_ON
        assign {stream_out.channel, stream_out.data} = data_out;
    `else
        assign {stream_out.data} = data_out;
    `endif
`endif


//output logic 
always_ff @ (posedge clk or negedge reset_n)
    if(!reset_n) avst_valid_o <= 1'b0;
    else if(avst_ready_i) avst_valid_o <= rd_r;




always_ff @ (posedge clk)   
    if(avst_ready_i) begin
        avst_data_o <= stream_out.data;
        `ifdef PACKET_ON
            `ifdef CHANNEL_ON
                avst_channel_o <= stream_out.channel;
            `endif
            avst_sop_o <= stream_out.sop;
            avst_eop_o <= stream_out.eop;
            avst_empty_o <= stream_out.empty;
        `else 
            `ifdef CHANNEL_ON
                avst_channel_o <= stream_out.channel;
            `endif
        `endif
    end



endmodule