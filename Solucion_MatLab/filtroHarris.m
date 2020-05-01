%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Implementacion del algoritmo de Harris para la
% deteccion de esquinas en una imagen
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% se limpia la pantalla y se borra la memoria utilizada hasta el momento
  clear all, 
 close all, 
 clc;
% %% Se carga el path de la imagen *.png que se va a analizar
filename = uigetfile('*.png','Select an image file');
im = imread(filename);
Ir=double(im);
Ir=rgb2gray(Ir);
imshow(Ir);
%%
% Se obtiene el tamaño de la imagen Ir a la cual se le extraeran las
% etiquetas

% Paso 1.
[m,n] = size(Ir);
% Se inicializaran las matrices U y S con ceros
U=zeros(size(Ir));
S=zeros(size(Ir));
% Se crea la matriz de coeficientes del pre-filtro suavizador
h=ones(3,3)/9;
% Se cambia el tipo de dato de la imagen original a double
Id=double(Ir);
% Se filtra la imagen con el filtro h promediador
If=imfilter(Id,h);
% Se generan las matrices de coeficientes para calcular el gradiente
% horizontal Hx y vertical Hy
Hx=[-0.5 0 0.5];
Hy=[-0.5 0 0.5];
% Se calculan los gradientes horizontal y vertical
Ix=imfilter(If,Hx);
Iy=imfilter(If,Hy);
% Se obtienen los coeficientes de la matriz de estructuras
HE11=Ix.*Ix;
HE22=Iy.*Iy;
HE12=Ix.*Iy; %y HE21
% Se crea la matriz de filtro Gaussiano
Hg=[0 1 2 1 0;1 3 5 3 1;2 5 9 5 2;1 3 5 3 1;0 1 2 1 0];
Hg=Hg*(1/57);
% Se filtran los coeficientes de la matriz de estructuras con el filtro
% Gaussiano
A=imfilter(HE11,Hg);
B=imfilter(HE22,Hg);
C=imfilter(HE12,Hg);
% Se fija el valor de alfa a 0,04 (Muy Sensible)
alfa=0.04;
% Se obtiene la magnitud del valor de la esquina
Rp=A+B; %Resultado parcial
Rp1=Rp.*Rp; %Resultado parcial
% Valor de la esquina (matriz Q)
Q=((A.*B)-(C.*C)-(alfa*Rp1));
% Se fija el valor del umbral
th=1000;
%% Paso 2. 
%Se obtiene la matriz U
U=Q>th;
% Se fija el valor de la vecindad
pixel=10;

%% Paso 3.
% Se obtiene el valor mas grande de Q, de una vecindad definida por la
% variable pixel

for r=1:m
    for c=1:n
        if(U(r,c)==1)
         I1=[r-pixel 1];   
         I2=[r+pixel m];   
         I3=[c-pixel 1]; 
         I4=[c-pixel n];
         
         datxi=max(I1);
         datxs=min(I2);
         datyi=max(I3);
         datys=min(I4);
         
         Bloc=Q(datxi:1:datxs,datyi:1:datys);
         
          MaxB=max(max(Bloc));  
          if(Q(r,c)==MaxB)
            S(r,c)=1;
          end 
        end
    end
end

% Se despliega la imagen original Ir
imshow(Ir);

hold on
%%
tic;
for r=1:m
    for c=1:n
    %if(S(r,c)==1)    
       plot(r,c,'+r'); 
   % end
    end
end
toc;
