




%% imagen
%%
clc, clear all;
global im I
filename = uigetfile('*.png','Select an image file');
im = imread(filename);
% Scale data and display as image
hold on;
imagesc(im);
I=imshow(im);
pause (0.1);
%% Convertir a escala de grises
% I=rgb2gray(im); 
%% Mostrar imagen
% imshow(I);
% pause (0.1);


% %% Carga de caracteres numeros para el OCR
% caracter0=(imread('caracteres\0.bmp'));
% caracter1=(imread('caracteres\1.bmp'));
% caracter2=(imread('caracteres\2.bmp'));
% caracter3=(imread('caracteres\3.bmp'));
% caracter4=(imread('caracteres\4.bmp'));
% caracter5=(imread('caracteres\5.bmp'));
% caracter6=(imread('caracteres\6.bmp'));
% caracter7=(imread('caracteres\7.bmp'));
% caracter8=(imread('caracteres\8.bmp'));
% caracter9=(imread('caracteres\9.bmp'));

%% Carga de caracteres numeros para el OCR
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



% %% Redimensionado de caracteres número
% caracteres{1,1}=imresize(caracter0,[68 40]);
% caracteres{2,1}=imresize(caracter1,[68 40]);
% caracteres{3,1}=imresize(caracter2,[68 40]);
% caracteres{4,1}=imresize(caracter3,[68 40]);
% caracteres{5,1}=imresize(caracter4,[68 40]);
% caracteres{6,1}=imresize(caracter5,[68 40]);
% caracteres{7,1}=imresize(caracter6,[68 40]);
% caracteres{8,1}=imresize(caracter7,[68 40]);
% caracteres{9,1}=imresize(caracter8,[68 40]);
% caracteres{10,1}=imresize(caracter9,[68 40]);

%% Redimensionado de caracteres letras
caracteres{11,1}=imresize(caracterA,[68 40]);
caracteres{12,1}=imresize(caracterB,[68 40]);
caracteres{13,1}=imresize(caracterC,[68 40]);
caracteres{14,1}=imresize(caracterD,[68 40]);
caracteres{15,1}=imresize(caracterE,[68 40]);
caracteres{16,1}=imresize(caracterF,[68 40]);
caracteres{17,1}=imresize(caracterG,[68 40]);
caracteres{18,1}=imresize(caracterH,[68 40]);
caracteres{19,1}=imresize(caracterI,[68 40]);
caracteres{20,1}=imresize(caracterJ,[68 40]);
caracteres{21,1}=imresize(caracterK,[68 40]);
caracteres{22,1}=imresize(caracterL,[68 40]);
caracteres{23,1}=imresize(caracterM,[68 40]);
caracteres{24,1}=imresize(caracterN,[68 40]);
caracteres{25,1}=imresize(caracterO,[68 40]);
caracteres{26,1}=imresize(caracterP,[68 40]);
caracteres{27,1}=imresize(caracterQ,[68 40]);
caracteres{28,1}=imresize(caracterR,[68 40]);
caracteres{29,1}=imresize(caracterS,[68 40]);
caracteres{30,1}=imresize(caracterT,[68 40]);
caracteres{31,1}=imresize(caracterU,[68 40]);
caracteres{32,1}=imresize(caracterV,[68 40]);
caracteres{33,1}=imresize(caracterW,[68 40]);
caracteres{34,1}=imresize(caracterX,[68 40]);
caracteres{35,1}=imresize(caracterY,[68 40]);
caracteres{36,1}=imresize(caracterZ,[68 40]);

%% Asignacion de caracteres para ocr
% ocr(1,1)='0';
% ocr(2,1)='1';
% ocr(3,1)='2';
% ocr(4,1)='3';
% ocr(5,1)='4';
% ocr(6,1)='5';
% ocr(7,1)='6';
% ocr(8,1)='7';
% ocr(9,1)='8';
% ocr(10,1)='9';

