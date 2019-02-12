'''
TestBench per UART
'''

import subprocess
from tkinter import *
from tkinter import ttk

#decodifica output
def output_decode():
    char_rx=[];
    for line in open("dout.txt","r"):
        char_rx.append(chr(int(line,2)))
    str_rx="".join(char_rx)
        
msg="ciao"


def run_sim(msg):
    #scrittura file din
    f_din=open("din.txt","w")
    f_din.write("{0:d}".format(len(msg)))
    f_din.write('\n')
    for i in range(len(msg)):
        c="{0:08b}".format(ord(msg[i]))
        f_din.write(c)
        if i<len(msg)-1: f_din.write('\n')
    f_din.close()
    
    #scrittura file avvio simulazione
    f_run_do=open("run_tb.do","w")
    f_run_do.write("vsim -c work.tb_uart\n")
    f_run_do.write("add log sim:/tb_uart/*\n\n")
    f_run_do.write("run 0 ns\n")
    run_stop="run {0:.2f} us\n\n".format(25+88*len(msg))
    f_run_do.write(run_stop)
    f_run_do.write("quit -sim\n")
    f_run_do.write("quit -f")
    f_run_do.close()

try:
    subprocess.run(("vsim -c -do load_vhd.do").split())
    #subprocess.run(("vsim -c -do load_tb.do").split())
    subprocess.run(("vsim -c -do run_tb.do").split())
    #subprocess.run(('vsim -do waveform.do').split())    
except:
    exit("ERRORE")
else:
    output_decode()
    print("Terminato")
    
#GUI    
root=Tk() 
root.title("UART RS-232")
mainframe=ttk.Frame(root,padding="12 12 12 12")
mainframe.grid(column=0, row=0, sticky=(N,W,E,S))
# Pulsante L0
off_button=ttk.Button(mainframe, text="L 0", command=lambda: send_command("L 0"))
off_button.grid(column=0, row=0, sticky=(W, E))
off_button.bind("<Button-1>", clear_log)
# Pulsante L1
on_button=ttk.Button(mainframe, text="L 1", command=lambda: send_command("L 1"))
on_button.grid(column=1, row=0, sticky=(W, E))
on_button.bind("<Button-1>", clear_log)
# Indicatore tempo di reazione
time_gui=StringVar()
reaction_time=ttk.Label(mainframe,width=30, textvariable=time_gui)
reaction_time.grid(column=1, row=1, sticky=(W, E))
# Etichetta tempo di reazione
time_label=ttk.Label(mainframe,text="Tempo di reazione (s):", width=30, anchor="e")
time_label.grid(column=0,row=1, sticky=(W, E))
# Indicatore tempo di reazione medio
avg_time_gui=StringVar()
reaction_time=ttk.Label(mainframe,width=30, textvariable=avg_time_gui)
reaction_time.grid(column=1, row=2, sticky=(W, E))
# Etichetta tempo di reazione medio
time_label=ttk.Label(mainframe,text="Tempo di reazione medio (s):", width=30, anchor="e")
time_label.grid(column=0,row=2, sticky=(W, E))
# Indicatore tempo di reazione migliore
best_time_gui=StringVar()
reaction_time=ttk.Label(mainframe,width=30, textvariable=best_time_gui)
reaction_time.grid(column=1, row=3, sticky=(W, E))
# Etichetta tempo di reazione migliore
time_label=ttk.Label(mainframe,text="Tempo di reazione migliore (s):", width=30, anchor="e")
time_label.grid(column=0,row=3, sticky=(W, E))
#selettore porta
port_select=StringVar()
port_box=ttk.Combobox(mainframe, textvariable=port_select)
port_box.grid(row=4, sticky=(W, E), column=1)
port_box['values']=tuple(comlist)
port_box.bind("<<ComboboxSelected>>", inizializza_seriale) #apre la porta seriale selezionata
#etichetta porta
port_label=ttk.Label(mainframe, text="Porta selezionata:", anchor="e", width=30)
port_label.grid(row=4, sticky=(W, E), column=0)
# log stato
status_log=StringVar()
status=ttk.Label(mainframe, textvariable=status_log, anchor="center", width=25)
status.grid(row=5, sticky=(W, E), column=0, columnspan=2)
#faccio in modo che la GUI si adatti dinamicamente con la dimensione della finestra
root.columnconfigure(0,weight=4)
root.rowconfigure(0, weight=4)
for j in range(2): mainframe.columnconfigure(j,weight=1)
for j in range(6): mainframe.rowconfigure(j, weight=1)
for child in mainframe.winfo_children(): child.grid_configure(padx=3, pady=3)
root.mainloop()