Fs = 1000;            % Sampling frequency                    
T = 1/Fs;             % Sampling period       
L = 1500;             % Length of signal
t = (0:L-1)*T;        % Time vector


S = 0.7*sin(2*pi*50*t) + sin(2*pi*120*t);
X = S + 2*randn(size(t));
plot(1000*t(1:50),X(1:50))
title('Signal Corrupted with Zero-Mean Random Noise')
xlabel('t (milliseconds)')
ylabel('X(t)')

X1=t;
%%
Y = fft(X1);
r=real(Y);


% %%
% N=L;
% 

        
% for i1=1:N
%     for j1=1:N
%         sum1=0;
%         sum2=0;
%         
%         for x=1:N
%             for y=0:N
%                 phi=2*pi()*(i*x+j*y)/N;
%                 sum1=sum1+A(x,y)*cos(phi);
%                 sum2=sum1+A(x,y)*sin(phi);
%             end
%         end
%         freal(i,j)=sum1/N;
%         fimag(i,j)=-sum2/N;
%         
%     end
% end

%% Transformada rapida de Fourier FFT

 %                    N
%      X(k) =       sum  x(n)*exp(-j*2*pi*(k-1)*(n-1)/N), 1 <= k <= N.
%                   n=1      
        

N=L;
j=sqrt(-1);
for k = 1:N
 sum1=0;
 sum2=0;

    for n = 1:N
       sum1 = X1(n)*exp(-j*2*pi*(k-1)*(n-1)/N);
       sum2=sum1+sum2; 
    end
    X(k)= sum2;  
end

%%
%   The inverse DFT (computed by IFFT) is given by
%                    N
%      x(n) = (1/N) sum  X(k)*exp( j*2*pi*(k-1)*(n-1)/N), 1 <= n <= N.
%                   k=1
inv=ifft(Y);

%%
N=L;
j=sqrt(-1);
 sum01=0;
 sum02=0;
%for n = 1:N

 n=1;
    for k = 1:N
      sum01= X(k)*exp( j*2*pi*(k-1)*(n-1)/N);
      sum02=sum01+sum02;  
    end
    f(n)=(1/N)*sum02;
%end
%%

P = peaks(20);
X = repmat(P,[5 10]);
imagesc(X)

%%
Y = fft2(X);
imagesc(abs(fftshift(Y)))

%%
[M,N]=size(X);

%%
j=sqrt(-1);
sum1=0;
sum2=0;
x1=0;
y1=0;
 for u=1:M
    for v=1:N
% u=1;
% v=1;
            
        for x=1:M
            for y=1:N
              
                sum1=X(x,y)*exp( -j*2*pi*((u-1)/M+(v-1)/N));
                sum2=sum1+sum2;
               
                
            end
        end
        
        F=1/sqrt(M*N)*sum2
        
   end
end
