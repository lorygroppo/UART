'''
TestBench per UART

sim:/tb_uart/U1/b2v_RX_BLOCK/b2v_FSM_RX/present_state \
sim:/tb_uart/U1/b2v_RX_BLOCK/b2v_FSM_RX/next_state
'''

import subprocess

str="ciao"
f_din=open("din.txt","w")
f_din.write("{0:d}".format(len(str)))
f_din.write('\n')
for i in range(len(str)):
    c="{0:08b}".format(ord(str[i]))
    f_din.write(c)
    if i<len(str)-1: f_din.write('\n')
f_din.close()

try:
    subprocess.run(("vsim -c -do load_vhd.do").split())
    subprocess.run(("vsim -c -do load_tb.do").split())
    subprocess.run(("vsim -c -do run_tb.do").split())
    print("\n\n\n\n")
    subprocess.run(('vsim -do waveform.do').split())
except:
    exit("ERRORE")
else:
    print("Terminato")