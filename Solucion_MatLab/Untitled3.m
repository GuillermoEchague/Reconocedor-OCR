th=0.5;
U=CLN>0.5;
pixel=10;

for r=1:m-mt
for c=1:n-nt
if(U(r,c))
I1=[r-pixel 1];
I2=[r+pixel m-mt];
I3=[c-pixel 1];
I4=[c+pixel n-nt];

datxi=max(I1);
datxs=min(I2);
datyi=max(I3);
datys=min(I4);

Bloc=CLN(datxi:1:datxs,datyi:1:datys);
MaxB=max(max(Bloc));

if(CLN(r,c)==MaxB)
S(r,c)=1;
end
end
end
end

imshow(Im);

hold on

y=round(mt/2);
x=round(nt/2);


for r=1:m-mt
for c=1:n-nt
if(S(r,c))
resultado(r+y,c+x)=1;
end 
end
end


for r=1:m-mt
for c=1:n-nt
if(Resultado(r,c))
plot(c,r,'+g');
end
end
end