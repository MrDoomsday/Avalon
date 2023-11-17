onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /tb/DUT/clk
add wave -noupdate /tb/DUT/reset_n
add wave -noupdate -expand -group avsi_pkt /tb/DUT/avst_channel_i
add wave -noupdate -expand -group avsi_pkt /tb/DUT/avst_sop_i
add wave -noupdate -expand -group avsi_pkt /tb/DUT/avst_eop_i
add wave -noupdate -expand -group avsi_pkt /tb/DUT/avst_empty_i
add wave -noupdate -expand -group avsi_pkt /tb/DUT/avst_data_i
add wave -noupdate -expand -group avsi_pkt /tb/DUT/avst_valid_i
add wave -noupdate -expand -group avsi_pkt /tb/DUT/avst_ready_o
add wave -noupdate -expand -group avso_pkt /tb/DUT/avst_channel_o
add wave -noupdate -expand -group avso_pkt /tb/DUT/avst_sop_o
add wave -noupdate -expand -group avso_pkt /tb/DUT/avst_eop_o
add wave -noupdate -expand -group avso_pkt /tb/DUT/avst_empty_o
add wave -noupdate -expand -group avso_pkt /tb/DUT/avst_data_o
add wave -noupdate -expand -group avso_pkt /tb/DUT/avst_valid_o
add wave -noupdate -expand -group avso_pkt /tb/DUT/avst_ready_i
add wave -noupdate -group debug /tb/DUT/stream_in
add wave -noupdate -group debug /tb/DUT/stream_out
add wave -noupdate -group debug /tb/DUT/data_in
add wave -noupdate -group debug /tb/DUT/data_out
add wave -noupdate -group debug /tb/DUT/full
add wave -noupdate -group debug /tb/DUT/empty
add wave -noupdate -group debug /tb/DUT/wr
add wave -noupdate -group debug /tb/DUT/rd
add wave -noupdate -group debug /tb/DUT/rd_r
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {690 ns} 0}
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
WaveRestoreZoom {0 ns} {1432 ns}
