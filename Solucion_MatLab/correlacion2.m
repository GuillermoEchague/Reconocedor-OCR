
tic;
% se limpia la pantalla y se borra la memoria utilizada hasta el momento
clear all, close all, clc;
% %% Se carga el path de la imagen *.png que se va a analizar
%filename = uigetfile('*.png','Select an image file');
filename1 = 'Testing.png';
Im = imread(filename1);
%Im =imresize(Im,[210 336]);
Im=(Im);

filename2 = 'A.png';
Im2 = imread(filename2);
%Im =imresize(Im,[210 336]);
%T=rgb2gray(Im2);
T=(Im2);





[m,n]=size(Im);
Imd=double(Im);

Td=double(T);
[mt,nt]=size(T);

suma1=0;
suma2=0;
suma3=0;


MT=mean(mean(Td));
%%
for re=1:m-mt
    for co=1:n-nt
        for re1=0:mt-1
            for co1=0:nt-1	

                Itemp(re1+1,co1+1)=Imd(re+re1,co+co1);
            end
        end
            MI=mean(mean(Itemp));
        for re1=0:mt-1
            for co1=0:nt-1
            suma1=(Itemp(re1+1,co1+1)-MI)*(Td(re1+1,co1+1)-MT)+suma1;
            suma2=((Itemp(re1+1,co1+1)-MI)^2)+suma2;
            suma3=((Td(re1+1,co1+1)-MT)^2)+suma3;
            end
        end

        CL(re,co)=suma1/((sqrt(suma2)*sqrt(suma3))+eps);
         suma1=0;
         suma2=0;
         suma3=0;
    end
end
 CLN=mat2gray(CL);
 imshow(CLN);

toc;