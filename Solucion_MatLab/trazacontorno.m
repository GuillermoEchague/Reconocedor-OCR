%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Funcion utilizada para recorrer y describir el contorno ya sea 
% exterior o interior de un objeto. La funcion es llamada por el 
% programa que implementa el algoritmo de combinacion de identificacion de
% contornos y etiquetad de objetos en MatLab
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function M=trazacontorno(ps,d,L)
% Se definen como globales la imagen binaria y la matriz de etiquetas, de
% tal manera que ambas matrices son accesibles y modificables tanto en esta 
% funcion como proximoNodo. 

%ps: Posicion original
%d: Direccion de busqueda
%ME: Mapa de etiquetas
%L: Etiqueta del contorno

global Ib;
global ME;
% Se encuentra el tamaño de la imagen binaria
[m1,n1]=size(Ib);
% Se define en ceros la matriz utilizada para describir el contorno
% encontrado
M=zeros(m1,n1);
% Se llama a la funcion ProximoNodo, que localiza el pixel siguiente en el
% recorrido del contorno
[p,d]=proximonodo(ps,d);
% El punto devuelto por ProximoNodo es puesto en 1 en la matriz M por ser
% parte del contorno
M(p(1),p(2))=1;
% Se define el punto actual xc y el punto previo xp
%xp=ps;
xc=p;
% Si ambos puntos son iguales, se trata de un pixel aislado 
f=(ps==p);
% Se recorre todo el contorno hasta que el punto actual sea igual al
% previo, lo que significa que el contorno ha sido recorrido completamente
while(~(f(1)&&f(2)))
    ME(xc(1),xc(2))=L;
    [pn,d]=proximonodo(xc,(mod(d+6,8)));
    xp=xc;
    xc=pn;
  
    f=((xp==ps)&(xc==p));
    if(~(f(1)&&f(2)))
        M(pn(1),pn(2))=1;
    end
end
