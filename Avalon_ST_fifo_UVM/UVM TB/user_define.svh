`define CHANNEL_WIDTH 10
`define DATA_WIDTH 32
`define EMPTY_WIDTH 2
`define FIFO_DEPTH 10

`include "avst_if.sv"
`include "avst_sink_sequence_item.sv"
`include "avst_source_sequence_item.sv"
`include "gen_avst_item.sv"
`include "avst_driver.sv"
`include "avst_monitor.sv"
`include "avst_agent.sv"
`include "avst_scoreboard.sv"
`include "avst_env.sv"
`include "avst_test.sv"
//`include "avst_env.sv"