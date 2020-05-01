%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Programa que implementa el algoritmo de combinacion de identificacion de
% contornos y etiquetado de objetos usando vecindad de 8-vecinos
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 clear all,
 close all, 
 clc;
% %% Se carga el path de la imagen *.png que se va a analizar
% filename = uigetfile('*.png','Select an image file');
% im = imread(filename);
im1=(imread('Testing.png')); 
im2=double(imread('Testing.png'));
im3=double(im2);
%imshow(im);
% Muestra La Imagen de entrada
%% imshow(im);
% %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Se definen como globales la imagen binaria y la matriz de etiquetas, de
% tal manera que ambas matrices son accesibles y modificables tanto en este
% programa como en las funciones TrazaContorno y ProximoNodo.
global Ib;
global ME;


% Se obtienen las dimensiones de la imagen binaria donde 0 es el fondo y 1  
% los objetos
Ib=im3;
%
% %%

% Se encuentra el tama�o de la imagen binaria
[m,n]=size(Ib);

% Se considera la matriz de etiquetas con una dimension menor a la original
ME=zeros(m-1,n-1);
% Se coloca el contador de contornos en su valor inicial
cont=1;
% El contador de objetos es colocado a cero
R=0;
% Se inicializa una imagen en ceros que contendra los contornos de los
% ojetos
C=zeros(m,n);

%  %% Se recorre la imagen de izquierda a derecha y de arriba a abajo
  tic;
for r=2:m-1
    % Se inicializa la etiqueta en cero, que corresponde la no definicion
    % de etiqueta para un pixel
    
    Lc=0;
    for c=2:n-1
    % Si el pixel 1        
        if(Ib(r,c)==1)
     % Si la etiqueta es la misma se utiliza para etiquetar los pixeles vecinos       
            if(Lc~=0)
                ME(r,c)=Lc;
            else
                Lc=ME(r,c);
% Si no existe etiqueta, entonces se trata de un contorno exterior, por lo que se llama a la
% funcion trazacontorno para su recorrido
                if(Lc==0)
            % Se define un nuevo objeto        
                    R=R+1;
            % La etiqueta se reasigna al numero de objetos        
                    Lc=R;
            % Se define el punto de inicio del contorno        
                    ps=[r,c];
             % Llama a la funcion trazacontorno para su recorrido        
                    D=trazacontorno(ps,0,Lc);
                    %D=im2bw(D);
                    D=imbinarize(D);
% Los contornos son almacenados en el arreglo Co indexados por cont                    
                    Co(:,:,cont)=D;
% Todos los contornos son almacenados para despliegue en C                    
                    C=D|C;
                    cont=cont+1;
                    ME(r,c)=Lc;
                end
            end
            else
                if(Lc~=0)
% Si ya existe etiqueta, entonces se trata de un contorno interior, por lo 
% que se llama a la funcion trazacontorno para su recorrido
                if(ME(r,c)==0)
         % Se define el punto de inicio del contorno           
                    ps=[r,c-1];
         % Llama a la funcion trazacontorno para su recorrido          
                    D=trazacontorno(ps,1,Lc);
                    %D=im2bw(D);
                     D=imbinarize(D);
% Los contornos son almacenados en el arreglo Co indexados por cont                    
                    Co(:,:,cont)=D;
                    C=D|C;
                    cont=cont+1;
                end
% Se asigna a Lc la no definicion de etiqueta para un pixel                
                Lc=0;
                end
        end
    end
end

% %%Se reconvierte la matriz de etiquetas para eliminar los valores de -1 
% Asignados en la funcion proximonodo
[m1,n1]=size(ME);
for r=1:m1
    for c=1:n1
        if(ME(r,c)<0)
            ME(r,c)=0;
        end
    end
end

toc;