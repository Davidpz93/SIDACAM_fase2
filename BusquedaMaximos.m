function [Max_Bandas_dB, Frec_Max,Frecuencias]=BusquedaMaximos(S_Blanco,Frec_Muestreo,...
                Dim_fft, Frec_Corte1, N_Frec)

%AUTORES
% David Pérez Zapata / ing.davidpz@gmail.com
% Luis Esteban Gómez  / estebang90@gmail.com
% Luis Alberto Tafur Jiménez / decano.ingenierias@usbmed.edu.co
% 
% Esta función se encarga de buscar los máximos representativos de la señal según un rango
% en frecuencia previamente determinado. Guarda en memoria el nivel de dichos máximos y las
% frecuencias en las cuales fueron encontrados.
% 
% ENTRADAS
% S_Blanco                    Double. Señal de la lancha ingresada.
% Frec_Muestreo               Double. Frecuencia de muestreo de la señal. [Hertz]
% Dim_fft                     Double. Número de puntos para realizar la fft en el pwelch.
% Frec_Corte1                 Double. Frecuencia de corte inferior de la señal. [Hertz]
% N_Frec                      Double. Número de frecuencias para la firma acústica.
% SALIDAS
% Max_Bandas_dB               Double. Valores de los niveles en decibeles de la PSD. [dB]
% Frec_Max                    Double. Valores de las frecuencias donde se encontraron máximos. 
%                             [Hertz]
% Frecuencias                 Double. Vector de frecuencias determinado por pwelch. [Hertz]


Orden_Filtro = 8;   %Orden del filtro Butterworth.
Step = 50 ;         %Delta del banco de filtros, desviación estándar.
ID = 1;             %Indice de directividad (Omnidireccional).

Max_Bandas_dB = zeros(1,N_Frec); %maximo de bandas en dB.
Frec_Max = zeros(1,N_Frec);   %maximos de frecuencias en decibeles

for i=1:N_Frec
    
    % Dise?o Filtro Pasa-Banda
    Frec_Corte2 = Frec_Corte1 + Step;
    Param_Filtro = fdesign.bandpass('N,F3dB1,F3dB2',...
        Orden_Filtro,Frec_Corte1,Frec_Corte2,Frec_Muestreo);
    Filtro = design(Param_Filtro,'butter');
    
    % Densidad Espectral de Potencia de la señal filtrada
    S_Blanco_Filtrada = filter(Filtro,S_Blanco);
    [pxx,Frecuencias]=pwelch(S_Blanco_Filtrada,hamming(Dim_fft),[], [], Frec_Muestreo);
    pxxdB = 10*log10(pxx);
    
    % Búsqueda de los valores Máximos y su correspondiente frecuencia
    [Max_Bandas_dB(i),posicion] = max(pxxdB);
    Frec_Max(i) = Frecuencias(posicion);
    Frec_Corte1 = Frec_Corte2;
end

