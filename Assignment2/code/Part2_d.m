%Question 2d
L = 30;
W = 20;

Wb = W/3;
Lb = L/3;

si  = linspace(0,5,100);
so = 10e-2;

current = zeros(size(si,2),1);

idx = 1; 
for i= 1:size(si,2)
    current(idx,1) = cur(L,W, Lb, Wb, si(i), 10e-2);
    idx = idx +1; 

end
 
figure();
plot(si, current);
grid;
title('Current vsσ');
xlabel('σ');
ylabel('Current (A)');