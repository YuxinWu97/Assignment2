%Question 2b

meshsize = 1;

L = 30;
W = 20;

nx = L/meshsize;
ny = W/meshsize;

si  = 1;
so = 10e-2;

current = zeros(5,1);

meshsize = [1,2,3,4,5];
for i = 1:size(meshsize,2)
    nx = L*(meshsize(i));
    ny = W*(meshsize(i));
    current(i,1) = cur(nx,ny, meshsize(i)*2, meshsize(i)*2, si, so);
end


figure();  %Optional
plot(meshsize, current);
grid;
title('Current vs Mesh Size');
xlabel('Mesh Size');
ylabel('Current (A)');