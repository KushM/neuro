function [ V ]= q2p3(type, Iapp, N, T)

    h=0.0001;
    M = T/h;
    C=zeros(N,1);
    kz=zeros(N,1);
    Er=zeros(N,1);
    Et=zeros(N,1);
    a=zeros(N,1);
    b=zeros(N,1);
    c=zeros(N,1);
    d=zeros(N,1);
    Vp=zeros(N,1);
    V= zeros(N,M);
    U=zeros(N,M);

    for ti = 1:N
        if (type==1)
        C(ti) = 100 * (10^(-12));
        kz(ti) = 0.7 * (10^(-6));
        Er(ti) = -0.060;
        Et(ti) = -0.040;
        a(ti) = 30;
        b(ti) = -2 * (10^(-9));
        c(ti) = -0.050;
        d(ti) = 100 * (10^(-12));
        Vp(ti) = 0.035;
        elseif (type==2)
        C(ti) = 150 * (10^(-12));
        kz(ti) = 1.2 * (10^(-6));
        Er(ti) = -0.0750;
        Et(ti) = -0.0450;
        a(ti) = 10;
        b(ti) = 5 * (10^(-9));
        c(ti) = -0.0560;
        d(ti) = 130 * (10^(-12));
        Vp(ti) = 0.05;
        elseif (type==3)
        C(ti) = 50 * (10^(-12));
        kz(ti) = 1.5 * (10^(-6));
        Er(ti) = -0.060;
        Et(ti) = -0.040;
        a(ti) = 30;
        b(ti) = 1 * (10^(-9));
        c(ti) = -0.040;
        d(ti) = 150 * (10^(-12));
        Vp(ti) = 0.025;
        end
    end


    V(:,1) = (b(:,1) + kz(:,1).*Et(:,1))./kz(:,1);
    U(:,1) = b(:,1).*(V(:,1) - Er(:,1));

    for i=2:M
        k1=((kz.*(V(:,i-1)-Er).*(V(:,i-1)-Et))-U(:,i-1)+Iapp)./C;
        l1=a.*(b.*(V(:,i-1)-Er)-U(:,i-1));
        k2=((kz.*(V(:,i-1)+(h/2*k1)-Er).*(V(:,i-1)+(h/2*k1)-Et))-U(:,i-1)-(h/2*l1)+Iapp)./C;
        l2=a.*(b.*(V(:,i-1)+(h/2*k1)-Er)-U(:,i-1)-(h/2*l1));
        k3=((kz.*(V(:,i-1)+(h/2*k2)-Er).*(V(:,i-1)+(h/2*k2)-Et))-U(:,i-1)-(h/2*l2)+Iapp)./C;
        l3=a.*(b.*(V(:,i-1)+(h/2*k2)-Er)-U(:,i-1)-(h/2*l2));
        k4=((kz.*(V(:,i-1)+(h*k3)-Er).*(V(:,i-1)+(h*k3)-Et))-U(:,i-1)-(h*l3)+Iapp)./C;
        l4=a.*(b.*(V(:,i-1)+(h*k3)-Er)-U(:,i-1)-(h*l3));
        
        V(:,i)=V(:,i-1)+(h*(k1+2*k2+2*k3+k4)/6);
        U(:,i)=U(:,i-1)+(h*(l1+2*l2+2*l3+l4)/6);
        
        %V(:,i)=(V(:,i)<0.020).*V(:,i) + (V(:,i)>0.020)*c;
        %U(:,i)=(V(:,i)<0.020).*U(:,i) + (V(:,i)>0.020).*(U(:,i) + d);
            %U(k,j)=U(k,j)+d(k,1);
        %end
        for k=1:N
            if V(k,i)>Vp(k)
                V(k,i)=c(k);
                U(k,i)=U(k,i)+d(k);
            end
        end
        
    end


    for p = 1:N
        figure, plot(V(p,:))
    end
end


