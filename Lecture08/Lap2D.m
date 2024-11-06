% Lap2D.m
% Steady-state heat diffusion problem 
% x = 0:10, y = 0:15; 
% betan = (dx/dy)^2
tic;
idfun = @(x,y,Nx) x+(y-1)*Nx;
% Grid distances, grid coordinates and geometrical parameteres
dx =0.1;
dy =0.1;
x = 0:dx:10;
y = 0:dy:15;
w = 10;
% discretization factor
betan=(dx/dy)^2;
% number of points in different dimensions
Nx = length(x);
Ny = length(y);
Nrow = Nx*Ny;

% creating matrixes for solution
A = zeros(Nrow, Nrow);
B = zeros(Nrow, 1);

% filling in all non-zero coefficients
idBC = [1:Nx Nx+1:Nx:(Ny-1)*Nx+1 2*Nx:Nx:Nrow];
for idd=idBC
  A(idd, idd) = 1;
end
% inner part
for idx=2:Nx-1
  for idy=2:Ny-1
    id = idfun(idx,idy,Nx);
    A(id,id) = -2*(1+betan);
    A(id,id-1) = 1;
    A(id,id+1) = 1;
    A(id,id-Nx) = betan;
    A(id,id+Nx) = betan;
  end
end

% Applying BC on top
idtop = Nrow-(Nx)+1:Nrow;
for idd=idtop
  A(idd,idd) = 1;
%   B(idd) = 100*sin((idd-Nx*(Ny-1))*dx*pi/w);
  B(idd) = 100;
end

% solving
T = A \ B;

% reshape to get back in matrix form
Txy = reshape(T, [Nx Ny]);
t2 = toc;
% Plot results using built-in matlab functions
[xx,yy] =meshgrid(x,y);
figure;
%   contourf(xx,yy,transpose(Txy));
  surf(xx,yy,transpose(Txy));

fprintf('Time to solve : %8.4f\n',t2);
