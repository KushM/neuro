
Ns = 100;
T = 500;
lambda = 0.001;
deltat = 0.1;
N = T/deltat; 
event = zeros(N,Ns); % array recording at each bucket if a stimulus arrived
for i = 1:Ns
    a = zeros(N,1);
    R = rand(size(a)); 
    a(R<lambda*deltat) = 1; % set each element of event to 1 with probability lambda*delta
    event(:,i) = a;
end

%for i = 1:Ns
%    stimuli(i) = sum(event(i,:)==1);
%end
event = reshape(event,Ns,N);
%for i = 1:Ns
%    tk(i) = find(event(:,i)==1); % getting indices of arrivial
%end
%nspikes = size(tk);
%inter_arrival = diff(tk)*deltat; % interarrival times in seconds
%bin = 0:1:500; 
%count = histc(inter_arrival,bin);
%figure; bar(bin,count,'histc'); % draw histogram of absolute count
time = deltat:deltat:T;
%figure, plot(time, event);

%for i = 1:Ns
%    figure, plot(time, event(i,:));
%end

sigmaw = 5;
wo = 50;
Io = 10^(-12);
we = randn(1,Ns); % synaptic strength
we = wo + sigmaw*we;
tc_m = 15; %time constant of membrane
tc_s = tc_m/4; %time constant of synapse

Iapp = zeros(Ns,N);

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

for i = 1:Ns
    Iapp(i,:) = Iapp(i,:)*we(i)*Io;
end

%for i = 1:Ns
%    figure, plot(time,Iapp(i,:));
%end

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

%nspikes
max_V = max(V);
max_pos = find(V == max_V);
figure, plot(time,V);

minv = 1000;
sp = 0;
spt = 0;
for i = 1:Ns
    tk = find(event(i,:)==1);
    [tkr,tkc] = size(tk);
    if (tkc>0)
        for k = 1:tkc
            if (tk(k)<max_pos && (max_pos-tk(k))<minv)
                minv = max_pos - tk(k);
                sp = i;
                spt = tk(k);
            end
        end
    end
end

