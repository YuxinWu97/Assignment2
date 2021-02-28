%Question 1a
clc
clear all;

L = 30;
W = 20;

G = zeros(L,L);
F = zeros(L,1);
        
dx = 1;
V0 = 5; 
j=1;

for i=1:L
        
        n = i;
        nm = i-1;
        np = i+1;
        
        %Boundary Conditions 
        if i == 1 
            G(n,n) = 1;
            F(n,1) = V0;
        elseif i == L
            G(n,n) = 1;
            F(n,1) = 0;
         
        else 
           G(n,n) = -2/(dx)^2; 
           G(n, nm) = 1/(dx)^2;
           G(n,np) = 1/(dx)^2;
        end 

end

V = G\F; 

x= linspace(0,L,length(V));

for i = 1:L
   V_surf(i,:) = V;
end

figure();
surf(V_surf);
grid;
title('2-D Plot of V(x)');
xlabel('x');
ylabel('y');
zlabel('Voltage (V)');