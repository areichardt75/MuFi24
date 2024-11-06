% One-dimensional Poisson-equation solved on an equidistant grid
% homogeneous medium - d^2 Phi/dx^2 = rho(x)
NAp = 10; NDn = -15;
poifv = @(x,L) (x<=L/2).*NAp+(x>L/2)*NDn;
% equidistant grid 
N = 200;
% h = 0.1;
L = 2;
x = transpose(linspace(0,L,N));
h = x(2)-x(1);
% x = transpose((0:N)*h);
Dn = 1/h^2;


% Boundary conditions constant
T1 = 0;
T2 = 0;

% Set up equations
A = zeros(N,N);
B = zeros(N,1);

for id=2:N -1
  A(id,id-1) = Dn; A(id,id) = -2*Dn; A(id,id+1) = Dn;
  B(id) = poifv(x(id),L);
end

% Setting Boundary conditions
A(1,1) = 1; B(1) = T1;
A(N,N)=1; B(N) = T2;

% Solving algebraic equation
T = A \ B;

% Plotting
figure; 
  plot(x, T, 'r-','LineWidth', 2);
  xlabel('x'); 
  ylabel('T(x)');
  

%% Problem B. 
% at x=L d/dx(Phi)=0 is given 
%  T_{L} - T_{L-1} = 0 is used 
A(N,N-1) = -1/h; A(N,N) = 1/h; B(N) = 0;
% A(1,1) = -1/h; A(1,2)=1/h; B(1)=0;
T2 = A \ B;
figure; 
  plot(x, T2, 'k-','LineWidth', 2);
  xlabel('x'); 
  ylabel('T(x)');

