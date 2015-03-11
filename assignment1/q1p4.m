N = 10;
T = 0.04;
M = 100;
Ic = 9.01;
C = zeros (N,1);
for i=1:N
    C(i,1) = (1 + i*0.1)*Ic; 
end
for i=1:N
    vectorize(C(i,1));
end

h = T/M;
V = zeros (N,M);
for l=1:N
    V(l,1)=-0.07;
end
T = zeros (N,1);
for j=2:M
    for k=1:N
            k1=-100.0*V(k,j-1)-7.0+C(k,1);
            k2=-7.0-100.0*(V(k,j-1)+h*k1)+C(k,1);
            V(k,j)=V(k,j-1)+0.5*h*(k1+k2);
            if (V(k,j)>0.020)
                V(k,j)=-0.07;
                if (T(k,1)==0)
                    T(k,1)=(j+1)*h;
                end
            end
    end
end

figure, plot (T,C)
    xlabel('Time interval(in s)','FontSize',16);
    ylabel('Applied current','FontSize',16);


