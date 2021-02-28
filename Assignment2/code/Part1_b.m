%Question 1b
clc
clear all;

L = 30;
W = 20;

G = sparse(W*L,W*L);
F = sparse(W*L,1);
        
dx = 500;
dy = 500;
V0 = 5;

for i=1:L
    for j=1:W
        n = j + (i-1)*W;
        nxm = j + (i-2)*W;
        nxp = j + (i)*W;
        nym = (j-1) + (i-1)*W;
        nyp = (j+1) + (i-1)*W;
        
        %Boundary Conditions 
        if i == 1 || i == L 
            G(n,n) = 1;
            F(n,1) = V0;
        elseif j == 1 || j == W
            G(n,n) = 1;
            F(n,1) = 0;

        else
            G(n,n) =  -2/(dx)^2 + -2/(dy)^2;
            G(n,nxm) = 1/(dx)^2;
            G(n,nxp) = 1/(dx)^2;
            G(n,nym) = 1/(dy)^2;
            G(n,nyp) = 1/(dy)^2;
        end 
    end 
end

V = G\F; 

V_solution = zeros(L,W);

for i=1:L
    for j=1:W
        n = j + (i-1)*W;
        
        V_solution(i,j) = V(n);
    end
end
    
[X,Y] = meshgrid(1:W,1:L);

a = W;
b = L/2; 


figure();  %Optional
surf(X,Y,V_solution);
grid;
title('2-D Plot of Simulated V(x,y)');
xlabel('y');
ylabel('x');


num_itter = 140; 
Va = @(x,y,n) (1/n)*(cosh((n*pi*x)/a)* sin((n*pi*y)/a))/(cosh((n*pi*b)/a));

Vc = zeros(L+1, W+1);

for x=0:L
    for y=0:W
        for n = 1:2:2*num_itter
            Vc(x+1,y+1) = Vc(x+1,y+1) + Va(x-(L)/2,y,n);
        end
    end
end

Vc = Vc*((4*V0)/pi);

[X2,Y2] = meshgrid(0:W,0:L);

figure();
surf(X2,Y2,Vc);
grid;
title('2-D Plot of the analytical solution of V(x,y)');
xlabel('y');
ylabel('x');