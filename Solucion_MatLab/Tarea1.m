%% %%%%%%%%%%%%%%%%%%%%%
% Cargar imagen
%%
clc, clear all;
%%global im I
filename = uigetfile('*.png','Select an image file');
im = imread(filename);
% Scale data and display as image
imagesc(im);
I=im;

% Carga de caracteres Letras para el OCR
caracterA=(imread('caracteres\A.bmp'));
caracterB=(imread('caracteres\B.bmp'));
caracterC=(imread('caracteres\C.bmp'));
caracterD=(imread('caracteres\D.bmp'));
caracterE=(imread('caracteres\E.bmp'));
caracterF=(imread('caracteres\F.bmp'));
caracterG=(imread('caracteres\G.bmp'));
caracterH=(imread('caracteres\H.bmp'));
caracterI=(imread('caracteres\I.bmp'));
caracterJ=(imread('caracteres\J.bmp'));
caracterK=(imread('caracteres\K.bmp'));
caracterL=(imread('caracteres\L.bmp'));
caracterM=(imread('caracteres\M.bmp'));
caracterN=(imread('caracteres\N.bmp'));
caracterO=(imread('caracteres\O.bmp'));
caracterP=(imread('caracteres\P.bmp'));
caracterQ=(imread('caracteres\Q.bmp'));
caracterR=(imread('caracteres\R.bmp'));
caracterS=(imread('caracteres\S.bmp'));
caracterT=(imread('caracteres\T.bmp'));
caracterU=(imread('caracteres\U.bmp'));
caracterV=(imread('caracteres\V.bmp'));
caracterW=(imread('caracteres\W.bmp'));
caracterX=(imread('caracteres\X.bmp'));
caracterY=(imread('caracteres\Y.bmp'));
caracterZ=(imread('caracteres\Z.bmp'));

% Redimensionado de caracteres letras
caracteres{1,1}=imresize(caracterA,[68 40]);
caracteres{2,1}=imresize(caracterB,[68 40]);
caracteres{3,1}=imresize(caracterC,[68 40]);
caracteres{4,1}=imresize(caracterD,[68 40]);
caracteres{5,1}=imresize(caracterE,[68 40]);
caracteres{6,1}=imresize(caracterF,[68 40]);
caracteres{7,1}=imresize(caracterG,[68 40]);
caracteres{8,1}=imresize(caracterH,[68 40]);
caracteres{9,1}=imresize(caracterI,[68 40]);
caracteres{10,1}=imresize(caracterJ,[68 40]);
caracteres{11,1}=imresize(caracterK,[68 40]);
caracteres{12,1}=imresize(caracterL,[68 40]);
caracteres{13,1}=imresize(caracterM,[68 40]);
caracteres{14,1}=imresize(caracterN,[68 40]);
caracteres{15,1}=imresize(caracterO,[68 40]);
caracteres{16,1}=imresize(caracterP,[68 40]);
caracteres{17,1}=imresize(caracterQ,[68 40]);
caracteres{18,1}=imresize(caracterR,[68 40]);
caracteres{19,1}=imresize(caracterS,[68 40]);
caracteres{20,1}=imresize(caracterT,[68 40]);
caracteres{21,1}=imresize(caracterU,[68 40]);
caracteres{22,1}=imresize(caracterV,[68 40]);
caracteres{23,1}=imresize(caracterW,[68 40]);
caracteres{24,1}=imresize(caracterX,[68 40]);
caracteres{25,1}=imresize(caracterY,[68 40]);
caracteres{26,1}=imresize(caracterZ,[68 40]);

% Asignacion de caracteres para ocr
ocr(1,1)='A';
ocr(2,1)='B';
ocr(3,1)='C';
ocr(4,1)='D';
ocr(5,1)='E';
ocr(6,1)='F';
ocr(7,1)='G';
ocr(8,1)='H';
ocr(9,1)='I';
ocr(10,1)='J';
ocr(11,1)='K';
ocr(12,1)='L';
ocr(13,1)='M';
ocr(14,1)='N';
ocr(15,1)='O';
ocr(16,1)='P';
ocr(17,1)='Q';
ocr(18,1)='R';
ocr(19,1)='S';
ocr(20,1)='T';
ocr(21,1)='U';
ocr(22,1)='V';
ocr(23,1)='W';
ocr(24,1)='X';
ocr(25,1)='Y';
ocr(26,1)='Z';

