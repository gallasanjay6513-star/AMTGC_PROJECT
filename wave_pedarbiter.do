onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /ped_arbiter_tb/clk
add wave -noupdate /ped_arbiter_tb/rst_n
add wave -noupdate /ped_arbiter_tb/req_a
add wave -noupdate /ped_arbiter_tb/req_b
add wave -noupdate /ped_arbiter_tb/grant_a
add wave -noupdate /ped_arbiter_tb/grant_b
add wave -noupdate /ped_arbiter_tb/dut/clk
add wave -noupdate /ped_arbiter_tb/dut/rst_n
add wave -noupdate /ped_arbiter_tb/dut/req_a
add wave -noupdate /ped_arbiter_tb/dut/req_b
add wave -noupdate /ped_arbiter_tb/dut/grant_a
add wave -noupdate /ped_arbiter_tb/dut/grant_b
add wave -noupdate /ped_arbiter_tb/dut/busy
add wave -noupdate /ped_arbiter_tb/dut/owner
add wave -noupdate /ped_arbiter_tb/dut/last_served
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 ps} 0}
quietly wave cursor active 0
configure wave -namecolwidth 268
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ps
update
WaveRestoreZoom {0 ps} {270280 ps}
