function [ V ]= q3p3(type, Iapp, N, T)

    h=0.0001;
    M = T/h;
    I = Iapp * ones(N,1);
    C=zeros(N,1);
    gl=zeros(N,1);
    El=zeros(N,1);
    Vt=zeros(N,1);
    dt=zeros(N,1);
    a=zeros(N,1);
    tw=zeros(N,1);
    b=zeros(N,1);
    Vr=zeros(N,1);
    V= zeros(N,M);
    U=zeros(N,M);

    for ti = 1:N
        if (type==1)
        C(ti) = 200 * (10^(-12));
        gl(ti) = 10 * (10^(-9));
        El(ti) = -0.07;
        Vt(ti) = -0.05;
        dt(ti) = 0.002;
        a(ti) = 2 * (10^(-9));
        tw(ti) = 0.030;
        b(ti) = 0*10^(-12);
        Vr(ti) = -0.058;
        elseif (type==2)
        C(ti) = 130 * (10^(-12));
        gl(ti) = 18 * (10^(-9));
        El(ti) = -0.058;
        Vt(ti) = -0.05;
        dt(ti) = 0.002;
        a(ti) = 4 * (10^(-9));
        tw(ti) = 0.0150;
        b(ti) = 120 * (10^(-12));
        Vr(ti) = -0.050;
        elseif (type==3)
        C(ti) = 200 * (10^(-12));
        gl(ti) = 10 * (10^(-9));
        El(ti) = -0.058;
        Vt(ti) = -0.05;
        dt(ti) = 0.002;
        a(ti) = 2 * (10^(-9));
        tw(ti) = 0.0120;
        b(ti) = 100 * (10^(-12));
        Vr(ti) = -0.046;
        end
    end

    
%syms v;
%vnum = vpasolve((gl*dt*(exp((v-Vt)/dt)))==((a+gl)*(v-El)),v);

        V(:,1) = Vr;
        U(:,1) = U(:,1)+b;  


    for i=2:M
        k=(-1.*gl.*(V(:,i-1)-El)+gl.*dt.*exp((V(:,i-1)-Vt)./dt)-U(:,i-1)+I)./C;
        l=(a.*(V(:,i-1)-El)-U(:,i-1))./tw;
                
        V(:,i)=V(:,i-1)+(h*k);
        U(:,i)=U(:,i-1)+(h*l);
        
        for j=1:N
            if V(j,i)>0
                V(j,i)=Vr(j);
                U(j,i)=U(j,i)+b(j);
            end
        end
                
    end
figure, plot(V);
end
