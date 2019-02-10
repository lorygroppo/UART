********VERIFICA DEL FUNZIONAMENTO TRAMITE SIMULAZIONE******************

Per simulare l'intero blocco UART aprire modelsim e caricare il progetto tramite file->open... e selezionare all'interno della
cartella UART_sim il file UART_sim.mpf. Se necessario cliccare su Compile All e avviare la simulazione cliccando su Simulate.
Nella nuova finestra di dialogo sfogliare l'albero "work", selezionare tb_uart e premere OK. Nella barra degli strumenti selezionare
view->wave e nella nuova finestra file->Load.. nella nuova finestra di dialogo selezionare il file wave.do.
Per simulare impostare un tempo di simulazione pari a 450 us e cliccare su RUN.

Le waveform sono divise in due sezioni: una relativa a TX e una relativa a RX

Per TX, vengono effettuate 3 trasmissioni di dati, di cui due immediatamente adiacenti. Come si può notare dal segnale tx_tb il trasmettitore
spedisce correttamente tutti e 3 i dati, anche quando viene modificato il dato in ingresso mentre sta ancora eseguendo la trasmissione del
dato precedente.

Per RX, vengono ricevuti 3 stream di dati, uno dei quali, il secondo, è errato in quanto non rispetta il protocollo RS232 avendo lo stop bit a 0
anzichè a 1. Come si può notare, in quel caso, il ricevitore non asserirà l'uscita DAV, ma si metterà in condizione di aspettare il prossimo stream.
Se invece lo stream rispetta il protocollo, DAV viene asserito e il ricevitore resta in attesa della lettura del dato dall'esterno.


********VERIFICA DEL FUNZIONAMENTO SU DE2******************

Prima di compilare e caricare sulla scheda occore modificare i path delle librerie, ovvero: aprire il progetto UART con quartus (quartus -> UART), 
dopodichè barra degli strumenti-> assignments-> settings..-> libraries-> project libraries, eliminare quelle presenti ed aggiungere la cartella 
TX ed RX.  

Pin table IN/OUT per la verifica:
	RESETn: 	SW[17],
	WR:		SW[16],
	RD:		SW[15],
	DIN[0..7]:	SW[0..7],
	TXRDY:		LEDG[8],
	DOUT[0..7]: 	LEDR[0..7],
	DAV:		LEDG[0].

Dopo aver caricato il progetto sulla DE2 occorre resettare la macchina con l'opportuno SW.(reset attivo basso)
Aprire il programma per la comunicazione con RS232 e settare i parametri, dopodichè per trasmettere occorre settare il dato
sugli SW e settando WR a livello alto si visualizzerà il valore settato sul terminale e il led TXRDY spegnersi.
Per la ricezione occorre inviare un dato dal terminale, tale valore sarà rappresentato sui led di uscita, il led corrispondente 
a DAV si illuminerà. Quando RD verrà messo a valore alto DAV si spegnerà e sarà possibile effettuare una nuova ricezione.

