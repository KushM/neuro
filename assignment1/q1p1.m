h=0.004;
v(1)=-0.07;
flag = 0;
for I=1.0:50.0
for n=2:100
k1=-100.0*v(n-1)-7.0+I;
k2=-7.0-100.0*(v(n-1)+h*k1)+I;
v(n)=v(n-1)+0.5*h*(k1+k2);
end
c(I)=v(100);
if((c(I)>=0.020) && flag ==0)
    flag=1;
    Imin = I-1
    Vm = c(I-1)
end
end

