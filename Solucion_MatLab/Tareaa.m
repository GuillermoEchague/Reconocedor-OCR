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
hold on
figure 
imshow(I)
%%
umb=graythresh(I); 

hold on
figure 
imshow(umb)
%%
bw=(im2bw(I,umb));
hold on
figure 
imshow(bw)
%%
bw=medfilt2(bw, [8, 8], 'symmetric');
bw;
hold on
figure 
imshow(bw)
%%
L=bwlabel(bw,8);
hold on
imshow(L)
%%
idx=max(max(L));
%for o=1:idx
%    O=L==o;
%    H=regionprops(double(O),'centroid');
%    pt(o,1)=H.Centroid(1);
%    pt(o,2)=H.Centroid(2);
%end
%%
for o=1:idx
    O=L==o;
    H=regionprops(double(O),'BoundingBox');
    pt(o,1)=round(H.BoundingBox(1));
    pt(o,2)=round(H.BoundingBox(2));
    pt(o,3)=round(H.BoundingBox(3));
    pt(o,4)=round(H.BoundingBox(4));
end

%%
Im=bw;
%Im=double(Im);
%imshow(Im)
%hold on
%for d=1:idx;
%    plot(pt(d,1),pt(d,2),'+k');
%end

%%
for o=1:idx
    Im(pt(o,2):1:pt(o,2)+pt(o,4),pt(o,1))=1;
     Im(pt(o,2):1:pt(o,2)+pt(o,4),pt(o,1)+pt(o,3))=1;
     Im(pt(o,2),pt(o,1):1:pt(o,1)+pt(o,3))=1;
     Im(pt(o,2)+pt(o,4),pt(o,1):1:pt(o,1)+pt(o,3))=1;
end
%% Graficar las 'cajas' de frontera de los objetos 

stats = regionprops('table',bw,'Centroid',...     
    'MajorAxisLength','MinorAxisLength')
%%
imshow(Im)