ocr(11,1)='A';
ocr(12,1)='B';
ocr(13,1)='C';
ocr(14,1)='D';
ocr(15,1)='E';
ocr(16,1)='F';
ocr(17,1)='G';
ocr(18,1)='H';
ocr(19,1)='I';
ocr(20,1)='J';
ocr(21,1)='K';
ocr(22,1)='L';
ocr(23,1)='M';
ocr(24,1)='N';
ocr(25,1)='O';
ocr(26,1)='P';
ocr(27,1)='Q';
ocr(28,1)='R';
ocr(29,1)='S';
ocr(30,1)='T';
ocr(31,1)='U';
ocr(32,1)='V';
ocr(33,1)='W';
ocr(34,1)='X';
ocr(35,1)='Y';
ocr(36,1)='Z';

%handles.caracteres=caracteres;
%handles.ocr=ocr;

%% Fin Carga de caracteres


%% Normalizar Contraste
X=I;
[N,M] = size(X);
    Y = zeros(N,M);
    [i,j] = sort(X(:));
    z = zeros(N*M,1);
    d = fix(N*M/256+0.5);
    %%
    for i=1:255;
        z((i-1)*d+1:i*d) = (i-1)*ones(d,1);
    end
    %%
    z(255*d+1:N*M) = 255*ones(N*M-255*d,1);
    Y(j) = z;
im_g=X
%%
% figure;
% imshow(X);
% title('imagen equalizada');


%% Binarización 
umb=graythresh(im_g)
%%
bw=imcomplement(im2bw(im_g,umb));
%%
bw=medfilt2(bw, [8, 8], 'symmetric');
%handles.bw=bw;

%% Mostrar imagen 
% axes(handles.axes1);
% imshow(img);
% pause (0.1);

% %% Etiquetar elementos conectados 
% [L Ne]=bwlabel(bw);
% %handles.Ne=Ne;

%% Calcular propiedades de los objetos de la imagen 
propied= regionprops(L);
%handles.propied=propied;
hold on; 

%% Graficar las 'cajas' de frontera de los objetos 
for n=1:size(propied,1) 
    rectangle('Position',propied(n).BoundingBox,...
        'EdgeColor','g','LineWidth',2) 
    pause (0.01)
end 
pause (0.1) 
hold off;
%guidata(hObject,handles);


%% patente  %%
%% Recortar Caracteres
placa=handles.placa;
caracteres=handles.caracteres;
ocr=handles.ocr;
[L Ne]=bwlabel(placa); 
handles.Ne=Ne;
disp(Ne);

%% Calcular propiedades de los objetos de la imagen 
propied= regionprops(L);
handles.propied=propied;
hold on; 

%% Graficar las 'cajas' de frontera de los objetos 
for n=1:size(propied,1) 
    rectangle('Position',propied(n).BoundingBox,...
        'EdgeColor','g','LineWidth',2) 
    pause (0.01)
end 
pause (0.1) 
hold off;
guidata(hObject,handles);
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
    caracter{i}=imcrop(placa,boxplaca);
end
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
    for j=11:36
        comp(j,1)=corr2(caracteres{j,1},caracter_r{i});
    end
    puntero=find(max(comp)==comp);
    patente=[patente ocr(puntero,1)];
end

comp=0;
for i=3:4
    for j=1:36
        comp(j,1)=corr2(caracteres{j,1},caracter_r{i});
    end
    puntero=find(max(comp)==comp);
    patente=[patente ocr(puntero,1)];
end

comp=0;
for i=5:6
    for j=1:10
        comp(j,1)=corr2(caracteres{j,1},caracter_r{i});
    end
    puntero=find(max(comp)==comp);
    patente=[patente ocr(puntero,1)];
end

set(handles.valor_1, 'String', patente(1,1:2));
set(handles.valor_2, 'String', patente(1,3:4));
set(handles.valor_3, 'String', patente(1,5:6));


