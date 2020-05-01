% Programa para etiquetar los objetos contenidos en una imagen binaria, 
% considerando la vecindad de 4 vecinos
tic;
% se limpia la pantalla y se borra la memoria utilizada hasta el momento
clear all, close all, clc;
% %% Se carga el path de la imagen *.png que se va a analizar
%filename = uigetfile('*.png','Select an image file');
filename1 = 'Training_02.png';
Im = imread(filename1);
%Im =imresize(Im,[210 336]);
Ib=rgb2gray(Im);

% Se obtienen las dimensiones de la imagen binaria donde 0 es el fondo y 1  
% los objetos
[m,n] = size(Ib);
% La imagen binaria se convierte a double, para que pueda 
% contener valores mayores a 1
Ibd=double(Ib);
% %%
%figure
%imshow(Ibd);
% %%

% Paso 1. Se asignan etiquetas iniciales 
% Se inicializan las variables para las etiquetas e
% y para las colisiones k
% Se inicializa e=2, como la proxima etiqueta a asignar
e=2;
k=1;
 

% Se recorre la imagen de izquierda a derecha y de arriba a abajo
for r=2:m-1
    for c=2:n-1
        % Si los pixeles vecinos son ceros se asigna etiqueta
        % y se incrementa el numero de etiquetas
        if(Ibd(r,c)==1)
            if((Ibd(r,c-1)==0)&&(Ibd(r-1,c)==0))
                Ibd(r,c)=e;
                e=e+1;
            end
 % Si uno de los pixeles vecinos tiene una etiqueta
 % esta etiqueta se le asigna al valor actual
        if(((Ibd(r,c-1)>1)&&(Ibd(r-1,c)<2))...
                ||((Ibd(r,c-1)<2)&&(Ibd(r-1,c)>1)))
           
            if(Ibd(r,c-1)>1)
                Ibd(r,c)=Ibd(r,c-1);
            end
            
            if(Ibd(r-1,c)>1)
                Ibd(r,c)=Ibd(r-1,c);
            end
        end
  % Si varios de los pixeles vecinos tienen una etiqueta asignada se le
  % asigna una de ellas a este pixel.
  %
            if((Ibd(r,c-1)>1)&&(Ibd(r-1,c)>1))
                Ibd(r,c)=Ibd(r-1,c);
  % Las etiquetas no usadas son colisiones 
                if((Ibd(r,c-1))~=(Ibd(r-1,c)))
                ec1(k)=Ibd(r-1,c);
                ec2(k)=Ibd(r,c-1);
                k=k+1;
                end
            end
        end
     end
end

% Paso2. Se resuelven colisiones 
for ind=1:k-1
   
    % Se detecta la etiqueta mas pequeña en la colision
    % El grupo pixeles pertenecientes a la etiqueta menor absorven a los de
    % la etiqueta mayor
    %
    if(ec1(ind)<=ec2(ind))
        for r=1:m
            for c=1:n
                if(Ibd(r,c)==ec2(ind))
                    Ibd(r,c)=ec1(ind);
                end
            end
        end
    end
    if(ec1(ind)>ec2(ind))
        for r=1:m
            for c= 1:n
            if(Ibd(r,c)==ec1(ind))
                Ibd(r,c)=ec2(ind);
            end
            end
        end
    end
    
end

% La funcion unique entrega los valores de la matriz (Ibd), unicos, es decir    
% que no se repiten, por lo que seran entregados solamente aquellos valores
% que permanecieron al resolver el problema de las colisiones 
%
w=unique(Ibd);
t=length(w);

% %% Paso 3. Re-etiquetado de la imagen
% Se re-etiquetan los pixeles con los valores minimos
for r=1:m
    for c=1:n
        for ix=2:t
            if(Ibd(r,c)==w(ix))
                Ibd(r,c)=ix-1;
            end
        end
        
    end
end
% %% Se preparan los datos para despliegue
figure
imshow(Ibd);
toc;