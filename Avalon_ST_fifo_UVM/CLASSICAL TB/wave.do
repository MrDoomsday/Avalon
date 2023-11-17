onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /tb_classical/avst_fifo_inst/clk
add wave -noupdate /tb_classical/avst_fifo_inst/reset_n
add wave -noupdate -expand -group avsi /tb_classical/avst_fifo_inst/avst_channel_i
add wave -noupdate -expand -group avsi /tb_classical/avst_fifo_inst/avst_sop_i
add wave -noupdate -expand -group avsi /tb_classical/avst_fifo_inst/avst_eop_i
add wave -noupdate -expand -group avsi /tb_classical/avst_fifo_inst/avst_empty_i
add wave -noupdate -expand -group avsi /tb_classical/avst_fifo_inst/avst_data_i
add wave -noupdate -expand -group avsi /tb_classical/avst_fifo_inst/avst_valid_i
add wave -noupdate -expand -group avsi /tb_classical/avst_fifo_inst/avst_ready_o
add wave -noupdate -expand -group avso /tb_classical/avst_fifo_inst/avst_channel_o
add wave -noupdate -expand -group avso /tb_classical/avst_fifo_inst/avst_sop_o
add wave -noupdate -expand -group avso /tb_classical/avst_fifo_inst/avst_eop_o
add wave -noupdate -expand -group avso /tb_classical/avst_fifo_inst/avst_empty_o
add wave -noupdate -expand -group avso /tb_classical/avst_fifo_inst/avst_data_o
add wave -noupdate -expand -group avso /tb_classical/avst_fifo_inst/avst_valid_o
add wave -noupdate -expand -group avso /tb_classical/avst_fifo_inst/avst_ready_i
add wave -noupdate -expand -group debug /tb_classical/avst_fifo_inst/stream_in
add wave -noupdate -expand -group debug /tb_classical/avst_fifo_inst/stream_out
add wave -noupdate -expand -group debug /tb_classical/avst_fifo_inst/data_in
add wave -noupdate -expand -group debug /tb_classical/avst_fifo_inst/data_out
add wave -noupdate -expand -group debug /tb_classical/avst_fifo_inst/full
add wave -noupdate -expand -group debug /tb_classical/avst_fifo_inst/empty
add wave -noupdate -expand -group debug /tb_classical/avst_fifo_inst/wr
add wave -noupdate -expand -group debug /tb_classical/avst_fifo_inst/rd
add wave -noupdate -expand -group debug /tb_classical/avst_fifo_inst/rd_r
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {12012 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 1
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {33349 ns} {41006 ns}
