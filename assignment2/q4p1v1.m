
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

sigmaw = 25;
wo = 250;
Io = 10^(-12);
we = randn(1,Ns); % synaptic strength
we = wo + sigmaw*we;
tc_m = 15; %time constant of membrane
tc_s = tc_m/4; %time constant of synapse
count = 0;

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

Japp = Iapp;

for i = 1:Ns
    Iapp(i,:) = Iapp(i,:)*we(i)*Io;
end
Iappf = sum(Iapp);

while (1)
    [V, nspikes] = q1p2_func(1,0.5,Iappf,1);
    
    if (nspikes == 0)
        break;
    end
    figure, plot(time,V);
    xlabel('time');
    ylabel(['potential for iteration ' num2str(count+1)]);
    spiketimes = find(V == -0.058);
    [spr,spc] = size(spiketimes);
    count = count+1;
    for j = 1:spc
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



we
count
figure, plot(time, V);
xlabel('time');
ylabel('final potential');

