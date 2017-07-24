function [Max_Bandas_dB, Frec_Max,Frecuencias] = Firma_acustica(S_Blanco,Frec_Muestreo,...
                Dim_fft, Frec_Corte1, N_Frec)
%AUTORES
% David Pérez Zapata / ing.davidpz@gmail.com
% Luis Esteban Gómez  / estebang90@gmail.com
% Luis Alberto Tafur Jiménez / decano.ingenierias@usbmed.edu.co
% 
% Esta función se encarga de recibir la información necesaria para la % extracción de firma
% acústica, búsqueda de frecuencias máximas y determinación de umbrales.
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
            
            
            
 [Max_Bandas_dB, Frec_Max,Frecuencias]= BusquedaMaximos(S_Blanco,Frec_Muestreo,...
                Dim_fft, Frec_Corte1, N_Frec);