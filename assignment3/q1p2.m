clear
clc
tic

N = 5; %number of neurons
M(1) = 3; %connection of each neuron
M(2) = 2;
M(3) = 2;
M(4) = 2;
M(5) = 3;
for i = 1:N
    Weight{i} = 3000*ones(1,M(i));
end

Fanout{1} = [2,3,4];
Fanout{2} = [1,5];
Fanout{3} = [1,5];
Fanout{4} = [1,5];
Fanout{5} = [2,3,4];

Delay{1} = [1,5,9];
Delay{2} = [1,8];
Delay{3} = [5,5];
Delay{4} = [9,1];
Delay{5} = [8,5,1];

T = 30; %total time in milliseconds
h = 0.0004; %time step

for i=1:N
spike_time{i}=[ ];
arrival_time{i}=[ ];
strength{i}=[ ];
pre_neuron{i}=[ ];
Iapp{i} = zeros(1,T/h);
end

Ia = 50*10^-9;
Io = 10^-12;
Rp = 2;
t = 0:h:T-h;
Iapp{2} = Ia*(heaviside(t) - heaviside(t-1));
Iapp{3} = Ia*(heaviside(t-4) - heaviside(t-5));
Iapp{4} = Ia*(heaviside(t-8) - heaviside(t-9));
%figure, plot(Iapp1);

[~, spike_time{2}] = lif_func(Iapp{2},T,h,Rp);
[~, spike_time{3}] = lif_func(Iapp{3},T,h,Rp);
[~, spike_time{4}] = lif_func(Iapp{4},T,h,Rp);

for i = 2:4
    for j = 1:M(i)
        k = Fanout{i}(j);
        pos = find(Fanout{k} == i);
        temp = spike_time{i} + Delay{k}(pos);
        arrival_time{k} = cat(2, temp, arrival_time{k});
    end
end

for i = 1:N
    arrival_time{i} = unique(arrival_time{i});
    [height , width] = size(arrival_time{i});
    strength{i} = 3000*ones(1,height*width);
end

tc_m = 15; %time constant of membrane
tc_s = tc_m/4; %time constant of synapse

for i = 1:5
    for j = 1:5
        Isyn{i}{j} = zeros(1,T/h);
    end
end

for i = 1:5
    for j = 1:length(Fanout{i})
        n = Fanout{i}(j);
        if (~isempty(spike_time{n}))
            tk = spike_time{n};
            [tkr, tkc] = size(tk);
            for k = 1:T/h
                for m = 1:tkr
                    if (tk(m) < k)
                        Isyn{i}{n}(k) = Isyn{i}{n}(k) + (exp((tk(m)-k)*h/tc_m) - exp((tk(m)-k)*h/tc_s));
                    end
                end
            end
        end
    end
end

for i = 1:5
    for j = 1:5
        Isyn{i}{j} = Io*3000*Isyn{i}{j};
        %figure, plot(Isyn{i}{j});
    end
end

for i = 1:5
    for j = 1:5
        Iapp{i} = Iapp{i} + Isyn{i}{j};
    end
end

for i = 1:5
    figure, plot(Iapp{i});
end

[Va, spike_time{1}] = lif_func(Iapp{1},T,h,Rp);
[Vb, spike_time{5}] = lif_func(Iapp{5},T,h,Rp);
figure, plot(Va);
figure, plot(Vb);
spike_time{1}
spike_time{5}
toc

    



    

