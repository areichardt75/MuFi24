% Lap2D.m
% Steady-state heat diffusion problem 
% x = 0:10, y = 0:15; 
% betan = (dx/dy)^2
tic;
idfun = @(x,y,Nx) x+(y-1)*Nx;
topfun = @(x,w) 100*sin(pi*x/w);
% Grid distances, grid coordinates and geometrical parameteres
dx =0.08;
dy =0.08;
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
% A = zeros(Nrow, Nrow);  
A = sparse( Nrow, Nrow);  %let's use sparse matrices
% B = zeros(Nrow, 1);     
B = sparse( Nrow, 1);     % we need sparse vectors too!

% filling in all non-zero coefficients
% index of bottom boundary
idBC_bottom = 1:Nx;
% index of left boundary
idBC_left = Nx+1:Nx:(Ny-1)*Nx+1;
% index of right boundary
idBC_right = 2*Nx:Nx:Nrow;

idBC = [idBC_left idBC_right];
for idd=idBC
  A(idd, idd) = 1;
end
fprintf('|');
% Applying BC on top
% index of top boundary
idtop = Nrow-(Nx)+1:Nrow;
for idd=idtop
  idx = idd - (Nrow-(Nx));
  A(idd,idd) = 1;
  B(idd) = topfun(x(idx),w);
end
% bottom 
for idd=idBC_bottom
  A(idd,idd) = 1;
  B(idd) = 20;
end

fprintf('|'); 
t0 = toc;
% inner part
tempnum = -2*(1+betan);
idrow = 2:Nx-1;
idcol = Nx*[1:Ny-2];
for id=idt
% for idy = 2:Ny-1 
%   idt = (idy-1)*Nx + idd;
%   for id = idt 
% for idx=2:Nx-1
%   for idy=2:Ny-1
%     id = idfun(idx,idy,Nx);
% advanced step 1. and step 2.
    A(id,[id-Nx id-1 id id+1 id+Nx]) = [betan 1 tempnum 1 betan];%-2*(1+betan);
  end
end


fprintf('|'); t1=toc;
% solving
T = A \ B;
% T = mldivide(A,B);
% T = linsolve(A,B);
% T = gmres(A,B,100,1e-8);
% reshape to get back in matrix form
Txy = reshape(T, [Nx Ny]);
t2 = toc;
% fprintf('Time to assemble (%8.4f, %8.4f) and to solve : %8.4f\n',t0, t1-t0,t2-t1);
fprintf('Assemble + solve : [%8.4f, %8.4f, %8.4f]\n', t0, t1-t0, t2-t1);

%% Plot results using built-in matlab functions
% [xx,yy] =meshgrid(x,y);
% figure;
%   surf(xx,yy,transpose(Txy));
%%
%   contourf(xx,yy,transpose(Txy));
