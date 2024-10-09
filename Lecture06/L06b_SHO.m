% Simple Harmonic Oscillator - no dumping
% x''+om^2 * x = f(t)
% om = sqrt(k/m), f(t) = F(t)/m

% Split ode into 1st-order ODEs
% x' = v
% v' = -k/m*x+F(t)/m
forcefun = @(t) 0;
% 
odefun = @(t,x,k,m,ft) [x(2);-k/m*x(1)+ft(t)/m];

k = 5; m = 1;
tspan = [0 20];
x0 = [0;10];
[T,Y] = ode45(@(t,x) odefun(t,x,k,m,forcefun),tspan, x0);

figure; 
  plot(T,Y(:,1),'k-',T,Y(:,2),'r-','LineWidth',2);
  xlabel('t');
  ylabel('x');
  legend('x','v','Location','best')

%% Source is different
forcefun2 = @(t) 10*stepfun(t,5);

k = 5; m = 1;
tspan = [0 20];
x0 = [0;10];
[T,Y] = ode45(@(t,x) odefun(t,x,k,m,forcefun2),tspan, x0);

ust = forcefun2(T);

figure; 
  plot(T,Y(:,1),'k-',T,Y(:,2),'r-','LineWidth',2);
  hold on; plot(T,ust,'g-','LineWidth',2);
  xlabel('t');
  ylabel('x');
  legend('x','v','source','location','best')



