% OCR (Optical Character Recognition)
%% %%%%%%%%%%%%%%%%%%%%%
% Cargar imagen
% Se realiza la carga de la imagen *.png al programa MatLab para empezar el
% analisis de esta.
%%
% se limpia la pantalla y se borra la memoria utilizada hasta el momento
clc, clear all;
close all;
%% global im I
filename = uigetfile('*.png','Select an image file');
im = imread(filename);
imshow(im);
title('Imagen de entrada')
% Scale data and display as image%
% Escala de informacion y desplego como imagen 
%
imagesc(im);
I=rgb2gray(im);
%hold on
%figure 
%imshow(I);title('imagen 1');

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
%figure;
%imshow(im_g);title('imagen 2');

% Binarización 
umb=graythresh(im_g); 
bw=(im2bw(im_g,umb));
%hold on
%figure 
%imshow(bw);title('imagen 3');

%
%L=bwlabel(bw,8);
%hold on
%figure
%imshow(L);title('imagen equalizada 4');
%
%figure
%imshow(bw);title('imagen original');

% Unir pixeles
BW4 = bwmorph(bw,'bridge');
% Limpieza de pixeles solitarios
BW5 = bwmorph(BW4,'clean');
%
%imshow(BW5);
% Recortar Caracteres
[L Ne] = bwlabel(BW5);  

% Calcular propiedades de los objetos de la imagen 
propied= regionprops(L);

% Graficar las 'cajas' de frontera de los objetos
imshow(BW5);
for n=1:size(propied,1) 
    rectangle('Position',propied(n).BoundingBox,...
        'EdgeColor','g','LineWidth',2); 
    pause (0.01)
end 
pause (0.1) 

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
for i=1:f
    boxplaca=propied(puntero(i,1),:).BoundingBox;
    caracter{i}=imcrop(BW5,boxplaca);
end
disp(caracter);
[f c]=size(caracter);
sizes=[];
for i=1:c
    sizes=[sizes; size(caracter{i})];
end
disp(sizes);
%Listo

%%


%%
n=size(propied,1);
[orden indice]=sort(sizes,1,'descend')
%%
indice2=indice(1:size(orden),1)
disp(indice2);
indice2=sort(indice2);
disp(indice2(:,1));
caracte2={};
%%
for i=1:size(orden)
    caracter2{i}=caracter{indice2(i,1)};
end
disp(caracter2);

%% Escalar caracteres al tamaño del patrón o template

for i=1:size(orden)
    caracter_r{i}=imresize(caracter2{i},[68 40]);
end
%%
 % Label and count connected components
    [L Ne] = bwlabel(BW5);  
    %%
    for n=1:Ne
        [r,c] = find(L==n);
        % Extract letter
        n1=bwlabel(min(r):max(r),min(c):max(c));  
        % Resize letter (same size of template)
        img_r=imresize(n1,[42 24]);
        %Uncomment line below to see letters one by one
         %imshow(img_r);pause(0.5)
        % -------------------------------------------------------------------
        % Call fcn to convert image to text
        %letter=read_letter(img_r,num_letras);
        % Letter concatenation
        %word=[word letter];
    end

%%
% idx=max(max(L));
% for o=1:idx
%     O=L==o;
%     H=regionprops(double(O),'BoundingBox');
%     pt(o,1)=round(H.BoundingBox(1));
%     pt(o,2)=round(H.BoundingBox(2));
%     pt(o,3)=round(H.BoundingBox(3));
%     pt(o,4)=round(H.BoundingBox(4));
% end
% 
% %%
% for o=1:idx
%      Im(pt(o,2):1:pt(o,2)+pt(o,4),pt(o,1))=1;
%      Im(pt(o,2):1:pt(o,2)+pt(o,4),pt(o,1)+pt(o,3))=1;
%      Im(pt(o,2),pt(o,1):1:pt(o,1)+pt(o,3))=1;
%      Im(pt(o,2)+pt(o,4),pt(o,1):1:pt(o,1)+pt(o,3))=1;
% end
% %% Graficar las 'cajas' de frontera de los objetos 
% % Dibujar los BoundingBox en la imagen
% st = regionprops(bw, 'BoundingBox' );
% for k = 1 : length(st)
%   thisBB = st(k).BoundingBox;
%   rectangle('Position', [thisBB(1),thisBB(2),thisBB(3),thisBB(4)],...
%   'EdgeColor','r','LineWidth',2 )
% end

    
 %% Solucion 2 
 %Desarrollo de Template para comparacion 
 %% Carga de caracteres letras para el OCR
caracterA=(imread('caracteres\A.bmp'));
caracterD=(imread('caracteres\D.bmp'));
caracterF=(imread('caracteres\F.bmp'));
caracterG=(imread('caracteres\G.bmp'));
caracterS=(imread('caracteres\S.bmp'));

%% Redimensionado de caracteres letras
caracteres{1,1}=imresize(caracterA,[68 40]);
caracteres{2,1}=imresize(caracterD,[68 40]);
caracteres{3,1}=imresize(caracterF,[68 40]);
caracteres{4,1}=imresize(caracterG,[68 40]);
caracteres{5,1}=imresize(caracterS,[68 40]);

