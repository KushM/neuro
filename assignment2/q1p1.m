%function [] = q1p1(T,deltat,lambda)

 % lambda is the arrival rate per second (per milli-second)
 % T is the time in milli-seconds
 % deltat is the step size in milli-second
 T = 500;
 lambda = 0.01;
 deltat = 0.1;
N = T/deltat; 
event = zeros(N,1); % array recording at each bucket if a stimulus arrived
R = rand(size(event)); 
event(R<lambda*deltat) = 1; % set each element of event to 1 with probability lambda*delta
tk = find(event==1); % getting indices of arrivial
%inter_arrival = diff(tk)*deltat; % interarrival times in seconds
%bin = 0:1:500; 
%count = histc(inter_arrival,bin);
%figure; bar(bin,count,'histc'); % draw histogram of absolute count
time = deltat:deltat:T;
figure, plot(time, event);
xlabel('time');
ylabel('stimuli');
