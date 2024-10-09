% Simple pendulum 
th0 = pi/5;
% th0 = 0.1;
% model - 1 - teljes egyenlet
% order reduction
L = 1;
Tspan = [0 10];
x0 = [th0 0];

[T,Y] = ode45( @(t,y) pendulumfun(t,y,L), Tspan, x0);
th = Y(:,1); om = Y(:,2);
x = L*sin(th); y = -L*cos(th);

%abrazolas 
figure; 
  plot(T,th,'r-','LineWidth',2);
  xlabel('t'); ylabel('theta');

 
%% Egyszerusitett megoldas - kis kiteresekre ervenyes alak
%  theta'' = -g*theta/L

L = 1;
Tspan = [0 10];
x0 = [th0 0];

[Ts,Ys] = ode45( @(t,y) pendulumsmall(t,y,L), Tspan, x0);
ths = Ys(:,1); oms = Y(:,2);
xs = L*sin(ths); ys = -L*cos(ths);

figure; 
  plot(Ts,ths,'r-');
  xlabel('t'); ylabel('theta');


%% Osszehasonlitas
figure; 
  plot(T,th,'k-',Ts,ths,'b-','LineWidth',2);
  xlabel('t'); ylabel('theta');
  legend('full','small','Location','northeast');
