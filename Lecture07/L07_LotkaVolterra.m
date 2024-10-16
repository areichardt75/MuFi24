% Predator - prey model 
% Lotka-Volterra model 
% x' = a*x - p*x*y
% y' = q*x*y - b*y
% 

% Parameters (with a good phase space portrait)
a = 3.5;
b = 0.51;
p = 0.20;
q = 0.010;

% Setting up ode solvers
Tmax = 100;
options = odeset('RelTol',1e-5);
Tspan = [0 100];
x0 = [50;12];

[T,Y] = ode45( @(t,x) LVm(t,x,a,b,p,q), Tspan, x0, options);

prey = Y(:,1); % preys (rabbit) population
pred = Y(:,2); % predators (fox) population

%% 
figure; 
  plot(T, prey, 'r-', T, pred, 'k-', 'LineWidth',2);
  xlabel('time'); 
  ylabel('population');
  legend('prey (rabbit)', 'predator (fox)', 'location', 'best');

%% Phase space 
figure; 
  plot(prey, pred, 'k-','LineWidth',2);
  xlabel('prey');
  ylabel('pred');


function dy = LVm(t,y,a,b,p,q)
  dy = [a*y(1)-p*y(1)*y(2);q*y(1)*y(2)-b*y(2)];
end