% Fin Carga de caracteres


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
%
% hold on;
% figure;
% imshow(im_g);
% title('imagen equalizada');


% Binarización 
umb=graythresh(im_g); 
bw=imcomplement(im2bw(im_g,umb));
bw=medfilt2(bw, [8, 8], 'symmetric');
bw;

% Etiquetar elementos conectados 
[L Ne]=bwlabel(bw); 

% Calcular propiedades de los objetos de la imagen 
propied = regionprops(L);
hold on; 


% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% PATENTE

% Recorte patente de la imagen
bw1=imcomplement(bw);

Ic=bw1;
st=strel('disk',18);                     %Elemento estructurante de 10 pixeles de radio

IM2=imbothat(Ic,st);                     %Hace Bottom-Hat
I3=IM2;                                  %Aplica Umbral
LH=strel('square',20);                  %Elemento estructurante lineal horizontal
IM3=imclose(I3,LH);                      %Closing con elemento estructurante
 LV=strel('square',5);                 %Elemento estructurante lineal vertical
 IM4=imopen(IM3,LV);                      %Hace opening con elemento estructurante 
% DIV=strel('line',70,90);                 %Elemento estructurante lineal vertical
% DIH=strel('line',40,0);                  %Elemento estrucutrante lineal horizontal
IM5=imdilate(IM4,LV);                   %Dilata con E.E. vertical
IM6=imdilate(IM3,LH);                   %Dilata con E.E. horizontal
bw=IM6;
%
% hold on;
%  figure
%  imshow(bw);
 %
[L Ne]=bwlabel(bw); 
propied=regionprops(L); 
clear boundingbox;
for i=1:Ne
    boundingbox(i,:)=propied(i,:).BoundingBox;
end
proporcion=boundingbox(:,3)./boundingbox(:,4);
puntero=find(min(abs(proporcion-3.5))==abs(proporcion-3.5));
boxplaca=propied(puntero,:).BoundingBox;    %Tamaño inicial de la region

boxplaca=[...
    boxplaca(1,1)...
    boxplaca(1,2)...
    boxplaca(1,3)...
    boxplaca(1,4)];

% Graficar las 'cajas' de frontera de los objetos 
for n=1:size(propied,1) 
    rectangle('Position',propied(n).BoundingBox,...
        'EdgeColor','g','LineWidth',2) 
    pause (0.01)
end 
pause (0.1) 
hold on;
%% guidata(hObject,handles);
clear boundingbox;
for i=1:Ne
    boundingbox(i,:)=propied(i,:).BoundingBox;
end
proporcion=boundingbox(:,3)./boundingbox(:,4);
disp(proporcion);
puntero=find(proporcion>0.82 | proporcion<0.2);
proporcion(puntero)=0;
puntero=find(proporcion~=0);
[f c]=size(puntero);
disp(puntero);
caracter={};
% for i=1:f
%     boxplaca=propied(puntero(i,1),:).BoundingBox;
%     caracter{i}=imcrop(placa,boxplaca);
% end
disp(caracter);
[f c]=size(caracter);
sizes=[];
for i=1:c
    sizes=[sizes; size(caracter{i})];
end
disp(sizes);
[orden indice]=sort(sizes,1,'descend');
indice2=indice(1:6,1)
disp(indice2);
indice2=sort(indice2);
disp(indice2(:,1));
caracte2={};
for i=1:6
    caracter2{i}=caracter{indice2(i,1)};
end
disp(caracter2);

%% Escalar caracteres al tamaño del patrón o template
for i=1:6
    caracter_r{i}=imresize(caracter2{i},[68 40]);
end

%% Reconocimiento de caracteres
[f c]=size(caracter_r);
comp=zeros(15,1);
puntero=0;
patente=[''];

comp=0;
for i=1:2
    for j=1:26
        comp(j,1)=corr2(caracteres{j,1},caracter_r{i})
    end
    puntero=find(max(comp)==comp);
    patente=[patente ocr(puntero,1)];
end

% comp=0;
% for i=3:4
%     for j=1:36
%         comp(j,1)=corr2(caracteres{j,1},caracter_r{i});
%     end
%     puntero=find(max(comp)==comp);
%     patente=[patente ocr(puntero,1)];
% end
% 
% comp=0;
% for i=5:6
%     for j=1:10
%         comp(j,1)=corr2(caracteres{j,1},caracter_r{i});
%     end
%     puntero=find(max(comp)==comp);
%     patente=[patente ocr(puntero,1)];
% end

