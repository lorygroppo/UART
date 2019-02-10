onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /tb_uart/reset_n_tb
add wave -noupdate /tb_uart/clk_tb
add wave -noupdate /tb_uart/U1/b2v_TX_BLOCK/b2v_FSM_TX/CK
add wave -noupdate /tb_uart/d_in_tb
add wave -noupdate /tb_uart/wr_tb
add wave -noupdate /tb_uart/tx_rdy_tb
add wave -noupdate /tb_uart/tx_tb
add wave -noupdate /tb_uart/U1/b2v_TX_BLOCK/b2v_FSM_TX/TC
add wave -noupdate /tb_uart/U1/b2v_TX_BLOCK/b2v_FSM_TX/present_state
add wave -noupdate /tb_uart/U1/b2v_TX_BLOCK/b2v_FSM_TX/next_state
add wave -noupdate -divider {RX section}
add wave -noupdate /tb_uart/rx_tb
add wave -noupdate /tb_uart/U1/b2v_RX_BLOCK/b2v_FSM_RX/START
add wave -noupdate /tb_uart/U1/b2v_RX_BLOCK/b2v_FSM_RX/SHIFT_DOUT
add wave -noupdate /tb_uart/d_out_tb
add wave -noupdate /tb_uart/dav_tb
add wave -noupdate /tb_uart/rd_tb
add wave -noupdate /tb_uart/U1/b2v_RX_BLOCK/b2v_FSM_RX/present_state
add wave -noupdate /tb_uart/U1/b2v_RX_BLOCK/b2v_FSM_RX/next_state
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {286383495 ps} 0}
configure wave -namecolwidth 370
configure wave -valuecolwidth 64
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
configure wave -timelineunits us
update
WaveRestoreZoom {0 ps} {472500 ns}
