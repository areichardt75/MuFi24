% One-dimensional Laplace-equation solved on an equidistant grid
% homogeneous medium - d^2T/dx^2 = 0

% equidistant grid 
N = 20;
h = 0.1;
x = transpose((0:N)*h);
Dn = 1/h^2;

% Boundary conditions constant
T1 = 100;
T2 = 10;

% Set up equations
A = zeros(N+1,N+1);
B = zeros(N+1,1);

for id=2:N 
  A(id,id-1) = Dn; A(id,id) = -2*Dn; A(id,id+1) = Dn;
end

% Setting Boundary conditions
A(1,1) = 1; B(1) = T1;
A(N+1,N+1)=1; B(N+1) = T2;

% Solving algebraic equation
T = A \ B;

% Plotting
figure; 
  plot(x, T, 'r-o','LineWidth', 2);
  xlabel('x'); 
  ylabel('T(x)');
  

%% Problem B. 
% at x=L dT/dx=2 is given 
%  T_{L} - T_{L-1} = 2*( is used 
A(N+1,N) = -1/h; A(N+1,N+1) = 1/h; B(N+1) = 2;
T2 = A \ B;

figure; 
  plot(x, T2, 'r-o','LineWidth', 2);
  xlabel('x'); 
  ylabel('T(x)');

