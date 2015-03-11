function [V, spiketime] = lif_func(Iapp,T,h,Rp)

%T = 15;
%h = 0.001;
V = zeros(1,T/h);
t = 0:h:T-h;
Ia = 50*10e-9;
Rp = Rp/h;
%Iapp1 = zeros(1,T/h);
%Iapp1 = Ia*((heaviside(t) - heaviside(t-1)) + (heaviside(t-4) - heaviside(t-5)) + (heaviside(t-8) - heaviside(t-9)));
%Iapp = Iapp1;

Gl = 30*10^-9;
Vt = 20*10^-3;
El = -70*10^-3;
C = 300*10^-12;
V(1) = -0.069;
%Rp = 2000;
count1 = 0;
count2 = 1;
spiketime = [];
for j=2:T/h
    if ((V(j-1) == El) && count1 < Rp)
        V(j) = El;
        count1 = count1+1;
        continue;
    end
    k1 = (1/C)*(-Gl * (V(j-1) - El) + Iapp(j-1));
    k2 = (-Gl * ((V(j-1)+h*k1) - El) + Iapp(j))*(1/C);
    V(j) = V(j-1) + 0.5*h*(k1+k2);
    if (V(j) > Vt)
        spiketime(count2) = j;
        count2 = count2 + 1;
        V(j) = El;
    end
    if ((V(j-1) == El) && count1 == Rp)
        count1 = 0;
    end
end

figure, plot(Iapp);
figure, plot(V);
end
