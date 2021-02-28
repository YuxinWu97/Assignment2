%Question 2c
L = 30;
W = 20;

Wb = linspace(0.1,W/2,10);
Lb = linspace(0.1,L,10);

si  = 1;
so = 10e-2; 

current = zeros(size(Wb,2)*size(Lb,2),1);
ba = zeros(size(Wb,2)*size(Lb,2),1);
 
idx = 1;
for i= 1:size(Lb,2)
    for j=1:size(Wb,2)
        ba(idx,1) = Lb(i)*Wb(j);
        current(idx,1) = cur(L,W, Lb(i), Wb(j), si, so);
        idx = idx +1; 
    end
end

figure();
plot(ba, current);
grid;
title('Current vs Bottleneck Area');
xlabel('Bottleneck Area');
ylabel('Current (A)');