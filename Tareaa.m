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
% Scale data and display as image%
% Escala de informacion y desplego como imagen 
%%
imagesc(im);
I=rgb2gray(im);
%hold on
%figure 
%imshow(I);title('imagen 1');


%% Normalizar Contraste
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


%% Binarización 
umb=graythresh(im_g); 
bw=(im2bw(im_g,umb));
%hold on
%figure 
%imshow(bw);title('imagen 3');

%%
L=bwlabel(bw,8);
%hold on
%figure
%imshow(L);title('imagen equalizada 4');
%%
%figure
%imshow(bw);title('imagen original');


%%
BW4 = bwmorph(bw,'bridge');
BW5 = bwmorph(BW4,'clean');

%%
idx=max(max(L));
for o=1:idx
    O=L==o;
    H=regionprops(double(O),'BoundingBox');
    pt(o,1)=round(H.BoundingBox(1));
    pt(o,2)=round(H.BoundingBox(2));
    pt(o,3)=round(H.BoundingBox(3));
    pt(o,4)=round(H.BoundingBox(4));
end

%%
for o=1:idx
    Im(pt(o,2):1:pt(o,2)+pt(o,4),pt(o,1))=1;
     Im(pt(o,2):1:pt(o,2)+pt(o,4),pt(o,1)+pt(o,3))=1;
     Im(pt(o,2),pt(o,1):1:pt(o,1)+pt(o,3))=1;
     Im(pt(o,2)+pt(o,4),pt(o,1):1:pt(o,1)+pt(o,3))=1;
end
%% Graficar las 'cajas' de frontera de los objetos 
% Dibujar los BoundingBox en la imagen
st = regionprops(bw, 'BoundingBox' );
for k = 1 : length(st)
  thisBB = st(k).BoundingBox;
  rectangle('Position', [thisBB(1),thisBB(2),thisBB(3),thisBB(4)],...
  'EdgeColor','r','LineWidth',2 )
end
%%
%imshow(Im)