N = input ('Enter number of neurons : ');
T = input ('Enter total time : ');
M = input ('Enter number of iterations : ');

h=T/M;

I = 350 * (10^(-12));

h = T/M;
V = zeros (N,M);
U = zeros (N,M);
C = zeros(N,1);
gl = zeros(N,1);
El = zeros(N,1);
Vt = zeros(N,1);
dt = zeros(N,1);
a = zeros(N,1);
tw = zeros(N,1);
b = zeros(N,1);
Vr = zeros(N,1);

for i=1:N
    prompt = 'Enter neuron type : ';
    str = input (prompt,'s');
    
    if (str == 'RS')
        C(i,1) = 200 * (10^(-12));
        gl(i,1) = 10 * (10^(-9));
        El(i,1) = -0.07;
        Vt(i,1) = -0.05;
        dt(i,1) = 0.002;
        a(i,1) = 2 * (10^(-9));
        tw(i,1) = 0.030;
        b(i,1) = 0;
        Vr(i,1) = -0.058;
    elseif (str == 'IB')
        C(i,1) = 130 * (10^(-12));
        gl(i,1) = 18 * (10^(-9));
        El(i,1) = -0.058;
        Vt(i,1) = -0.05;
        dt(i,1) = 0.002;
        a(i,1) = 4 * (10^(-9));
        tw(i,1) = 0.0150;
        b(i,1) = 120 * (10^(-12));
        Vr(i,1) = -0.050;
    elseif (str == 'CH')
        C(i,1) = 200 * (10^(-12));
        gl(i,1) = 10 * (10^(-9));
        El(i,1) = -0.058;
        Vt(i,1) = -0.05;
        dt(i,1) = 0.002;
        a(i,1) = 2 * (10^(-9));
        tw(i,1) = 0.0120;
        b(i,1) = 100 * (10^(-12));
        Vr(i,1) = -0.046;
    end
    syms v;
    vnum = vpasolve((gl(i,1)*dt(i,1)*(exp((v-Vt(i,1))/dt(i,1))))==((a(i,1)+gl(i,1))*(v-El(i,1))),v);

    V(i,1) = vnum;
    U(i,1) = a(i,1)*(vnum-El(i,1));

end

for j=2:M
    for k=1:N
        k1=(-(gl(k,1)*(V(k,j-1)-El(k,1))) + (gl(k,1)*dt(k,1)*(exp((V(k,j-1)-Vt(k,1))/dt(k,1)))) - U(k,j-1) + I)/C(k,1);
        l1=(a(k,1)*(V(k,j-1)-El(k,1)) - U(k,j-1))/tw(k,1);
        V(k,j) = V(k,j-1) + h*k1;
        U(k,j) = U(k,j-1) + h*l1;
        if (V(k,j) > 0)
            V(k,j)=Vr(k,1);
            U(k,j)=U(k,j)+b(k,1);
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
%figure, plot (t, v2, 'red')
%figure, plot(t, v3, 'green')

            


