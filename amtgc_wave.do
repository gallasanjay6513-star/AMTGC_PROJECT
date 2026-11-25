onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -radix unsigned /amtgc_top_tb/dut/clk
add wave -noupdate -radix unsigned /amtgc_top_tb/dut/rst_n
add wave -noupdate -radix unsigned /amtgc_top_tb/dut/emergency_override
add wave -noupdate -radix unsigned /amtgc_top_tb/dut/ped_request_a
add wave -noupdate -radix unsigned /amtgc_top_tb/dut/ped_request_b
add wave -noupdate -radix unsigned /amtgc_top_tb/dut/traffic_density_a
add wave -noupdate -radix unsigned /amtgc_top_tb/dut/traffic_density_b
add wave -noupdate -radix unsigned /amtgc_top_tb/dut/a_ns_light
add wave -noupdate -radix unsigned /amtgc_top_tb/dut/a_ew_light
add wave -noupdate -radix unsigned /amtgc_top_tb/dut/b_ns_light
add wave -noupdate -radix unsigned /amtgc_top_tb/dut/b_ew_light
add wave -noupdate -radix unsigned /amtgc_top_tb/dut/a_ped_walk
add wave -noupdate -radix unsigned /amtgc_top_tb/dut/ped_req_b
add wave -noupdate -radix unsigned /amtgc_top_tb/dut/b_ped_walk
add wave -noupdate -radix unsigned /amtgc_top_tb/dut/ped_req_a
add wave -noupdate -radix unsigned /amtgc_top_tb/dut/ped_grant_a
add wave -noupdate -radix unsigned /amtgc_top_tb/dut/ped_grant_b
add wave -noupdate -radix unsigned /amtgc_top_tb/dut/a_ns_green_start
add wave -noupdate -radix unsigned /amtgc_top_tb/dut/b_ns_start_enable
add wave -noupdate -radix unsigned /amtgc_top_tb/dut/wave_pending
add wave -noupdate -radix unsigned /amtgc_top_tb/dut/wave_count
add wave -noupdate -radix unsigned /amtgc_top_tb/dut/junction_a_inst/clk
add wave -noupdate -radix unsigned /amtgc_top_tb/dut/junction_a_inst/rst_n
add wave -noupdate -radix unsigned /amtgc_top_tb/dut/junction_a_inst/emergency_override
add wave -noupdate -radix unsigned /amtgc_top_tb/dut/junction_a_inst/ped_request
add wave -noupdate -radix unsigned /amtgc_top_tb/dut/junction_a_inst/ped_grant
add wave -noupdate -radix unsigned /amtgc_top_tb/dut/junction_a_inst/ns_start_enable
add wave -noupdate -radix unsigned /amtgc_top_tb/dut/junction_a_inst/ped_req_out
add wave -noupdate -radix unsigned /amtgc_top_tb/dut/junction_a_inst/ped_walk
add wave -noupdate -radix unsigned /amtgc_top_tb/dut/junction_a_inst/ns_green_start
add wave -noupdate -radix unsigned /amtgc_top_tb/dut/junction_a_inst/ns_light
add wave -noupdate -radix unsigned /amtgc_top_tb/dut/junction_a_inst/ew_light
add wave -noupdate -radix unsigned /amtgc_top_tb/dut/junction_a_inst/state
add wave -noupdate -radix unsigned /amtgc_top_tb/dut/junction_a_inst/next_state
add wave -noupdate -radix unsigned /amtgc_top_tb/dut/junction_a_inst/timer_start
add wave -noupdate -radix unsigned /amtgc_top_tb/dut/junction_a_inst/timer_target
add wave -noupdate -radix unsigned /amtgc_top_tb/dut/junction_a_inst/timer_done
add wave -noupdate -radix unsigned /amtgc_top_tb/dut/junction_a_inst/timer_pause
add wave -noupdate -radix unsigned /amtgc_top_tb/dut/junction_a_inst/ped_pending
add wave -noupdate -radix unsigned /amtgc_top_tb/dut/junction_a_inst/red_elapsed
add wave -noupdate -radix unsigned /amtgc_top_tb/dut/junction_a_inst/timer_inst/clk
add wave -noupdate -radix unsigned /amtgc_top_tb/dut/junction_a_inst/timer_inst/rst_n
add wave -noupdate -radix unsigned /amtgc_top_tb/dut/junction_a_inst/timer_inst/start
add wave -noupdate -radix unsigned /amtgc_top_tb/dut/junction_a_inst/timer_inst/count_target
add wave -noupdate -radix unsigned /amtgc_top_tb/dut/junction_a_inst/timer_inst/done
add wave -noupdate -radix unsigned /amtgc_top_tb/dut/junction_a_inst/timer_inst/count
add wave -noupdate -radix unsigned /amtgc_top_tb/dut/junction_b_inst/clk
add wave -noupdate -radix unsigned /amtgc_top_tb/dut/junction_b_inst/rst_n
add wave -noupdate -radix unsigned /amtgc_top_tb/dut/junction_b_inst/emergency_override
add wave -noupdate -radix unsigned /amtgc_top_tb/dut/junction_b_inst/ped_request
add wave -noupdate -radix unsigned /amtgc_top_tb/dut/junction_b_inst/ped_grant
add wave -noupdate -radix unsigned /amtgc_top_tb/dut/junction_b_inst/ns_start_enable
add wave -noupdate -radix unsigned /amtgc_top_tb/dut/junction_b_inst/ped_req_out
add wave -noupdate -radix unsigned /amtgc_top_tb/dut/junction_b_inst/ped_walk
add wave -noupdate -radix unsigned /amtgc_top_tb/dut/junction_b_inst/ns_green_start
add wave -noupdate -radix unsigned /amtgc_top_tb/dut/junction_b_inst/ns_light
add wave -noupdate -radix unsigned /amtgc_top_tb/dut/junction_b_inst/ew_light
add wave -noupdate -radix unsigned /amtgc_top_tb/dut/junction_b_inst/state
add wave -noupdate -radix unsigned /amtgc_top_tb/dut/junction_b_inst/next_state
add wave -noupdate -radix unsigned /amtgc_top_tb/dut/junction_b_inst/timer_start
add wave -noupdate -radix unsigned /amtgc_top_tb/dut/junction_b_inst/timer_target
add wave -noupdate -radix unsigned /amtgc_top_tb/dut/junction_b_inst/timer_done
add wave -noupdate -radix unsigned /amtgc_top_tb/dut/junction_b_inst/timer_pause
add wave -noupdate -radix unsigned /amtgc_top_tb/dut/junction_b_inst/ped_pending
add wave -noupdate -radix unsigned /amtgc_top_tb/dut/junction_b_inst/red_elapsed
add wave -noupdate -radix unsigned /amtgc_top_tb/dut/junction_b_inst/timer_inst/clk
add wave -noupdate -radix unsigned /amtgc_top_tb/dut/junction_b_inst/timer_inst/rst_n
add wave -noupdate -radix unsigned /amtgc_top_tb/dut/junction_b_inst/timer_inst/start
add wave -noupdate -radix unsigned /amtgc_top_tb/dut/junction_b_inst/timer_inst/count_target
add wave -noupdate -radix unsigned /amtgc_top_tb/dut/junction_b_inst/timer_inst/done
add wave -noupdate -radix unsigned /amtgc_top_tb/dut/junction_b_inst/timer_inst/count
add wave -noupdate -radix unsigned /amtgc_top_tb/dut/ped_arbiter_inst/clk
add wave -noupdate -radix unsigned /amtgc_top_tb/dut/ped_arbiter_inst/rst_n
add wave -noupdate -radix unsigned /amtgc_top_tb/dut/ped_arbiter_inst/req_a
add wave -noupdate -radix unsigned /amtgc_top_tb/dut/ped_arbiter_inst/req_b
add wave -noupdate -radix unsigned /amtgc_top_tb/dut/ped_arbiter_inst/grant_a
add wave -noupdate -radix unsigned /amtgc_top_tb/dut/ped_arbiter_inst/grant_b
add wave -noupdate -radix unsigned /amtgc_top_tb/dut/ped_arbiter_inst/busy
add wave -noupdate -radix unsigned /amtgc_top_tb/dut/ped_arbiter_inst/owner
add wave -noupdate -radix unsigned /amtgc_top_tb/dut/ped_arbiter_inst/last_served
add wave -noupdate -radix unsigned /amtgc_top_tb/clk
add wave -noupdate -radix unsigned /amtgc_top_tb/rst_n
add wave -noupdate -radix unsigned /amtgc_top_tb/emergency_override
add wave -noupdate -radix unsigned /amtgc_top_tb/ped_request_a
add wave -noupdate -radix unsigned /amtgc_top_tb/ped_request_b
add wave -noupdate -radix unsigned /amtgc_top_tb/traffic_density_a
add wave -noupdate -radix unsigned /amtgc_top_tb/traffic_density_b
add wave -noupdate -radix unsigned /amtgc_top_tb/a_ns_light
add wave -noupdate -radix unsigned /amtgc_top_tb/a_ew_light
add wave -noupdate -radix unsigned /amtgc_top_tb/b_ns_light
add wave -noupdate -radix unsigned /amtgc_top_tb/b_ew_light
add wave -noupdate -radix unsigned /amtgc_top_tb/a_ped_walk
add wave -noupdate -radix unsigned /amtgc_top_tb/b_ped_walk
add wave -noupdate -radix unsigned /amtgc_top_tb/dut/clk
add wave -noupdate -radix unsigned /amtgc_top_tb/dut/rst_n
add wave -noupdate -radix unsigned /amtgc_top_tb/dut/emergency_override
add wave -noupdate -radix unsigned /amtgc_top_tb/dut/ped_request_a
add wave -noupdate -radix unsigned /amtgc_top_tb/dut/ped_request_b
add wave -noupdate -radix unsigned /amtgc_top_tb/dut/traffic_density_a
add wave -noupdate -radix unsigned /amtgc_top_tb/dut/traffic_density_b
add wave -noupdate -radix unsigned /amtgc_top_tb/dut/a_ns_light
add wave -noupdate -radix unsigned /amtgc_top_tb/dut/a_ew_light
add wave -noupdate -radix unsigned /amtgc_top_tb/dut/b_ns_light
add wave -noupdate -radix unsigned /amtgc_top_tb/dut/b_ew_light
add wave -noupdate -radix unsigned /amtgc_top_tb/dut/a_ped_walk
add wave -noupdate -radix unsigned /amtgc_top_tb/dut/b_ped_walk
add wave -noupdate -radix unsigned /amtgc_top_tb/dut/ped_req_a
add wave -noupdate -radix unsigned /amtgc_top_tb/dut/ped_req_b
add wave -noupdate -radix unsigned /amtgc_top_tb/dut/ped_grant_a
add wave -noupdate -radix unsigned /amtgc_top_tb/dut/ped_grant_b
add wave -noupdate -radix unsigned /amtgc_top_tb/dut/a_ns_green_start
add wave -noupdate -radix unsigned /amtgc_top_tb/dut/b_ns_start_enable
add wave -noupdate -radix unsigned /amtgc_top_tb/dut/wave_pending
add wave -noupdate -radix unsigned /amtgc_top_tb/dut/wave_count
add wave -noupdate -radix unsigned /amtgc_top_tb/dut/junction_a_inst/clk
add wave -noupdate -radix unsigned /amtgc_top_tb/dut/junction_a_inst/rst_n
add wave -noupdate -radix unsigned /amtgc_top_tb/dut/junction_a_inst/emergency_override
add wave -noupdate -radix unsigned /amtgc_top_tb/dut/junction_a_inst/ped_request
add wave -noupdate -radix unsigned /amtgc_top_tb/dut/junction_a_inst/ped_grant
add wave -noupdate -radix unsigned /amtgc_top_tb/dut/junction_a_inst/ns_start_enable
add wave -noupdate -radix unsigned /amtgc_top_tb/dut/junction_a_inst/ped_req_out
add wave -noupdate -radix unsigned /amtgc_top_tb/dut/junction_a_inst/ped_walk
add wave -noupdate -radix unsigned /amtgc_top_tb/dut/junction_a_inst/ns_green_start
add wave -noupdate -radix unsigned /amtgc_top_tb/dut/junction_a_inst/ns_light
add wave -noupdate -radix unsigned /amtgc_top_tb/dut/junction_a_inst/ew_light
add wave -noupdate -radix unsigned /amtgc_top_tb/dut/junction_a_inst/state
add wave -noupdate -radix unsigned /amtgc_top_tb/dut/junction_a_inst/next_state
add wave -noupdate -radix unsigned /amtgc_top_tb/dut/junction_a_inst/timer_start
add wave -noupdate -radix unsigned /amtgc_top_tb/dut/junction_a_inst/timer_target
add wave -noupdate -radix unsigned /amtgc_top_tb/dut/junction_a_inst/timer_done
add wave -noupdate -radix unsigned /amtgc_top_tb/dut/junction_a_inst/timer_pause
add wave -noupdate -radix unsigned /amtgc_top_tb/dut/junction_a_inst/ped_pending
add wave -noupdate -radix unsigned /amtgc_top_tb/dut/junction_a_inst/red_elapsed
add wave -noupdate -radix unsigned /amtgc_top_tb/dut/junction_a_inst/timer_inst/clk
add wave -noupdate -radix unsigned /amtgc_top_tb/dut/junction_a_inst/timer_inst/rst_n
add wave -noupdate -radix unsigned /amtgc_top_tb/dut/junction_a_inst/timer_inst/start
add wave -noupdate -radix unsigned /amtgc_top_tb/dut/junction_a_inst/timer_inst/count_target
add wave -noupdate -radix unsigned /amtgc_top_tb/dut/junction_a_inst/timer_inst/done
add wave -noupdate -radix unsigned /amtgc_top_tb/dut/junction_a_inst/timer_inst/count
add wave -noupdate -radix unsigned /amtgc_top_tb/dut/junction_b_inst/clk
add wave -noupdate -radix unsigned /amtgc_top_tb/dut/junction_b_inst/rst_n
add wave -noupdate -radix unsigned /amtgc_top_tb/dut/junction_b_inst/emergency_override
add wave -noupdate -radix unsigned /amtgc_top_tb/dut/junction_b_inst/ped_request
add wave -noupdate -radix unsigned /amtgc_top_tb/dut/junction_b_inst/ped_grant
add wave -noupdate -radix unsigned /amtgc_top_tb/dut/junction_b_inst/ns_start_enable
add wave -noupdate -radix unsigned /amtgc_top_tb/dut/junction_b_inst/ped_req_out
add wave -noupdate -radix unsigned /amtgc_top_tb/dut/junction_b_inst/ped_walk
add wave -noupdate -radix unsigned /amtgc_top_tb/dut/junction_b_inst/ns_green_start
add wave -noupdate -radix unsigned /amtgc_top_tb/dut/junction_b_inst/ns_light
add wave -noupdate -radix unsigned /amtgc_top_tb/dut/junction_b_inst/ew_light
add wave -noupdate -radix unsigned /amtgc_top_tb/dut/junction_b_inst/state
add wave -noupdate -radix unsigned /amtgc_top_tb/dut/junction_b_inst/next_state
add wave -noupdate -radix unsigned /amtgc_top_tb/dut/junction_b_inst/timer_start
add wave -noupdate -radix unsigned /amtgc_top_tb/dut/junction_b_inst/timer_target
add wave -noupdate -radix unsigned /amtgc_top_tb/dut/junction_b_inst/timer_done
add wave -noupdate -radix unsigned /amtgc_top_tb/dut/junction_b_inst/timer_pause
add wave -noupdate -radix unsigned /amtgc_top_tb/dut/junction_b_inst/ped_pending
add wave -noupdate -radix unsigned /amtgc_top_tb/dut/junction_b_inst/red_elapsed
add wave -noupdate -radix unsigned /amtgc_top_tb/dut/junction_b_inst/timer_inst/clk
add wave -noupdate -radix unsigned /amtgc_top_tb/dut/junction_b_inst/timer_inst/rst_n
add wave -noupdate -radix unsigned /amtgc_top_tb/dut/junction_b_inst/timer_inst/start
add wave -noupdate -radix unsigned /amtgc_top_tb/dut/junction_b_inst/timer_inst/count_target
add wave -noupdate -radix unsigned /amtgc_top_tb/dut/junction_b_inst/timer_inst/done
add wave -noupdate -radix unsigned /amtgc_top_tb/dut/junction_b_inst/timer_inst/count
add wave -noupdate -radix unsigned /amtgc_top_tb/dut/ped_arbiter_inst/clk
add wave -noupdate -radix unsigned /amtgc_top_tb/dut/ped_arbiter_inst/rst_n
add wave -noupdate -radix unsigned /amtgc_top_tb/dut/ped_arbiter_inst/req_a
add wave -noupdate -radix unsigned /amtgc_top_tb/dut/ped_arbiter_inst/req_b
add wave -noupdate -radix unsigned /amtgc_top_tb/dut/ped_arbiter_inst/grant_a
add wave -noupdate -radix unsigned /amtgc_top_tb/dut/ped_arbiter_inst/grant_b
add wave -noupdate -radix unsigned /amtgc_top_tb/dut/ped_arbiter_inst/busy
add wave -noupdate -radix unsigned /amtgc_top_tb/dut/ped_arbiter_inst/owner
add wave -noupdate -radix unsigned /amtgc_top_tb/dut/ped_arbiter_inst/last_served
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {249816 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 295
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
WaveRestoreZoom {0 ps} {756 ns}
