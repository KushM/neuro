function[Iappf,we] = func_remove(event,Iappf,Japp,we,Iapp)

Ns = 100;
deltat = 0.1;
tc_m = 15;
tc_s = tc_m/4;
Io = 10^(-12);
count = 0;
while (1)
    [V, nspikes] = q1p2_func(1,0.5,Iappf,1);
    if (nspikes == 0)
        break;
    end
    
    spiketimes = find(V == -0.058);
    [spr,spc] = size(spiketimes);
    count = count+1;
    for i = 1:spc
        pos_max = spiketimes(spc);
        for i=1:Ns
            tk = find(event(i,:)==1); 
            tk = tk(tk<pos_max);                
            [tkr,tkc] = size(tk);
            if (tkc>0)
                deltatk = (pos_max-tk(tkc))*deltat;
                we(i)=max(10, we(i)*(1 - (exp(-deltatk/tc_m) - exp(-deltatk/tc_s))));
            end
        end
    end    
    for i = 1:Ns
        Iapp(i,:) = Japp(i,:)*we(i)*Io;
    end
    Iappf = sum(Iapp);
end

end