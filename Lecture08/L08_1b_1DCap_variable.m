% L08_1DCapacitor.m 
% Capacitor's one dimensional model to solve 
% Assumptions : infinite area electrodes (no boundary) 
% 
d = 0.1;        % distance between electrodes [m]
Uapp = 100;     % applied voltage - [V]
eps0 = 8.854e-12; % dielectric constant 


% Model 2 - variable premittivity
% eps_r = 1 if 0<x<d/2
% eps_r = 2 if d/2<x<d

N = 100;
x = linspace(0, d, N+1);
dx = x(2)-x(1);

epsr = ones(size(x));
id = (x(:)>=(d/2));
epsr(id) = 2;
% Assmeblying equations 
A = sparse(N+1, N+1); 
B = sparse(N+1,1);
for id=2:N
  epsrm = 0.5*(epsr(id-1)+epsr(id));
  epsrp = 0.5*(epsr(id)+epsr(id+1));
  A(id,id-1:id+1) = [epsrm (-1)*(epsrm+epsrp) epsrp]/(dx^2);
end
A(1,1) = 1; A(end,end) = 1;
B(end) = Uapp;
% Let's solve the problem
fi = A \ B;

%% Show some solution
figure;
  plot(x, fi, 'r-','LineWidth',2);
  xlabel('x [m]');
  ylabel('fi [V]');


