%% SOLUCION 1: Bayes Classifier
%Es un clasificador probabilístico que se fundamenta en el teorema de Bayes. 
%Como utiliza una hipótesis simplificadora como es la independencia entre 
% las variables que se van a usar.

% PASO 1: Carga y seleccion de los elementos de la imagen Training para
% determinar la probabilidad de los elementos encontrados para ser
% utilizados en el desarrollo del seleccionador.



% Cargar imagen
% Se realiza la carga de la imagen *.png al programa MatLab para empezar el
% analisis de esta.
%
% se limpia la pantalla y se borra la memoria utilizada hasta el momento
 clear all, close all, clc;
 warning('off', 'Images:initSize:adjustingMag');
% %% Se carga el path de la imagen *.png que se va a analizar
%filename = uigetfile('*.png','Select an image file');
filename = 'Training_02.png';
im = imread(filename);
% Muestra La Imagen de entrada
imshow(im);
title('Imagen de entrada')
%% Scale data and display as image%
% Escala de informacion y desplego como imagen 
imagesc(im);
I=rgb2gray(im);
im_g=I;

% Binarización 
umb=graythresh(im_g); 
bw=(im2bw(im_g,umb));
% Operación morfológica bridge. Los puentes de sin conectar píxeles, 
%es decir, establecen píxeles con valores 0 
%si tienen dos vecinos distintos de cero que no están conectados.
BW4 = bwmorph(bw,'bridge');

% Quita los píxeles aislados (1s individuales que están rodeados por 0s)
BW5 = bwmorph(BW4,'clean');

% %% Recortar Caracteres
[L Ne] = bwlabel(BW5);  
 %% Calcular propiedades de los objetos de la imagen 
Area= regionprops(L,'Area');
Centroide= regionprops(L,'Centroid');
Perimetro= regionprops(L,'Perimeter');
%%
Area1=cell2mat(struct2cell(Area)');
Perimetro1=cell2mat(struct2cell(Perimetro)');
Centroide1=cell2mat(struct2cell(Centroide)');
%%
Trainig=[Centroide1,Area1,Perimetro1];
TrainigOrdenado=sortrows(Trainig,2);
%%
X_training=TrainigOrdenado(:,3);
Y_training=TrainigOrdenado(:,4);
%%
plot(X_training,Y_training,':');

%%
prueba1=struct2cell(Area)';
prueba2=struct2cell(Centroide)';
prueba3=struct2cell(Perimetro)';
%%

%Total=[prueba1, prueba2];

 %% Se ordena por la posicion y, de la coordenada (x,y) del centroide de
% la imagen recortada de cada elemento seleccionado


boundingbox1=sortrows(boundingbox,2);

valor_total=size(propied,1);





%%

% SOLUCION 2: OCR (Optical Character Recognition)
%              Reconocimiento optico de caracteres
%% %%%%%%%%%%%%%%%%%%%%%
% Cargar imagen
% Se realiza la carga de la imagen *.png al programa MatLab para empezar el
% analisis de esta.
%
% se limpia la pantalla y se borra la memoria utilizada hasta el momento
 clear all, close all, clc;
% %% Se carga el path de la imagen *.png que se va a analizar
%filename = uigetfile('*.png','Select an image file');
filename = 'Testing.png';
im = imread(filename);
% Muestra La Imagen de entrada
imshow(im);
title('Imagen de entrada')
% Scale data and display as image%
% Escala de informacion y desplego como imagen 
imagesc(im);
I=rgb2gray(im);
im_g=I;

% Binarización 
umb=graythresh(im_g); 
bw=(im2bw(im_g,umb));
% Operación morfológica bridge. Los puentes de sin conectar píxeles, 
%es decir, establecen píxeles con valores 0 
%si tienen dos vecinos distintos de cero que no están conectados.
BW4 = bwmorph(bw,'bridge');

% Quita los píxeles aislados (1s individuales que están rodeados por 0s)
BW5 = bwmorph(BW4,'clean');

% %% Recortar Caracteres
[L Ne] = bwlabel(BW5);  
 % Calcular propiedades de los objetos de la imagen 
propied= regionprops(L);

%%

propied1=AreaPrueba(L);

%%
% Se selecciona la propiedad Bounding Box de la imagen
for n=1:size(propied,1) 
boundingbox(n,:)=propied(n).BoundingBox;
end
 %% Se ordena por la posicion y, de la coordenada (x,y) del centroide de
% la imagen recortada de cada elemento seleccionado
boundingbox1=sortrows(boundingbox,2);

valor_total=size(propied,1);


%% Redimenzionar los elementos de la imagen de prueba


 %%
clear boundingbox;
for  n=1:Ne
 boundingbox(n,:)=boundingbox1(n,:);
end
%%
caracter={};

for i=1:Ne 
        boxpletra=boundingbox1(i,:);
        caracter{i}=imcrop(BW5,boxpletra);
       
  end

%%
% Escalar caracteres al tamaño del patrón o template
for i=1:n
    caracter_r{i}=imresize(caracter{i},[68 40]);
end

%% Calcular area y perimetro del la letra
Area={};
for i=1:n
Area{i}=bwarea(caracter_r{i});
end

Perimetro={};
for i=1:n
Perimetro{i}=bwperim(caracter_r{i});
end


%%

% Dibujar BoundingBox en la imagen

for n=1:size(propied,1) 
    rectangle('Position',boundingbox1(n,:),...
        'EdgeColor','g','LineWidth',2); 
    %pause (1)
end 
%pause (0.1) 

 %%
clear boundingbox;
for  n=1:Ne
 boundingbox(n,:)=boundingbox1(n,:);
end
%%
caracter={};

for i=1:Ne 
        boxpletra=boundingbox1(i,:);
        caracter{i}=imcrop(BW5,boxpletra);
       
  end

%%
% Escalar caracteres al tamaño del patrón o template
for i=1:n
    caracter_r{i}=imresize(caracter{i},[68 40]);
end

%%
% figure
% for i=62:67
%     imshow(caracter_r{i});
%     pause(0.01)
% end

%%
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

% %% Reconocimiento de caracteres
% Desarrollo de la correlación para la determinación del valor del carácter
comp=[];
letra=[];
puntero=0;

%
for i=1:size(propied,1)
for j=1:5
comp(j,1)=corr2(caracteres{j,1},caracter_r{i});

end
puntero=find(max(comp)==comp);
letra=[letra ocr(puntero,1)];

end


%%
fileID = fopen('letras.txt','w');
fprintf(fileID,letra);
fid = fopen('letras.txt', 'wt');
%%
%Label
label={'A','S','D','F','G'};
%Matriz de Confusion
MC=[36,0,0,0,0;
2,34,0,0,0;
0,2,34,0,0;
0,0,0,36,0;
0,0,5,0,31];
%% Normalización de la matriz de confusion
MNC=100/36*MC;

%%
cm = confusionchart(MC);