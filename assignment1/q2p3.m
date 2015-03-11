N = input ('Enter number of neurons : ');
T = input ('Enter total time : ');
M = input ('Enter number of iterations : ');

InputCurr = 400 * (10^(-12));

h = T/M;
V = zeros (N,M);
U = zeros (N,M);
C = zeros(N,1);
kz = zeros(N,1);
Er = zeros(N,1);
Et = zeros(N,1);
a = zeros(N,1);
b = zeros(N,1);
c = zeros(N,1);
d = zeros(N,1);
Vp = zeros(N,1);

for i=1:N
    prompt = 'Enter neuron type : ';
    str = input (prompt,'s');

    if (str == 'RS')
        C(i,1) = 100 * (10^(-12));
        kz(i,1) = 0.7 * (10^(-6));
        Er(i,1) = -0.060;
        Et(i,1) = -0.040;
        a(i,1) = 30;
        b(i,1) = -2 * (10^(-9));
        c(i,1) = -0.050;
        d(i,1) = 100 * (10^(-12));
        Vp(i,1) = 0.035;
    elseif (str == 'IB')
        C(i,1) = 150 * (10^(-12));
        kz(i,1) = 1.2 * (10^(-6));
        Er(i,1) = -0.0750;
        Et(i,1) = -0.0450;
        a(i,1) = 10;
        b(i,1) = 5 * (10^(-9));
        c(i,1) = -0.0560;
        d(i,1) = 130 * (10^(-12));
        Vp(i,1) = 0.05;
    elseif (str == 'CH')
        C(i,1) = 50 * (10^(-12));
        kz(i,1) = 1.5 * (10^(-6));
        Er(i,1) = -0.060;
        Et(i,1) = -0.040;
        a(i,1) = 30;
        b(i,1) = 1 * (10^(-9));
        c(i,1) = -0.040;
        d(i,1) = 150 * (10^(-12));
        Vp(i,1) = 0.025;
    end

    V(i,1) = (b(i,1) + kz(i,1)*Et(i,1))/kz(i,1);
    U(i,1) = b(i,1)*(V(i,1) - Er(i,1));
    %InputCurr(i,1) = ('Enter input current for neuron : ');
    %Usteadystate = b*(Vsteadystate - Er)
end



for j=2:M
    for k=1:N
        k1 = (kz(k,1)*(V(k,j-1)-Er(k,1))*(V(k,j-1)-Et(k,1))- U(k,j-1) + InputCurr)/C(k,1);
        l1 = a(k,1)*(b(k,1)*(V(k,j-1)-Er(k,1))-U(k,j-1));
        k2 = (kz(k,1)*((V(k,j-1)+(h*k1)/2)-Er(k,1))*((V(k,j-1)+(h*k1)/2)-Et(k,1))- (U(k,j-1)+(h*l1)/2) + InputCurr)/C(k,1);
        l2 = a(k,1)*(b(k,1)*((V(k,j-1)+(h*k1)/2)-Er(k,1))-(U(k,j-1)+(h*l1)/2));
        k3 = (kz(k,1)*((V(k,j-1)+(h*k2)/2)-Er(k,1))*((V(k,j-1)+(h*k2)/2)-Et(k,1))- (U(k,j-1)+(h*l2)/2) + InputCurr)/C(k,1);
        l3 = a(k,1)*(b(k,1)*((V(k,j-1)+(h*k2)/2)-Er(k,1))-(U(k,j-1)+(h*l2)/2));
        k4 = (kz(k,1)*((V(k,j-1)+(h*k3))-Er(k,1))*((V(k,j-1)+(h*k3)/2)-Et(k,1))- (U(k,j-1)+(h*l3)) + InputCurr)/C(k,1);
        l4 = a(k,1)*(b(k,1)*((V(k,j-1)+(h*k3))-Er(k,1))-(U(k,j-1)+(h*l3)));
        V(k,j) = V(k,j-1) + h*(k1 + 2*k2 + 2*k3 + k4)/6;
        U(k,j) = U(k,j-1) + h*(l1 + 2*l2 + 2*l3 + l4)/6;
        if (V(k,j)>Vp(k,1))
            V(k,j)=c(k,1);
            U(k,j)=U(k,j)+d(k,1);
        end
    end
end

for o=1:M
    v1(o)=V(1,o);
    %v2(o)=V(2,o);
    %v3(o)=V(3,o);
end

t=0:h:(M-1)*h;
figure
hold on 
plot(t, v1, 'blue')
%;, t, v2, 'red', t, v3, 'green')






        
        
        
        