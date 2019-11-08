%% Limpia la memoria de variables
clear all
close all
clc
%% Cierra y elimina cualquier objeto de tipo serial 
if ~isempty(instrfind)
    fclose(instrfind);
    delete(instrfind);
end

%% Creación de un objeto tipo serial
arduino = serial('COM5','BaudRate',9600);
fopen(arduino);
if arduino.status == 'open'
    disp('Arduino conectado correctamente \n');
else
    disp('No se ha conectado el arduino \n');
    return
end

%%pide al usuario la longitud de los eslabones 


d='introduzca l1:';

l1=input(d);
p1= [0;0;0]';

while 1       %contador_muestras < numero_muestras 
    
   clf %limpia figura 
   printAxis();%imprime eje x,y
   valor_potenciometro = fscanf(arduino,'%d');%lee el valor del potenciometro 
   theta1_deg=((valor_potenciometro)-512)*130/512; %convierte en angulos las muestras 
   theta1_rad=deg2rad(theta1_deg); %conercion de radianes a grados
   
   %se definen las matrices 
    
  TRz1=[cos(theta1_rad) -sin(theta1_rad) 0 0;sin(theta1_rad) cos(theta1_rad) 0 0;0 0 1 0;0 0 0 1]; % primera rotacion 
  TTx1=[1 0 0 l1;0 1 0 0;0 0 1 0;0 0 0 1];% primera traslacion
  
  T1=TRz1*TTx1;
  p2=T1(1:3,4);
  
 line([p1(1) p2(1)],[p1(2) p2(2)],[p1(3) p2(3)],'color',[0.8 0.8 0.8],'linewidth',5);
 pause (0.01); 

    
end