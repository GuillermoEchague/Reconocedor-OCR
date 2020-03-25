% OCR (Optical Character Recognition)
%% %%%%%%%%%%%%%%%%%%%%%
% Cargar imagen
% Se realiza la carga de la imagen *.png al programa MatLab para empezar el
% analisis de esta.
%
% se limpia la pantalla y se borra la memoria utilizada hasta el momento
 clear all, close all, clc;
 %%
filename = uigetfile('*.png','Select an image file');
im = imread(filename);
% Muestra La Imagen de entrada
imshow(im);
title('Imagen de entrada')
% Scale data and display as image%
% Escala de informacion y desplego como imagen 
imagesc(im);
I=rgb2gray(im);
% Normalizar Contraste
X=I;
[N,M] = size(X);
    Y = zeros(N,M);
    [i,j] = sort(X(:));
    z = zeros(N*M,1);
    d = fix(N*M/256+0.5);
    for i=1:255;
        z((i-1)*d+1:i*d) = (i-1)*ones(d,1);
    end
    z(255*d+1:N*M) = 255*ones(N*M-255*d,1);
    Y(j) = z;
im_g=X;

% Binarización 
umb=graythresh(im_g); 
bw=(im2bw(im_g,umb));
% Unir pixeles
BW4 = bwmorph(bw,'bridge');
% Limpieza de pixeles solitarios
BW5 = bwmorph(BW4,'clean');

% Recortar Caracteres
[L Ne] = bwlabel(BW5);  

% Calcular propiedades de los objetos de la imagen 
propied= regionprops(L);

% Graficar las 'cajas' de frontera de los objetos
%imshow(BW5);
valor_total=size(propied,1);
for n=1:size(propied,1) 
    rectangle('Position',propied(n).BoundingBox,...
        'EdgeColor','g','LineWidth',2); 
    pause (0.01)
end 
pause (0.1) 
%%
clear boundingbox;
for i=1:valor_total
    boundingbox(i,:)=propied(i,:).BoundingBox;
end
%%
proporcion=boundingbox(:,3)./boundingbox(:,4);
[f c]=size(proporcion);
disp(proporcion);
%%
puntero=find(proporcion>2 | proporcion<0);
proporcion(puntero)=0;
puntero=find(proporcion~=0);
%%
caracter={};
for i=1:f
    boxplaca=propied(puntero(i,1),:).BoundingBox;
    caracter{i}=imcrop(BW5,boxplaca);
end
%disp(caracter);
%%
[f c]=size(caracter);
sizes=[];
for i=1:c
    sizes=[sizes; size(caracter{i})];
end
disp(sizes);
%%
%[orden indice]=sort(sizes,1)
%%
n=size(sizes);
indice2=sizes(1:n,1)
disp(indice2);
%indice2=sort(indice2);
%disp(indice2(:,1));
caracte2={};

for i=1:n
    caracter2{i}=caracter{indice2(i,1)};
end
disp(caracter2);

%% Escalar caracteres al tamaño del patrón o template
for i=1:n
    caracter_r{i}=imresize(caracter2{i},[68 40]);
end
 %% Solucion 2 
 %Desarrollo de Template para comparacion 
 % Carga de caracteres letras para el OCR
caracterA=(imread('caracteres\A.bmp'));
caracterD=(imread('caracteres\D.bmp'));
caracterF=(imread('caracteres\F.bmp'));
caracterG=(imread('caracteres\G.bmp'));
caracterS=(imread('caracteres\S.bmp'));

% Redimensionado de caracteres letras
caracteres{1,1}=imresize(caracterA,[68 40]);
caracteres{2,1}=imresize(caracterD,[68 40]);
caracteres{3,1}=imresize(caracterF,[68 40]);
caracteres{4,1}=imresize(caracterG,[68 40]);
caracteres{5,1}=imresize(caracterS,[68 40]);

% Asignacion de caracteres para ocr
ocr(1,1)='A';
ocr(2,1)='D';
ocr(3,1)='F';
ocr(4,1)='G';
ocr(5,1)='S';
%clear all;

%% Reconocimiento de caracteres
[f c]=size(caracter_r);

%%
for j=1:5
caracteres{j,1}
figure
imshow(caracteres{j,1});
end

%%
for i=1:5
caracter_r{i}
figure
imshow(caracter_r{i});
end
%%
%close all;
% %%
%figure
%imshow(caracter_r{2});

%% Desarrollo de la correlación para la determinación del valor del carácter
comp=[];
letra=[];
puntero=0;

%%
for i=1:valor_total
for j=1:5
comp(j,1)=corr2(caracteres{j,1},caracter_r{i});
%figure
%imshow(caracteres{j,1});
end
puntero=find(max(comp)==comp);
letra=[letra ocr(puntero,1)];

end
%%
fileID = fopen('letras.txt','w');
fprintf(fileID,letra);