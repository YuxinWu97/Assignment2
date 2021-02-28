%Question 2a
clc
clear all;

L = 30;
W = 20;

Wb = W/3;
Lb = L/3;

si  = 1;
so = 10e-2;

G = sparse(W*L,W*L);
F = sparse(W*L,1);
sigma = zeros(L, W);

dx = 1;
dy = 1;
V0 = 5;

for i=1:L
    for j=1:W

        in_x = logical( i >= (L- Lb)/2 && i <= (L + Lb)/2);
        in_y = logical( j <= Wb | j >= (W-Wb));

        if in_x && in_y
            sigma(i,j) = so;
        else 
            sigma(i,j) = si;
        end 
        
        
    end
end

[X,Y] = meshgrid(1:W,1:L);
 
figure();
surf(X,Y,sigma);
grid;
colorbar;
title('Plot of σ(x,y)');
xlabel('y');
ylabel('x');
zlabel('σ');
view(0, 90); 

for i = 1:L
    for j = 1:W
        n = j + (i - 1) * W;

        if i == 1
            G(n, :) = 0;
            G(n, n) = 1;
            F(n,1) = V0;
        elseif i == L
            G(n, :) = 0;
            G(n, n) = 1;
        elseif j == 1
            nxm = j + (i - 2) * W;
            nxp = j + (i) * W;
            nyp = j + 1 + (i - 1) * W;

            rxm = (sigma(i, j) + sigma(i - 1, j)) / 2.0;
            rxp = (sigma(i, j) + sigma(i + 1, j)) / 2.0;
            ryp = (sigma(i, j) + sigma(i, j + 1)) / 2.0;

            G(n, n) = -(rxm+rxp+ryp);
            G(n, nxm) = rxm;
            G(n, nxp) = rxp;
            G(n, nyp) = ryp;

        elseif j ==  W
            nxm = j + (i - 2) * W;
            nxp = j + (i) * W;
            nym = j - 1 + (i - 1) * W;

            rxm = (sigma(i, j) + sigma(i - 1, j)) / 2.0;
            rxp = (sigma(i, j) + sigma(i + 1, j)) / 2.0;
            rym = (sigma(i, j) + sigma(i, j - 1)) / 2.0;

            G(n, n) = -(rxm + rxp + rym);
            G(n, nxm) = rxm;
            G(n, nxp) = rxp;
            G(n, nym) = rym;
        else
            nxm = j + (i-2)*W;
            nxp = j + (i)*W;
            nym = j-1 + (i-1)*W;
            nyp = j+1 + (i-1)*W;

            rxm = (sigma(i,j) + sigma(i-1,j))/2.0;
            rxp = (sigma(i,j) + sigma(i+1,j))/2.0;
            rym = (sigma(i,j) + sigma(i,j-1))/2.0;
            ryp = (sigma(i,j) + sigma(i,j+1))/2.0;

            G(n,n) = -(rxm+rxp+rym+ryp);
            G(n,nxm) = rxm;
            G(n,nxp) = rxp;
            G(n,nym) = rym;
            G(n,nyp) = ryp;
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

figure();  %Optional
surf(X,Y,V_solution);
grid;
colorbar;
title('Plot of V(x,y)');
xlabel('y');
ylabel('x');
zlabel('Voltage');


for i = 1:L
    for j = 1:W
        if i == 1
            Ex(i, j) = (V_solution(i + 1, j) - V_solution(i, j));
        elseif i == L
            Ex(i, j) = (V_solution(i, j) - V_solution(i - 1, j));
        else
            Ex(i, j) = (V_solution(i + 1, j) - V_solution(i - 1, j)) * 0.5;
        end
        
        if j == 1
            Ey(i, j) = (V_solution(i, j + 1) - V_solution(i, j));
        elseif j == W
            Ey(i, j) = (V_solution(i, j) - V_solution(i, j - 1));
        else
            Ey(i, j) = (V_solution(i, j + 1) - V_solution(i, j - 1)) * 0.5;
        end
    end
end


Ex = -Ex;
Ey = -Ey;

Fx = sigma .* Ex;
Fy = sigma .* Ey;


C0 = sum(Fx(1, :));
Cnx = sum(Fx(L, :));
Curr = (C0 + Cnx) * 0.5;


figure();
quiver(Ex', Ey');
axis([0 L 0 W]);
grid;
title('Plot of the electric field');
xlabel('x');
ylabel('y');


figure();
quiver(Fx', Fy');
axis([0 L 0 W]);
grid;
title('Plot of the current density');
xlabel('x');
ylabel('y');