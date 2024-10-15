% Multiple decay of elements 
% A ==> B ==> C
% lA, lB

lA = 0.41; 
lB = 0.4;

% x = [NA;NB;NC];
x0 = [1000;0;0];

options = odeset('RelTol',1e-5);
Tspan = [0 10000];
[T,Y] = ode45( @(t,x) MDode(t,x,lA,lB), tspan, x0, options);

NA = Y(:,1);
NB = Y(:,2);
NC = Y(:,3);

figure; 
  plot(T,NA,'r-',T,NB,'b-',T,NC,'k-','LineWidth',2);
  xlabel('time');
  ylabel('number of particles');
  legend('A','B','C','location','north');

  sumN = NA + NB + NC;

%% Does conservation of number particles fail?
% figure;
%   plot(T,sumN, 'r-','LineWidth',2);
%   xlabel('time ');
%   ylabel('number of particles');



%% Functions used in the script

function xv = MDode(t,x,laA,laB)
  xv = zeros(size(x));
  xv(1) = -laA*x(1);
  xv(2) = laA*x(1)-laB*x(2);
  xv(3) = laB*x(2);
end