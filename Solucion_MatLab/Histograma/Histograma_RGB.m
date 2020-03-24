%% Generar Histograma RGB
filename = uigetfile({'*.jpg;*.png;*.pgm;*.tif;*.bmp','All Image Files';...
    '*.*','All Files'});
RGB = imread(filename);
rgbhist(RGB);
% imwrite(Iout, 'nombre_4.jpg', 'quality', 100) ;