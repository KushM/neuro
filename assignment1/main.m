clear
clc
fprintf('Assignment 1:');
fprintf('Question1 :');
fprintf( 'Part 1: finding threshold current:\n' );

run q1p1

fprintf('Part 2: simulate behaviour of a set of N neurons :\n');

run q1p2
fprintf('output matrix is N*M matrix, storing membrane potential for the N neurons, for the M time intervals\n');

fprintf('part 3: plot graph for leaky integrate and fire model, for given current\n');

run q1p3

fprintf(' \n\n part 4: Average time interval between spikes, as a function of I applied,k :\n');

run q1p4

fprintf('Question 2 ::: ');
fprintf('Part 1: calculate steady state values of V and U : Enter RS :\n\n');

run q2p1
fprintf('Part 1: calculate steady state values of V and U : Enter IB :\n\n');
run q2p1
fprintf('Part 1: calculate steady state values of V and U : Enter CH :\n\n');
run q2p1

fprintf('Part 2: Equivalent difference equations\n\n');
fprintf('Part 3: Model N neurons using Ihikevich model using Range Kutta 4th order method :\n\n');
fprintf(' Neuron type : RS, current = 400 pA ');
q2p3v2(1,400*10^(-12),1,0.5);
fprintf(' Neuron type : RS, current = 500 pA ');
q2p3v2(1,500*10^(-12),1,0.5);
fprintf(' Neuron type : RS, current = 600 pA ');
q2p3v2(1,600*10^(-12),1,0.5);
fprintf(' Neuron type : IB, current = 400 pA ');
q2p3v2(2,400*10^(-12),1,0.5);
fprintf(' Neuron type : IB, current = 500 pA ');
q2p3v2(2,400*10^(-12),1,0.5);
fprintf(' Neuron type : IB, current = 600 pA ');
q2p3v2(2,400*10^(-12),1,0.5);
fprintf(' Neuron type : CH, current = 400 pA ');
q2p3v2(3,400*10^(-12),1,0.5);
fprintf(' Neuron type : CH, current = 500 pA ');
q2p3v2(3,400*10^(-12),1,0.5);
fprintf(' Neuron type : CH, current = 600 pA ');
q2p3v2(3,400*10^(-12),1,0.5);



fprintf('Question 3 : \n\n\n');
fprintf('Part 1 : Difference equations\n');
fprintf('Part 2 : steady state values of V and U\n');
fprintf('Enter RS\n');
run q3p1
fprintf('Enter IB\n');
run q3p1
fprintf('Enter CH\n');
run q3p1


fprintf('Part 3 : Model N neurons using Adaptive exponential integrate and fire method using euler method :\n');
fprintf('Neuron type : RS, current = 250 pA');
q3p3v3(1, 0.5, 250*10^(-12),1);
fprintf('Neuron type : RS, current = 350 pA');
q3p3v3(1, 0.5, 350*10^(-12),1);
fprintf('Neuron type : RS, current = 450 pA');
q3p3v3(1, 0.5, 450*10^(-12),1);
fprintf('Neuron type : IB, current = 250 pA');
q3p3v3(2, 0.5, 250*10^(-12),1);
fprintf('Neuron type : IB, current = 350 pA');
q3p3v3(2, 0.5, 350*10^(-12),1);
fprintf('Neuron type : IB, current = 450 pA');
q3p3v3(2, 0.5, 450*10^(-12),1);
fprintf('Neuron type : CH, current = 250 pA');
q3p3v3(3, 0.5, 250*10^(-12),1);
fprintf('Neuron type : CH, current = 350 pA');
q3p3v3(3, 0.5, 350*10^(-12),1);
fprintf('Neuron type : CH, current = 450 pA');
q3p3v3(3, 0.5, 450*10^(-12),1);



fprintf('Question 4 :  ');
fprintf('Part 1 : Solve for membrane potential, when input is difference of heaviside functions, plots of membrane potentials, and m, n and h');
run q4p1v2


fprintf('Part 2: Plots of power dissipated in the various ion channels :\n');
run q4p2

fprintf('Part 3: Energy consumed : \n');
run q4p3

