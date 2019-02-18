vsim -c work.tb_uart
add log sim:/tb_uart/*

run 0 ns
run 377.00 us

quit -sim
quit -f