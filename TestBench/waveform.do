dataset open vsim.wlf
add wave *
radix signal /tb_uart/d_in_tb -ascii
radix signal /tb_uart/d_out_tb -ascii
view wave
wave zoom full