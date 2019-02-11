vsim -c work.tb_uart
add log sim:/tb_uart/*

run 0 ns
run 500 us

quit -sim
quit -f