%% Asignacion de caracteres para ocr
ocr(1,1)='A';
ocr(2,1)='D';
ocr(3,1)='F';
ocr(4,1)='G';
ocr(5,1)='S';
save ('caracteres','caracteres')
%clear all;
%%
C = struct2cell(st);
% Fin Carga de caracteres
%%
global caracteres
num_letras=size(C,2);
comp=[ ];
%% Desarrollo de la correlación para la determinación del valor del carácter
for n=1:size(caracteres)
for m=1:num_letras
    sem=corr2(caracteres{n,1},C{1,m});
    comp=[comp sem];
end
end

%%
vd=find(comp==max(comp));
%*-*-*-*-*-*-*-*-*-*-*-*-*-
if vd==1
    letter='A';
elseif vd==2
    letter='D';
elseif vd==3
    letter='F';
elseif vd==4
    letter='G';
elseif vd==5
    letter='S';
end


%% Reconocimiento de caracteres
[f c]=size(caracter_r);
%comp=zeros(15,1);
puntero=0;
patente=[''];

comp=0;
for i=1:n
    for j=1:5
        comp(j,1)=corr2(caracteres{j,1},caracter_r{i});
    end
    puntero=find(max(comp)==comp);
    patente=[patente ocr(puntero,1)];
end

    %%
% %% Carga de caracteres numeros para el OCR
% caracterA=(imread('caracteres\A.bmp'));
% caracterB=(imread('caracteres\B.bmp'));
% caracterC=(imread('caracteres\C.bmp'));
% caracterD=(imread('caracteres\D.bmp'));
% caracterE=(imread('caracteres\E.bmp'));
% caracterF=(imread('caracteres\F.bmp'));
% caracterG=(imread('caracteres\G.bmp'));
% caracterH=(imread('caracteres\H.bmp'));
% caracterI=(imread('caracteres\I.bmp'));
% caracterJ=(imread('caracteres\J.bmp'));
% caracterK=(imread('caracteres\K.bmp'));
% caracterL=(imread('caracteres\L.bmp'));
% caracterM=(imread('caracteres\M.bmp'));
% caracterN=(imread('caracteres\N.bmp'));
% caracterO=(imread('caracteres\O.bmp'));
% caracterP=(imread('caracteres\P.bmp'));
% caracterQ=(imread('caracteres\Q.bmp'));
% caracterR=(imread('caracteres\R.bmp'));
% caracterS=(imread('caracteres\S.bmp'));
% caracterT=(imread('caracteres\T.bmp'));
% caracterU=(imread('caracteres\U.bmp'));
% caracterV=(imread('caracteres\V.bmp'));
% caracterW=(imread('caracteres\W.bmp'));
% caracterX=(imread('caracteres\X.bmp'));
% caracterY=(imread('caracteres\Y.bmp'));
% caracterZ=(imread('caracteres\Z.bmp'));
% 
% 
% 
% %% Redimensionado de caracteres letras
% caracteres{1,1}=imresize(caracterA,[68 40]);
% caracteres{2,1}=imresize(caracterB,[68 40]);
% caracteres{3,1}=imresize(caracterC,[68 40]);
% caracteres{4,1}=imresize(caracterD,[68 40]);
% caracteres{5,1}=imresize(caracterE,[68 40]);
% caracteres{6,1}=imresize(caracterF,[68 40]);
% caracteres{7,1}=imresize(caracterG,[68 40]);
% caracteres{8,1}=imresize(caracterH,[68 40]);
% caracteres{9,1}=imresize(caracterI,[68 40]);
% caracteres{10,1}=imresize(caracterJ,[68 40]);
% caracteres{11,1}=imresize(caracterK,[68 40]);
% caracteres{12,1}=imresize(caracterL,[68 40]);
% caracteres{13,1}=imresize(caracterM,[68 40]);
% caracteres{14,1}=imresize(caracterN,[68 40]);
% caracteres{15,1}=imresize(caracterO,[68 40]);
% caracteres{16,1}=imresize(caracterP,[68 40]);
% caracteres{17,1}=imresize(caracterQ,[68 40]);
% caracteres{18,1}=imresize(caracterR,[68 40]);
% caracteres{19,1}=imresize(caracterS,[68 40]);
% caracteres{20,1}=imresize(caracterT,[68 40]);
% caracteres{21,1}=imresize(caracterU,[68 40]);
% caracteres{22,1}=imresize(caracterV,[68 40]);
% caracteres{23,1}=imresize(caracterW,[68 40]);
% caracteres{24,1}=imresize(caracterX,[68 40]);
% caracteres{25,1}=imresize(caracterY,[68 40]);
% caracteres{26,1}=imresize(caracterZ,[68 40]);
% 
% %% Asignacion de caracteres para ocr
% ocr(1,1)='A';
% ocr(2,1)='B';
% ocr(3,1)='C';
% ocr(4,1)='D';
% ocr(5,1)='E';
% ocr(6,1)='F';
% ocr(7,1)='G';
% ocr(8,1)='H';
% ocr(9,1)='I';
% ocr(10,1)='J';
% ocr(11,1)='K';
% ocr(12,1)='L';
% ocr(13,1)='M';
% ocr(14,1)='N';
% ocr(15,1)='O';
% ocr(16,1)='P';
% ocr(17,1)='Q';
% ocr(18,1)='R';
% ocr(19,1)='S';
% ocr(20,1)='T';
% ocr(21,1)='U';
% ocr(22,1)='V';
% ocr(23,1)='W';
% ocr(24,1)='X';
% ocr(25,1)='Y';
% ocr(26,1)='Z';
% % Fin Carga de caracteres

%%
