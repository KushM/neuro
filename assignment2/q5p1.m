
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
event = reshape(event,Ns,N);
event2 = zeros(N,Ns); % array recording at each bucket if a stimulus arrived
for i = 1:Ns
    a = zeros(N,1);
    R = rand(size(a)); 
    a(R<lambda*deltat) = 1; % set each element of event to 1 with probability lambda*delta
    event2(:,i) = a;
end
event2 = reshape(event2,Ns,N);


time = deltat:deltat:T;

sigmaw = 20;
wo = 200;
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
Iappf = sum(Iapp);

Iapp2 = zeros(Ns,N);
for i = 1:Ns
    tk = find(event2(i,:)==1);
    [tkr,tkc] = size(tk);
    if (tkc>0)
        for j = 1:N
            for k = 1:tkc
                if(tk(k)<j)
                    Iapp2(i,j) = Iapp2(i,j) + (exp((tk(k)-j)*deltat/tc_m) - exp((tk(k)-j)*deltat/tc_s));
                end
            end
        end
    end
end
for i = 1:Ns
    Iapp2(i,:) = Iapp2(i,:)*we(i)*Io;
end
Iappf2 = sum(Iapp2);



figure, plot(time, Iappf);
xlabel('time');
ylabel('input current S1')
[V,nspikes] = q1p2_func(1,0.5,Iappf,1);
V = reshape(V,N,1);
figure, plot(time,V);
xlabel('time');
ylabel('output potential S2')

figure, plot(time, Iappf);
xlabel('time');
ylabel('input current S1')

[V2,nspikes2] = q1p2_func(1,0.5,Iappf2,1);
V2 = reshape(V2,N,1);
figure, plot(time,V2);
xlabel('time');
ylabel('output potential S2')
nspikes
nspikes2