    C=1;
    Ena=50;
    Ek=-77;
    El=-55;
    gna=120;
    gk=36;
    gl=0.3;

    Io=15;
    h=0.01;
    T=30;

    M=150/h;

    I=zeros(1,M);

    for i=1:M
        I(i)=Io*(heaviside(i*h-2*T)-heaviside(i*h-3*T)); 
    end

    syms v;
    an=0.01*(v+0.055)/(1-exp((-v-0.055)/0.010));
    bn=0.125*exp((-v-0.065)/0.080);
    am=0.1*(v+0.040)/(1-exp((-v-0.040)/0.010));
    bm=4*exp((-v-0.065)*0.0556);
    bh=1/(1+exp((-0.1)*(v+0.035)));
    ah=0.07*exp((-v-0.065)*0.05);
    vnum = vpasolve ((gna*((am/(am+bm))^3)*(ah/(ah+bh))*(v - Ena))+(gk*((an/(an+bn))^4)*(v-Ek))+(gl*(v-El))==0);
    an=0.01*(vnum+0.055)/(1-exp((-vnum-0.055)/0.010));
    bn=0.125*exp((-vnum-0.065)/0.080);
    am=0.1*(vnum+0.040)/(1-exp((-vnum-0.040)/0.010));
    
    bm=4*exp((-vnum-0.065)*0.0556);
    bh=1/(1+exp((-0.1)*(vnum+0.035)));
    ah=0.07*exp((-vnum-0.065)*0.05);
    n0=an/(an+bn);
    m0=am/(am+bm);
    h0=ah/(ah+bh);

    
    V=zeros(1,M);
    V(1)=0;
    m=zeros(1,M);
    m(1)=0;
    hp=zeros(1,M);
    hp(1)=0;
    n=zeros(1,M);
    n(1)=0;
    
    for i=2:M    
        k1=-(1)*(gna*(m(i-1)^3)*hp(i-1)*(V(i-1)-Ena))-(1)*(gk*(n(i-1)^4)*(V(i-1)-Ek))-1*(gl*(V(i-1)-El))+I(i-1);
        k1=k1/C;
        k2=((0.01*(V(i-1)+55))/(1-exp(-1*((V(i-1)+55)/10)))*(1-n(i-1)))-(0.125*exp(-1*(V(i-1)+65)/80))*n(i-1);
        k3=((0.1*(V(i-1)+40))/(1-exp(-1*((V(i-1)+40)/10)))*(1-m(i-1)))-(4*exp(-0.0556*(V(i-1)+65)))*m(i-1);
        k4=(0.07*exp(-0.05*(V(i-1)+65)))*(1-hp(i-1))-hp(i-1)/(1+exp(-0.1*(V(i-1)+35)));
        
        V(i)=V(i-1)+h*k1;
        m(i)=m(i-1)+h*k3;
        n(i)=n(i-1)+h*k2;
        hp(i)=hp(i-1)+h*k4;    
    end
    figure, plot(V);
    figure, plot(m);
    figure, plot(n);
    figure, plot(hp);
    