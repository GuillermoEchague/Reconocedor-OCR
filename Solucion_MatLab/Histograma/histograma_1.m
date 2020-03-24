%%Histograma
clear all; clear figure; clc;
filename = uigetfile({'*.jpg;*.png;*.pgm;*.tif;*.bmp','All Image Files';...
    '*.*','All Files'});
% I = imread(filename);
% imhist(I)
% I = gpuArray(imread(filename));
%  [counts,x] = imhist(I);
%  stem(x,counts);
im = imread(filename);
im_1 =rgb2gray(im);%pasar la imagen a escala de grises. 
imD = double(im_1);
[f,c]=size(imD);
 
for i=1:256
    h(i) = 0;
end
 
for i=1:f
       for j=1:c
           k = imD(i,j);
           h(k+1) = h(k+1)+1;
       end
end
plot(h);
j=histeq(im_1); % extender los valores de intensidad

subplot(3,2,1),subimage(im_1),title('Imagen original'); 
subplot(3,2,2),imshow(j),title('Intensidad'); % distribución de intensidades en una imagen
subplot(3,1,2),imhist(im_1),title('Histograma'); % distribución de intensidades en una imagen
subplot(3,1,3),plot(h),title('Histograma'); % distribución de intensidades en una imagen