N = input ('Enter number of neurons : ');
T = input ('Enter total time : ');
M = input ('Enter number of iterations : ');
C = zeros (N,1);
for i=1:N
    C(i,1) = input ('Enter input current for neurons :');
end
for i=1:N
    vectorize(C(i,1));
end

h = T/M;
V = zeros (N,M);
for l=1:N
    V(l,1)=-0.07;
end

for j=2:M
    k1=-100.0*V(:,j-1)-7.0+C(:,1);
    k2=-7.0-100.0*(V(:,j-1)+h*k1)+C(:,1);
    V(:,j)=V(:,j-1)+0.5*h*(k1+k2);
    V(:,j)=(V(:,j)<0.020).*V(:,j) + (V(:,j)>0.020)*(-0.070);
end

V

