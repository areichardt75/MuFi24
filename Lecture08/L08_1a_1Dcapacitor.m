% L08_1DCapacitor.m 
% Capacitor's one dimensional model to solve 
% Assumptions : infinite area electrodes (no boundary) 
% 
d = 0.1;        % distance between electrodes [m]
Uapp = 100;     % applied voltage - [V]
eps0 = 8.854e-12; % dielectric constant 

% Model 1 - Equidistant discretization 
% - one filling material (eps_r = 2)
% 
N = 100;
x = linspace(0, d, N+1);
dx = x(2)-x(1);
% h = diff(x);

% Assmeblying equations 
A = sparse(N+1, N+1); 
B = sparse(N+1,1);
for id=2:N
  A(id,id-1:id+1) = [1 -2 1]/(dx^2);
end
A(1,1) = 1; A(end,end) = 1;
B(end) = Uapp;
% Let's solve the problem
fi = A \ B;

%% Show some solution
figure;
  plot(x, fi, 'r-o','LineWidth',2);
  xlabel('x [m]');
  ylabel('fi [V]');


