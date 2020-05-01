

bw = imread('text.png');
figure
imshow(bw);
%%
a = bw(32:45,88:98);
figure
imshow(a);
%%
C = real(ifft2(fft2(bw) .* fft2(rot90(a,2),256,256))); 
%figure imshow(C,[]) 
%%
figure
imshow(C,[])
% Scale image to appropriate display range.
%%
max(C(:))

%%

thresh = 60; % Use a threshold that's a little less than max. 
D = C > thresh; 
se = strel('disk',5);
%%
E = imdilate(D,se); 
%figure imshow(E) % Display pixels with values over the threshold.

%%
figure
imshow(E)



