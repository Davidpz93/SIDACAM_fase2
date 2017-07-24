function [Max_Bandas_dB, Frec_Max,Frecuencias]=BusquedaMaximos(S_Blanco,Frec_Muestreo,...
                Dim_fft, Frec_Corte1, N_Frec)

%AUTORES
% David P�rez Zapata / ing.davidpz@gmail.com
% Luis Esteban G�mez  / estebang90@gmail.com
% Luis Alberto Tafur Jim�nez / decano.ingenierias@usbmed.edu.co
% 
% Esta funci�n se encarga de buscar los m�ximos representativos de la se�al seg�n un rango
% en frecuencia previamente determinado. Guarda en memoria el nivel de dichos m�ximos y las
% frecuencias en las cuales fueron encontrados.
% 
% ENTRADAS
% S_Blanco                    Double. Se�al de la lancha ingresada.
% Frec_Muestreo               Double. Frecuencia de muestreo de la se�al. [Hertz]
% Dim_fft                     Double. N�mero de puntos para realizar la fft en el pwelch.
% Frec_Corte1                 Double. Frecuencia de corte inferior de la se�al. [Hertz]
% N_Frec                      Double. N�mero de frecuencias para la firma ac�stica.
% SALIDAS
% Max_Bandas_dB               Double. Valores de los niveles en decibeles de la PSD. [dB]
% Frec_Max                    Double. Valores de las frecuencias donde se encontraron m�ximos. 
%                             [Hertz]
% Frecuencias                 Double. Vector de frecuencias determinado por pwelch. [Hertz]


Orden_Filtro = 8;   %Orden del filtro Butterworth.
Step = 50 ;         %Delta del banco de filtros, desviaci�n est�ndar.
ID = 1;             %Indice de directividad (Omnidireccional).

Max_Bandas_dB = zeros(1,N_Frec); %maximo de bandas en dB.
Frec_Max = zeros(1,N_Frec);   %maximos de frecuencias en decibeles

for i=1:N_Frec
    
    % Dise?o Filtro Pasa-Banda
    Frec_Corte2 = Frec_Corte1 + Step;
    Param_Filtro = fdesign.bandpass('N,F3dB1,F3dB2',...
        Orden_Filtro,Frec_Corte1,Frec_Corte2,Frec_Muestreo);
    Filtro = design(Param_Filtro,'butter');
    
    % Densidad Espectral de Potencia de la se�al filtrada
    S_Blanco_Filtrada = filter(Filtro,S_Blanco);
    [pxx,Frecuencias]=pwelch(S_Blanco_Filtrada,hamming(Dim_fft),[], [], Frec_Muestreo);
    pxxdB = 10*log10(pxx);
    
    % B�squeda de los valores M�ximos y su correspondiente frecuencia
    [Max_Bandas_dB(i),posicion] = max(pxxdB);
    Frec_Max(i) = Frecuencias(posicion);
    Frec_Corte1 = Frec_Corte2;
end

