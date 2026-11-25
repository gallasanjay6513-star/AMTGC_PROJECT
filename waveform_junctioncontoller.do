onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /junction_controller_tb/clk
add wave -noupdate /junction_controller_tb/rst_n
add wave -noupdate /junction_controller_tb/emergency_override
add wave -noupdate /junction_controller_tb/ped_request
add wave -noupdate /junction_controller_tb/ped_grant
add wave -noupdate /junction_controller_tb/ns_start_enable
add wave -noupdate /junction_controller_tb/ped_req_out
add wave -noupdate /junction_controller_tb/ped_walk
add wave -noupdate /junction_controller_tb/ns_green_start
add wave -noupdate /junction_controller_tb/ns_light
add wave -noupdate /junction_controller_tb/ew_light
add wave -noupdate /junction_controller_tb/dut/clk
add wave -noupdate /junction_controller_tb/dut/rst_n
add wave -noupdate /junction_controller_tb/dut/emergency_override
add wave -noupdate /junction_controller_tb/dut/ped_request
add wave -noupdate /junction_controller_tb/dut/ped_grant
add wave -noupdate /junction_controller_tb/dut/ns_start_enable
add wave -noupdate /junction_controller_tb/dut/ped_req_out
add wave -noupdate /junction_controller_tb/dut/ped_walk
add wave -noupdate /junction_controller_tb/dut/ns_green_start
add wave -noupdate /junction_controller_tb/dut/ns_light
add wave -noupdate /junction_controller_tb/dut/ew_light
add wave -noupdate /junction_controller_tb/dut/state
add wave -noupdate /junction_controller_tb/dut/next_state
add wave -noupdate /junction_controller_tb/dut/timer_start
add wave -noupdate /junction_controller_tb/dut/timer_target
add wave -noupdate /junction_controller_tb/dut/timer_done
add wave -noupdate /junction_controller_tb/dut/ped_pending
add wave -noupdate /junction_controller_tb/dut/timer_inst/clk
add wave -noupdate /junction_controller_tb/dut/timer_inst/rst_n
add wave -noupdate /junction_controller_tb/dut/timer_inst/start
add wave -noupdate /junction_controller_tb/dut/timer_inst/count_target
add wave -noupdate /junction_controller_tb/dut/timer_inst/done
add wave -noupdate /junction_controller_tb/dut/timer_inst/count
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 ps} 0}
quietly wave cursor active 0
configure wave -namecolwidth 301
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
WaveRestoreZoom {0 ps} {674250 ps}
