prompt = 'Enter neuron type : '
str = input (prompt,'s');

if (str == 'RS')
    C = 100 * (10^(-12));
    kz = 0.7 * (10^(-6));
    Er = -0.06;
    Et = -0.04;
    a = 30;
    b = -2 * (10^(-9));
    c = -0.05;
    d = 100 * (10^(-12));
    Vp = 0.035;
elseif (str == 'IB')
    C = 150 * (10^(-12));
    kz = 1.2 * (10^(-6));
    Er = -0.075;
    Et = -0.045;
    a = 10;
    b = 5 * (10^(-9));
    c = -0.056;
    d = 130 * (10^(-12));
    Vp = 0.05;
elseif (str == 'CH')
    C = 50 * (10^(-12));
    kz = 1.5 * (10^(-6));
    Er = -0.06;
    Et = -0.04;
    a = 30;
    b = 1 * (10^(-9));
    c = -0.04;
    d = 150 * (10^(-12));
    Vp = 0.025;
end

Vsteadystate = (b + kz*Et)/kz
Usteadystate = b*(Vsteadystate - Er)


