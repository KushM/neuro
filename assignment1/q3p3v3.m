function [ V ] = q3p3v3( type,T,Iapp,N)

    h=0.0001;
    M=T/h;
    V=zeros(N,M);
    U=zeros(N,M);
    I=Iapp*ones(N,1);
    
    C=zeros(N,1);
    gl=zeros(N,1);
    El=zeros(N,1);
    Vt=zeros(N,1);
    dt=zeros(N,1);
    a=zeros(N,1);
    tw=zeros(N,1);
    b=zeros(N,1);
    Vr=zeros(N,1);
    
    for ti=1:N
        if (type(ti)==1)
            C(ti)=200*10^-12;
            gl(ti)=10*10^-9;
            El(ti)=-70*10^-3;
            Vt(ti)=-50*10^-3;
            dt(ti)=2*10^-3;
            a(ti)=2*10^-9;
            tw(ti)=30*10^-3;
            b(ti)=0;
            Vr(ti)=-58*10^-3;
        elseif (type(ti)==2)
            C(ti)=130*10^-12;
            gl(ti)=18*10^-9;
            El(ti)=-58*10^-3;
            Vt(ti)=-50*10^-3;
            dt(ti)=2*10^-3;
            a(ti)=4*10^-9;
            tw(ti)=150*10^-3;
            b(ti)=120*10^-12;
            Vr(ti)=-50*10^-3;
        else
            C(ti)=200*10^-12;
            gl(ti)=10*10^-9;
            El(ti)=-58*10^-3;
            Vt(ti)=-50*10^-3;
            dt(ti)=2*10^-3;
            a(ti)=2*10^-9;
            tw(ti)=120*10^-3;
            b(ti)=100*10^-12;
            Vr(ti)=-46*10^-3;
        end
    end
    
    V(:,1)=Vr;
    U(:,1)=U(:,1)+b;
    
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
figure, plot(V)   
end

