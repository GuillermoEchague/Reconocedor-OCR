%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Funcion utilizada para encontrar el siguiente punto del contorno ya sea 
% exterior o interior de un objeto. La llamada a la funcion es realizada  
% por TrazaContorno
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [p,dir]= proximonodo(ps,d1)
% Se definen como globales la imagen binaria y la matriz de etiquetas, de
% tal manera que ambas matrices son accesibles y modificables tanto en esta 
% funcion como TrazaContorno.  

%ps: Posicion original
%d1: Direccion de busqueda
%ME: Mapa de etiquetas

global Ib;
global ME;
flag=0;
d=d1;
% Se define la direccion de busqueda del siguiente pixel
for j=0:1:6
    % x' <- xc+Delta(d)
    if(d==0)
        p(1)=ps(1)+1;
        p(2)=ps(2);
    end
    if(d==1)
        p(1)=ps(1)+1;
        p(2)=ps(2)+1;
        
    end
    if(d==2)
        p(1)=ps(1);
        p(2)=ps(2)+1;
        
    end
    if(d==3)
        p(1)=ps(1)-1;
        p(2)=ps(2)+1;
        
    end
    if(d==4)
        p(1)=ps(1)-1;
        p(2)=ps(2);
        
    end
    if(d==5)
        p(1)=ps(1)-1;
        p(2)=ps(2)-1;
        
    end
    if(d==6)
        p(1)=ps(1);
        p(2)=ps(2)-1;
        
    end
    if(d==7)
        p(1)=ps(1)+1;
        p(2)=ps(2)-1;
        
    end
    % Si el pixel encontrado es parte del fondo se marca con -1 para evitar
    % volverlo a visitar
    
    if (p(1)<ps(1)|| p(2)<ps(2))
        
    if(Ib(p(1),p(2))==0)
        ME(p(1),p(2))=-1;
        d=mod(d+1,8);
    else
        flag=1;
        break
    end
    
   end
end
dir=d;
if (flag==0)
    p(1)=ps(1);
    p(2)=ps(2);
    dir=d1;
end
