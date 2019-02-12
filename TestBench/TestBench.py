'''
TestBench per UART
'''

import subprocess
from tkinter import *
from tkinter import ttk
      
#funzione per terminare il programma
def exit_function(*args):
    try:
        global proc
        proc.kill()
    except:
        pass
    exit("Programma terminato dall'utente")
    
#funzione per visualizzare wave su ModelSim
def view_wave(*args):
    try:
        global proc
        proc.kill()
    except:
        pass
    try:
        #global proc
        proc=subprocess.Popen(('vsim -do waveform.do').split())    
    except:
        exit("ERRORE apertura wave")
    else:
        return

#funzione per avviare simulazione ModelSim
def run_sim(*args):
    #prelevo la stringa da inviare
    msg=stringa_input.get()
    if len(msg)>0:
        bytes_tx.set(len(msg))
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
        #avvio simulazione
        try:
            subprocess.run(("vsim -c -do run_tb.do").split())  
        except:
            exit("ERRORE nella simulazione")
        else:
            stringa_tx.set(msg)
            #decodifica output
            def output_decode():
                char_rx=[];
                for line in open("dout.txt","r"):
                    char_rx.append(chr(int(line,2)))
                str_rx="".join(char_rx)
                return str_rx
            msg_rx=output_decode()
            stringa_rx.set(msg_rx)
            bytes_rx.set(len(msg_rx))
            esito.set("Nessun errore") if msg==msg_rx else esito.set("ERRORE!")
            stringa_input.set("")
    else:
        return

try:
    subprocess.run(("vsim -c -do load_vhd.do").split())   
except:
    exit("ERRORE nel caricamento dei files .vhd")
else:
    #GUI    
    root=Tk() 
    root.title("UART RS-232")
    mainframe=ttk.Frame(root,padding="12 12 12 12")
    mainframe.grid(column=0, row=0, sticky=(N,W,E,S))
    # stringa da inviare
    stringa_input=StringVar()
    ttk.Entry(mainframe, textvariable=stringa_input, width=75).grid(row=0, sticky=(W, E), column=0, columnspan=3)
    # Pulsante Send
    ttk.Button(mainframe, text="SEND", command=run_sim, width=25).grid(column=3, row=0, sticky=(W, E))
    root.bind("<Return>", run_sim)
    # Etichetta stringa inviata
    ttk.Label(mainframe,text="INVIATA:", anchor="e", width=25).grid(column=0,row=1, sticky=(W, E))
    # stringa inviata
    stringa_tx=StringVar()
    ttk.Label(mainframe, textvariable=stringa_tx, anchor="w", width=75, font="helvetica 11 bold").grid(row=1, sticky=(W, E), column=1, columnspan=3)
    # Etichetta stringa ricevuta
    ttk.Label(mainframe,text="RICEVUTA:", anchor="e", width=25).grid(column=0,row=2, sticky=(W, E))
    # stringa ricevuta
    stringa_rx=StringVar()
    ttk.Label(mainframe, textvariable=stringa_rx, anchor="w", width=75, font="helvetica 11 bold").grid(row=2, sticky=(W, E), column=1, columnspan=3)
    # Pulsante Wave
    ttk.Button(mainframe, text="Visualizza Wave", command=view_wave).grid(column=3, row=5, sticky=(W, E))
    # Pulsante Exit
    ttk.Button(mainframe, text="EXIT", command=exit_function).grid(column=3, row=6, sticky=(W, E))
    root.bind("<Escape>", exit_function)
    # Etichetta bytes inviati
    ttk.Label(mainframe,text="Bytes inviati", anchor="center").grid(column=0, columnspan=2, row=3, sticky=(W, E))
    # Indicatore bytes inviati
    bytes_tx=StringVar()
    ttk.Label(mainframe, textvariable=bytes_tx, anchor="center", font="helvetica 11 bold").grid(column=0, columnspan=2, row=4, sticky=(W, E))
    # Etichetta bytes ricevuti
    ttk.Label(mainframe,text="Bytes inviati", anchor="center").grid(column=2, columnspan=2, row=3, sticky=(W, E))
    # Indicatore bytes ricevuti
    bytes_rx=StringVar()
    ttk.Label(mainframe, textvariable=bytes_rx, anchor="center", font="helvetica 11 bold").grid(column=2, columnspan=2, row=4, sticky=(W, E))
    # esito testbench
    esito=StringVar()
    esito.set("")
    ttk.Label(mainframe, textvariable=esito, anchor="center", font="helvetica 20").grid(column=0, columnspan=2, row=5, rowspan=2, sticky=(W, E))

    #faccio in modo che la GUI si adatti dinamicamente con la dimensione della finestra
    root.columnconfigure(0,weight=4)
    root.rowconfigure(0, weight=4)
    for j in range(4): mainframe.columnconfigure(j,weight=1)
    for j in range(6): mainframe.rowconfigure(j, weight=1)
    for child in mainframe.winfo_children(): child.grid_configure(padx=3, pady=3)
    root.mainloop()