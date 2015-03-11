N = 5;
M(1) = 3;
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

