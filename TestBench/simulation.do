vlib work

vcom ../quartus/TX/lpm_ff_0.vhd
vcom ../quartus/TX/lpm_shiftreg0.vhd
vcom ../quartus/TX/lpm_mux0.vhd
vcom ../quartus/TX/FSM_TX.vhd
vcom ../quartus/TX/lpm_counter_TX.vhd
vcom ../quartus/TX/lpm_counter_TX_MOD_10.vhd
vcom ../quartus/TX/and_gate_4.vhd
vcom ../quartus/TX/and_gate_8.vhd
vcom ../quartus/TX/TX.vhd

vcom ../quartus/RX/lpm_counter_RX_MOD_16.vhd
vcom ../quartus/RX/lpm_counter_RX_MOD_32.vhd
vcom ../quartus/RX/AND_clk_div.vhd
vcom ../quartus/RX/FSM_RX.vhd
vcom ../quartus/RX/lpm_shiftreg_RX_LEFT_EDGE.vhd
vcom ../quartus/RX/lpm_shiftreg_RX_RIGHT_8_BIT.vhd
vcom ../quartus/RX/Decisore.vhd
vcom ../quartus/RX/AND_Decisore.vhd
vcom ../quartus/RX/AND_NUM_BIT.vhd
vcom ../quartus/RX/RX.vhd

vcom ../quartus/UART/UART.vhd
vcom ../quartus/UART/TB_UART.vhd


vsim -c work.tb_uart
add log sim:/tb_uart/*

run 0 ns
run 8780 ns

quit -sim
quit -f