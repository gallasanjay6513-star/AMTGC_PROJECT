onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -radix unsigned /generic_timer_tb/clk
add wave -noupdate -radix unsigned /generic_timer_tb/rst_n
add wave -noupdate -radix unsigned /generic_timer_tb/start
add wave -noupdate -radix unsigned /generic_timer_tb/target4
add wave -noupdate -radix unsigned /generic_timer_tb/target8
add wave -noupdate -radix unsigned /generic_timer_tb/target12
add wave -noupdate -radix unsigned /generic_timer_tb/done4
add wave -noupdate -radix unsigned /generic_timer_tb/done8
add wave -noupdate -radix unsigned /generic_timer_tb/done12
add wave -noupdate -radix unsigned /generic_timer_tb/timer1/clk
add wave -noupdate -radix unsigned /generic_timer_tb/timer1/rst_n
add wave -noupdate -radix unsigned /generic_timer_tb/timer1/start
add wave -noupdate -radix unsigned /generic_timer_tb/timer1/count_target
add wave -noupdate -radix unsigned /generic_timer_tb/timer1/done
add wave -noupdate -radix unsigned /generic_timer_tb/timer1/count
add wave -noupdate -radix unsigned /generic_timer_tb/timer2/clk
add wave -noupdate -radix unsigned /generic_timer_tb/timer2/rst_n
add wave -noupdate -radix unsigned /generic_timer_tb/timer2/start
add wave -noupdate -radix unsigned /generic_timer_tb/timer2/count_target
add wave -noupdate -radix unsigned /generic_timer_tb/timer2/done
add wave -noupdate -radix unsigned /generic_timer_tb/timer2/count
add wave -noupdate -radix unsigned /generic_timer_tb/timer3/clk
add wave -noupdate -radix unsigned /generic_timer_tb/timer3/rst_n
add wave -noupdate -radix unsigned /generic_timer_tb/timer3/start
add wave -noupdate -radix unsigned /generic_timer_tb/timer3/count_target
add wave -noupdate -radix unsigned /generic_timer_tb/timer3/done
add wave -noupdate -radix unsigned /generic_timer_tb/timer3/count
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 ps} 0}
quietly wave cursor active 0
configure wave -namecolwidth 241
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
WaveRestoreZoom {0 ps} {287700 ps}
