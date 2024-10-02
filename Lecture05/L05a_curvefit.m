% Curve fit using least-square fit

t = [1;2;3;4;4.5;5;6;6.5];
y = [0;1;1.5;2;2.3;2;1.3;0];
% Function we are looking for
% cubic polynom
F = @(x,xdata) x(1)*xdata.^3+x(2)*xdata.^2+x(3)*xdata+x(4);
x0 = [1 1 1 0];

[p,resnorm] = lsqcurvefit(F,x0,t,y)

%% Fitted curve and measuring datas
% Show 
x = 1:0.01:6.5;
px = polyval(p,x);

figure; 
  plot(t,y,'ro','MarkerSize',12,'MarkerFaceColor','r');
  hold on;
  xlabel('t'); ylabel('x');

  plot(x,px,'k--');

%% Higher order polynom approximation
F4 = @(p,x) polyval(p,x);
x0 = [1 1 1 1 0];
[p4,resnorm] = lsqcurvefit(F4,x0,t,y)
px4 = polyval(p4,x);

figure; 
  plot(t,y,'ro','MarkerSize',12,'MarkerFaceColor','r');
  hold on;
  xlabel('t'); ylabel('x');

  plot(x,px4,'k--');

%% 8th grade polynom
Fn = @(p,x) polyval(p,x);

x0 = ones([1 9]);
[p8,resnorm] = lsqcurvefit(F4,x0,t,y)
px8 = polyval(p8,x);

figure; 
  plot(t,y,'ro','MarkerSize',12,'MarkerFaceColor','r');
  hold on;
  xlabel('t'); ylabel('x');

  plot(x,px8,'k--');

%% All the approximations 

figure; 
  plot(t,y,'ro','MarkerSize',12,'MarkerFaceColor','r'); 
  hold on; 
  plot(x,px,'k--',x,px4,'b--',x,px8,'g--','LineWidth',2);
legend('data','3','4','8','Location','south')

%% Exponencialis 
% Fexp = @(p,x) p(1).*exp(-p(2)*(x-1))+p(3).*(x-1).*exp(-p(2)*(x-1));%+p(4)*exp(-p(5)*(x-1));
Fexp = @(p,x) p(1).*exp(-p(2)*x)+p(3).*x.*exp(-p(2)*x);%+p(4)*exp(-p(5)*(x-1));
p0 = [1 1 1];% 10 0.1];
[pe,resnorm] = lsqcurvefit(Fexp,p0,t,y)
% fx = pe(1).*exp(-pe(2)*(x-1))+pe(2).*(x-1).*exp(-pe(2)*(x-1));%+pe(4)*exp(-pe(5)*(x-1));
fx = pe(1).*exp(-pe(2)*x)+pe(2).*x.*exp(-pe(2)*x);%+pe(4)*exp(-pe(5)*(x-1));

figure; 
  plot(t,y,'ro','MarkerSize',12,'MarkerFaceColor','r');
  hold on;
  xlabel('t'); ylabel('x');

  plot(x,fx,'k--');

%% exp*cos approximation
% f(x) = A*exp(-alfa*x)*cos(OM*x+ro)
FEC = @(p,x) p(1)*exp(-p(2)*x).*cos(p(3)*x+p(4)).*x;
p0 = [2 0.01 2*pi/14 0.2];
[pe,resnorm] = lsqcurvefit(FEC, p0, t, y);
fec = pe(1)*exp(-p(2)*x).*cos(p(3)*x+p(4)).*x;

figure; 
  plot(t,y,'ro','MarkerSize',12, 'MarkerFaceColor','r');
  hold on;
  xlabel('t'); ylabel('x');
  plot(x,fec,'k--');

