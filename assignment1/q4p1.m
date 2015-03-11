%function [] = question4(T,M)
T = 
syms v;
an=0.01*(v+0.055)/(1-exp((-v-0.055)/0.010));
bn=0.125*exp((-v-0.065)/0.080);
am=0.1*(v+0.040)/(1-exp((-v-0.040)/0.010));
bm=4*exp((-v-0.065)*0.0556);
bh=1/(1+exp((-0.1)*(v+0.035)));
ah=0.07*exp((-v-0.065)*0.05);
gna= 1200;
gk= 360;
gl= 3;
Ena= 0.050;
Ek= -0.077;
El= -0.055;
vnum = vpasolve ((gna*((am/(am+bm))^3)*(ah/(ah+bh))*(v - Ena))+(gk*((an/(an+bn))^4)*(v-Ek))+(gl*(v-El))==0)
an=0.01*(vnum+55)/(1-exp((-vnum-0.055)/0.010));
bn=0.125*exp((-vnum-0.065)/0.080);
am=0.1*(vnum+0.040)/(1-exp((-vnum-0.040)/0.010));
bm=4*exp((-vnum-0.065)*0.0556);
bh=1/(1+exp((-0.1)*(vnum+0.035)));
ah=0.07*exp((-vnum-0.065)*0.05);
n0=an/(an+bn);
m0=am/(am+bm);
h0=ah/(ah+bh);
h=T/M;
nt = zeros(1,M);
mt = zeros(1,M);
ht = zeros(1,M);
nt(1,1)=n0;
mt(1,1)=m0;
ht(1,1)=h0;

Iext = zeros(1,M);
for i = 1:h:M
    if(i*M>=0.020 && i*M<=0.30)
        Iext(i)=0.15;
    end
end


%for i=2:M
    %nt(1,i)=nt(1,i-1)+(