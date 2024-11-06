% Two body problem solved in full mode
% 
% m1, m2 : mass of masses

m1 = 1; m2 = 100;
ell1 = 2; ell2 = ell1*m1/m2;
v10 = [0.1 0.1]*10;
v20 = m1/m2*v10*(-1);
% x10 = ell1*cos(pi/6); y10 = ell1*sin(pi/6);
x10 = ell1; y10 = 0.5*ell1;
x20 = (-1)*ell2/ell1*x10;  y20 = -ell2/ell1*y10;
Tspan = [0 50];
x0 = [x10 v10(1) y10 v10(2) x20 v20(1) y20 v20(2)];
options = odeset('RelTol',1e-12,'AbsTol',1e-10,'Stats','on');
[T,Y] = ode78(@(t,x) fulltwobodyode(t,x,m1,m2), Tspan, x0,options);

%% 
% figure; 
%   subplot(121);
%   plot(Y(:,1), Y(:,3), 'r-o');
%   xlabel('x'); ylabel('y');
%   subplot(122);
  % plot(Y(:,5), Y(:,7), 'k-o');

%% 
figure; 
  plot(Y(:,1), Y(:,3), 'r-', Y(:,5), Y(:,7), 'k-');

%% TKP mozgasa
xTKP = (Y(:,1)+Y(:,5))/2;
yTKP = (Y(:,3)+Y(:,7))/2;
figure; 
  % plot(xTKP, yTKP, 'g-');
  plot(Y(:,1), Y(:,3), 'r-', Y(:,5), Y(:,7), 'k-', xTKP, yTKP, 'g-');
  title('Movement of CoM');
  xlabel('x');
  ylabel('y');

%% 
 Ekin1 = 0.5*m1*Y(:,1).^2+0.5*m1*Y(:,3).^2;
 Ekin2 = 0.5*m2*Y(:,5).^2 + 0.5 * m1 * Y(:,7).^2;

 figure; 
  plot(T, Ekin1, 'r-', T, Ekin2, 'k-');
  xlabel('time');
  ylabel('kinetic energy')

function dy = fulltwobodyode(t,x,m1,m2)
  R12 = sqrt((x(1)-x(5)).^2+(x(3)-x(7)).^2);
  dy = zeros(size(x));
  dy(1) = x(2);
  dy(3) = x(4);
  dy(5) = x(6);
  dy(7) = x(8);
  dy(2) = m1*m2*(1/m1)*(x(5)-x(1))./(R12.^3);
  dy(4) = m1*m2*(1/m1)*(x(7)-x(3))./(R12.^3);
  dy(6) = m1*m2*(1/m2)*(x(1)-x(5))./(R12.^3);
  dy(8) = m1*m2*(1/m2)*(x(3)-x(7))./(R12.^3);
end
