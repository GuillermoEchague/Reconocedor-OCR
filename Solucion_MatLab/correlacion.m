
tic;
% se limpia la pantalla y se borra la memoria utilizada hasta el momento
clear all, close all, clc;
% %% Se carga el path de la imagen *.png que se va a analizar
%filename = uigetfile('*.png','Select an image file');
filename1 = 'Testing.png';
Im = imread(filename1);
%Im =imresize(Im,[210 336]);
Im=rgb2gray(Im);

filename2 = 'A.png';
Im2 = imread(filename2);
%Im =imresize(Im,[210 336]);
%T=rgb2gray(Im2);
T=Im2;
%global de;

[m,n]=size(Im);
Imd=double(Im);

Td=double(T);
[mt,nt]=size(T);

suma=0;
suma1=0;

for re=1:m-mt
    for co=1:n-nt
        indice=0;
        for re1=0:mt-1
            for co1=0:nt-1
                suma=Imd(re+re1,co+co1)*Td(re1+1,co1+1)+suma;
                suma1=Imd(re+re1,co+co1)*Imd(re+re1,co+co1)+suma1;
            end
        end
        C(re,co)=2*suma;
        A(re,co)=suma1;
        suma=0;
        suma1=0;
    end
end
sum=0;

for re=1:m-mt
    for co=1:n-nt
        Cn(re,co)=C(re,co)/((sqrt(A(re,co)))*sqrt(sum));
    end
end
imshow(Cn);

toc;