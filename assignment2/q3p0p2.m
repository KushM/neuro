
for i = 1:Ns
    tk = find(event(i,:)==1);
    [tkr,tkc] = size(tk);
    if (tkc>0)
        for j = 1:N
            for k = 1:tkc
                if(tk(k)<j)
                    Iapp(i,j) = Iapp(i,j) + (exp((tk(k)-j)*deltat/tc_m) - exp((tk(k)-j)*deltat/tc_s));
                end
            end
        end
    end
end

we(39) = 750;

for i = 1:Ns
    Iapp(i,:) = Iapp(i,:)*we(i)*Io;
end

Iappf = sum(Iapp);

%Iappf = reshape(Iappf,5000,1);
figure, plot(time, Iappf);
k = 0;
for i = 1:N
    if(Iappf(i)>0 && k==0)
        k=i;
    end
end

[V,nspikes] = q1p2_func(1,0.5,Iappf,1);
V = reshape(V,N,1);
V(1:k) = -0.07;

nspikes
figure, plot(time,V);
