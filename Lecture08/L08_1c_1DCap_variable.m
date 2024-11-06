% L08_1DCapacitor.m 
% Capacitor's one dimensional model to solve 
% Assumptions : infinite area electrodes (no boundary) 
% 
d = 0.1;        % distance between electrodes [m]
Uapp = 100;     % applied voltage - [V]
eps0 = 8.854e-12; % dielectric constant 
d0 = 0.01;

% Model 3 - variable premittivity
% two, thin surface layers of thickness d0, epsr=2  
% parabolic type epsr, 
cc = [625 -62.5 2.5625];

N = 100;
x = linspace(0, d, N+1);
dx = x(2)-x(1);

epsr = polyval(cc,x);
epsr(x(:)<=d0) = 2;
epsr(x(:)>=(d-d0)) = 2;
% Assemblying equations 
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

%% Calculate electric field
E = -diff(fi)/dx;
E(N+1) = E(N);
% don't forgert we have equidistant discretization in space variable
figure; 
  plot(x, E, 'k-'); 
  xlabel('x [m]');
  ylabel('E [V/m]');

%% Calculate electric energy 
we = 0.5*eps0.*transpose(epsr).*(E.^2);
figure;
  plot(x, we, 'b-');
  xlabel('x [m]');
  ylabel(' we[J/m^3]');

