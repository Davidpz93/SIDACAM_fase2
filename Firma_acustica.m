function [Max_Bandas_dB, Frec_Max,Frecuencias] = Firma_acustica(S_Blanco,Frec_Muestreo,...
                Dim_fft, Frec_Corte1, N_Frec)
%AUTORES
% David P�rez Zapata / ing.davidpz@gmail.com
% Luis Esteban G�mez  / estebang90@gmail.com
% Luis Alberto Tafur Jim�nez / decano.ingenierias@usbmed.edu.co
% 
% Esta funci�n se encarga de recibir la informaci�n necesaria para la % extracci�n de firma
% ac�stica, b�squeda de frecuencias m�ximas y determinaci�n de umbrales.
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
            
            
            
 [Max_Bandas_dB, Frec_Max,Frecuencias]= BusquedaMaximos(S_Blanco,Frec_Muestreo,...
                Dim_fft, Frec_Corte1, N_Frec);