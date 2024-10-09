% SHo with dumping
% k = 5; 
% m = 1;
% a = 0.1;
forcefun = @(t) 0;

odefun = @(t,x,k,m,a,ft) [x(2);-a/m*x(2)-k/m*x(1)+ft(t)/m];

k = 5; m = 1; a=0.1;
tspan = [0 20];
x0 = [0;10];
[T,Y] = ode45(@(t,x) odefun(t,x,k,m,a,forcefun),tspan, x0);

xt = Y(:,1); vt = Y(:,2);
figure;
  plot(T,xt,'k-',T,vt,'r-','LineWidth',2);
  xlabel('time');
  ylabel('x, v');
  title('x(t) and v(t)');
  legend('x(t)','v(t)','location','best');
  
