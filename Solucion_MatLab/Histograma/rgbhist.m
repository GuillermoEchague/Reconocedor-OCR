% Función que permite graficar los histogramas de
% los diferente planos R, G y B de forma concatenada
%%
function varargout = rgbhist(I)
% Se verifica que la imagen I sea RGB
% esto es que tenga 3 planos
if (size(I,3) ~= 3)
    error ('La imagen debe ser RGB')
end
%%
% Se establecen 256 valores que representan
% la profundidad del tipo de dato permisible
nBins = 256;
% Se encuentran los histogramas para cada plano R G B
rHist = imhist(I(:,:,1),nBins);
gHist = imhist(I(:,:,2),nBins);
bHist = imhist(I(:,:,3),nBins);
%%
% Se crea el objeto gráfico
figure
hold on
%%
% Se despliega la información de los histogramas
h(1) = stem(1:256, rHist);
h(2) = stem(1:256 + 1/3, gHist);
h(3) = stem(1:256 + 2/3, bHist);
%%
% Se establece un color para cada uno de ellos
% que correspondan al valor que representan
set(h(1), 'color', [1 0 0])
set(h(2), 'color', [0 1 0])
set(h(3), 'color', [0 0 1])