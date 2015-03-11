prompt = 'Enter neuron type : ';
str = input (prompt,'s');

if (str == 'RS')
    C = 200 * (10^(-12));
    gl = 10 * (10^(-9));
    El = -0.07;
    Vt = -0.05;
    dt = 0.002;
    a = 2 * (10^(-9));
    tw = 0.030;
    b = 0;
    Vr = -0.058;
elseif (str == 'IB')
    C = 130 * (10^(-12));
    gl = 18 * (10^(-9));
    El = -0.058;
    Vt = -0.05;
    dt = 0.002;
    a = 4 * (10^(-9));
    tw = 0.0150;
    b = 120 * (10^(-12));
    Vr = -0.050;
elseif (str == 'CH')
    C = 200 * (10^(-12));
    gl = 10 * (10^(-9));
    El = -0.058;
    Vt = -0.05;
    dt = 0.002;
    a = 2 * (10^(-9));
    tw = 0.0120;
    b = 100 * (10^(-12));
    Vr = -0.046;
end

syms v;
vnum = vpasolve((gl*dt*(exp((v-Vt)/dt)))==((a+gl)*(v-El)),v);

Vsteadystate = vnum
Usteadystate = a*(vnum-El)


