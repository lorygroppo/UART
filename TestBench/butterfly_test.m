clc 
clear all
format long

%% create start signal
fid=fopen('start_signal.txt','w');
n=inputdlg({'Numero di esecuzioni:'},'Butterfly Simulation',[1 50],{'2'});
n=str2num(n{1});
answer = questdlg('Selezionare la modalità operativa della butterfly','Butterfly Simulation','ESECUZIONE BURST','ESECUZIONE SINGOLA','ESECUZIONE SINGOLA');
switch answer
    case 'ESECUZIONE SINGOLA'
        time=500;
    case 'ESECUZIONE BURST'
        time=240;
end
fprintf(fid,'60 ns\n',time);
for i=2:n
    fprintf(fid,'%i ns\n',time);
end
fclose(fid);

%% create *.do file
%compile .do
fid=fopen('simulation.do','w');
fprintf(fid,'vlib work\n');
fprintf(fid,'vcom ./vhd/bit_shifter.vhd\n');
fprintf(fid,'vcom ./vhd/reg_16bit.vhd\n');
fprintf(fid,'vcom ./vhd/arrotondamento.vhd\n');
fprintf(fid,'vcom ./vhd/multiplier_behav.vhd\n');
fprintf(fid,'vcom ./vhd/Adder_behav.vhd\n');
fprintf(fid,'vcom ./vhd/Sequencer.vhd\n');
fprintf(fid,'vcom ./vhd/Butterfly_structural.vhd\n');
fprintf(fid,'vcom ./vhd/TB_Butterfly.vhd\n\n');

fprintf(fid,'vsim -c work.tb_butterfly\n');
fprintf(fid,'add log sim:/tb_butterfly/*\n\n');

fprintf(fid,'run 0 ns\n');
fprintf(fid,'run %d ns\n\n',(time+40)*(n+1)+100);

fprintf(fid,'quit -sim\n');
fprintf(fid,'quit -f');
fclose(fid);

%waveform .do
fid=fopen('waveform.do','w');
fprintf(fid,'dataset open vsim.wlf\n');
fprintf(fid,'add wave *\n');
fprintf(fid,'view wave\n');
fprintf(fid,'wave zoom full');
fclose(fid);

%% create data signal
index=0;
fid=fopen('input_vectors.txt','w');
figure(1)
hold on
for j=1:n
    wr=sin((j*2*pi/(n-1))-1);
    wi=cos((j*2*pi/(n-1))-1);
    ar=sin((j*2*pi/(n-1))-1+2*pi/3);
    ai=cos((j*2*pi/(n-1))-1+2*pi/3);
    br=sin((j*2*pi/(n-1))-1+4*pi/3);
    bi=cos((j*2*pi/(n-1))-1+4*pi/3);
    
    plot(j-1,ar,'b.')
    plot(j-1,ai,'r.')
    plot(j-1,br,'g.')
    plot(j-1,bi,'k.')
    plot(j-1,wr,'m.')
    plot(j-1,wi,'c.')
    
    
    %input generation
    wr=create_vector(wr,1,15);
    wi=create_vector(wi,1,15);
    ar=create_vector(ar,1,15);
    ai=create_vector(ai,1,15);
    br=create_vector(br,1,15);
    bi=create_vector(bi,1,15);

    %write input file
    fprintf(fid,'%s %s\n',ar.bin, wr.bin);
    fprintf(fid,'%s %s\n',br.bin, wi.bin);
    fprintf(fid,'%s %s\n',ai.bin, wi.bin);
    fprintf(fid,'%s %s',bi.bin, wi.bin);
    if j<n
        fprintf(fid,'\n');
    end

    %internal operation
        %multiplication
    m1=create_vector(br.dec*wr.dec,3,30);
    m2=create_vector(bi.dec*wi.dec,3,30);
    m3=create_vector(br.dec*wi.dec,3,30);
    m4=create_vector(bi.dec*wr.dec,3,30);
    m5=create_vector(2*ar.dec,3,30);
    m6=create_vector(2*ai.dec,3,30);

        %sum
    s1=create_vector(ar.dec+m1.dec,3,30);
    s2=create_vector(s1.dec-m2.dec,3,30); %ar'
    s3=create_vector(ai.dec+m3.dec,3,30);
    s4=create_vector(s3.dec+m4.dec,3,30); %ai'
    s5=create_vector(m5.dec-s2.dec,3,30); %br'
    s6=create_vector(m6.dec-s4.dec,3,30); %bi'

    %rounding & output
    ar_new=create_vector(s2.dec/4,1,15);
    ai_new=create_vector(s4.dec/4,1,15);
    br_new=create_vector(s5.dec/4,1,15);
    bi_new=create_vector(s6.dec/4,1,15);

    %% save result
    result(index+1)=struct('Ar',ar_new.bin, 'Br',br_new.bin, 'Ai',ai_new.bin, 'Bi',bi_new.bin);
    index=index+1;
end
hold off
title('Input Data')
legend('Ar','Ai','Br','Bi','Wr','Wi')
fields=fieldnames(result);
fclose(fid);

%% lanch ModelSim simulation
system('vsim -c -do simulation.do')

%% result check
fid=fopen('output_vectors.txt');
flog=fopen('log.txt','w');
fprintf(flog,'%4s\t%16s\t%16s\t%6s\n','Data','Modelsim Outupt','MATLAB Output','Status');
j=1;
i=1;
flag=false;
operation=struct('ok',0,'error',0);
while true
    thisline=fgetl(fid);
    if ~ischar(thisline)
        break;
    end
    flag=true;
    if thisline==result(j).(fields{i})
        status='OK';
        operation.ok=operation.ok+1;
    else
        status='ERROR';
        operation.error=operation.error+1;
    end
    fprintf(flog,'%3s:\t%16s\t%16s\t%6s\n',fields{i},thisline,result(j).(fields{i}),status);
    if i<4
        i=i+1;
    else
        i=1;
        j=j+1;
    end
end
fprintf(flog,'\n');
fprintf(flog,'Correttezza risultati: %5.2f%%\t( %d / %d )',100*operation.ok/(operation.ok+operation.error),operation.ok,operation.ok+operation.error);
fclose(fid);
fclose(flog);
if not (flag)
    disp('ERRORE: dalla simulazione ModelSim non sono stati generati output')
end
if n ~= j-1
    msg=['Warning: numero di START = ', int2str(n) ,', numero di DONE = ', int2str(j-1)];
    disp(msg)
    clear msg;
end

%% apertura risultati in ModelSim
answer = questdlg('Aprire i risultati in ModelSim?','Analisi della simulazione','Sì','No','No');
switch answer
    case 'No'
        return
    case 'Sì'
        system('vsim -do waveform.do &');
end

%% user function
function var = create_vector (dec,int,frac)
    decimale=fi(dec,1,frac+int,frac);
    var = struct('dec',decimale.data,'bin',decimale.bin);
end