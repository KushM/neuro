clear
clc

N = 500;
%neurons 1 to 400 are excitatory, 401 to 500 are inhibitory
M = 50*ones(1,500);
T = 100; %total simulation time
h = 0.01; %step size

for i = 1:400
    a = randperm(500);
    Fanout{i} = a(1:50);
    Weight{i} = 3000;
    Delay{i} = unidrnd(20,1,50);
    spike_time{i}=[ ];
    arrival_time{i}=[ ];
    strength{i}=[ ];
    pre_neuron{i}=[ ];
end

for i = 401:500
    Fanout{i} = randperm(400,50);
    Weight{i} = -3000;
    Delay{i} = ones(1,50);
    spike_time{i}=[ ];
    arrival_time{i}=[ ];
    strength{i}=[ ];
    pre_neuron{i}=[ ];
end

Io = 10^-12;
tc_m = 15; %time constant of membrane
tc_s = tc_m/4; %time constant of synapse
Rp = 2/h;
event = zeros(T/h,25);
lambda = 0.1;
R = rand(size(event));
event(R<lambda*h) = 1; 
Iapp = zeros(N,T/h);

tic
for i = 1:25
    tk = find(event(:,i) == 1);
    [tkr, tkc] = size(tk);   
    for j = 1:T/h
        for k = 1:tkr
            if (tk(k)<j)
                Iapp(i,j) = Iapp(i,j) + (exp((tk(k)-j)*h/tc_m) - exp((tk(k)-j)*h/tc_s));
            end
        end
    end
end
toc

for i = 1:25
    Iapp(i,:) = Io*3000*Iapp(i,:);
    %figure, plot(Iapp(i,:));
end

Gl = 30*10^-9;
Vt = 20*10^-3;
El = -70*10^-3;
C = 300*10^-12;

V = zeros(N,T/h);
V(:,1) = -0.069;

count1 = zeros(N,1);
count2 = ones(N,1);
spikechecker = zeros(N,T/h);

tic
for i = 2:T/h
     for j = 1:N
         [tkr,tkc] = size(arrival_time{j});
         for k = 1:tkc
             Iapp(j,i) = Iapp(j,i) + Io*strength{j}(k)*(exp((arrival_time{j}(k) - i)/tc_m) - exp((arrival_time{j}(k) - i)/tc_s))*heaviside(i - arrival_time{j}(k));                 
         end
     end
    k1 = (-Gl * (V(:,i-1) - El) + Iapp(:,i-1))/C;
    k2 = (-Gl * ((V(:,i-1)+h*k1) - El) + Iapp(:,i))/C;
    V(:,i) = V(:,i-1) + 0.5*h*(k1+k2);
    for j = 1:N
        if (V(j,i)>Vt)
            V(j,i) = El;
            count2(j) = count2(j) + 1;
            spikechecker(j,i) = 1;
        end
        if ((V(j,i-1) == El) && (count1(j) == Rp))
            count1(j) = 0;
        end
        if ((V(j,i-1) == El) && (count1(j)<Rp))
            V(j,i) = El;
            count1(j) = count1(j) + 1;
        end
    end
    for j = 1:N
        if (spikechecker(j,i) == 1)
            spike_time{j} = cat(2,spike_time{j},i);
            for k = 1:50
                l = Fanout{j}(k);
                pos = find(Fanout{l} == j);
                arrival_time{l} = cat(2,arrival_time{l},(i+Delay{l}(pos)));
                strength{l} = cat(2,strength{l},Weight{j});
            end
        end
    end
    i
end
toc

imshow(spikechecker);
