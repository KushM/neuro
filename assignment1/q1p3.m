N = 10;
T = 0.1;
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

for j=2:M
    k1=-100.0*V(:,j-1)-7.0+C(:,1);
    k2=-7.0-100.0*(V(:,j-1)+h*k1)+C(:,1);
    V(:,j)=V(:,j-1)+0.5*h*(k1+k2);
    V(:,j)=(V(:,j)<0.020).*V(:,j) + (V(:,j)>0.020)*(-0.070);
end

t=0:0.001:0.0990;

for o=1:M
    v2(o)=V(2,o);
    v4(o)=V(4,o);
    v6(o)=V(6,o);
    v8(o)=V(8,o);
end

figure, plot(t,v2)
    xlabel('Time (in s)','FontSize',16);
    ylabel('Voltage (in V)','FontSize',16);
    title('Neuron 2');
figure, plot(t,v4)
    xlabel('Time (in s)','FontSize',16);
    ylabel('Voltage (in V)','FontSize',16);
    title('Neuron 4');
figure, plot(t,v6)
    xlabel('Time (in s)','FontSize',16);
    ylabel('Voltage (in V)','FontSize',16);
    title('Neuron 6');
figure, plot(t,v8)
    xlabel('Time (in s)','FontSize',16);
    ylabel('Voltage (in V)','FontSize',16);
    title('Neuron 8');
figure
hold on 
plot(t, v2, 'blue', t, v4, 'red', t, v6, 'green',t, v8, 'black');
title('Neuron 2,4,6,8');
    xlabel('Time (in s)','FontSize',16);
    ylabel('Voltage (in V)','FontSize',16);
