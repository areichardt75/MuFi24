% Van der Pol-equation
% Nonlinear ordinary differential equation 
% An oscillating system  with non-linear damping
% x''-mu*(1-x^2)*x'+x = 0
% 
% Driven vdP-oscillator 
% x''-mu*(1-x^2)*x'+x + A*cos(om*t)= 0
% 
% Rewrite into first order equations
% y1' = y2
% y2' = mu*(1-y1*y1)*y2-y1
Tmax = 100;
mu = 0.5; 
x0 = [2;2.1];
options = odeset('RelTol',1e-5);
[T,Y] = ode45(@(t,x) vanderPol(t,x,mu),[0 Tmax],x0,options);

y1 = Y(:,1); 
y2 = Y(:,2);
%%
figure;
  subplot(211);
  plot(T,y2,'r-',T,y1,'b-');
  xlabel('t');
  ylabel('y(t)');

% figure; 
  subplot(212);
  plot(y1,y2,'r-','LineWidth',2);
  xlabel('y1'); ylabel('y2=y1'' ');
  axis equal;

 % figure;
  % plot(2*)


function dy = vanderPol(t,y,mu)
  dy = [y(2);mu*(1-y(1).^2).*y(2)-y(1)];
end