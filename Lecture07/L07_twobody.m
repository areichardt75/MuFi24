% Two body solver - high precision computing of trajectory
% 
% x'' = -x / r^3;
% y'' = -y / r^3;
% where r = (x^2+y^2)^(1/2)
% y1 = x; y2 = x'; y3 = y; y4 = y'
% Simple equations - needs high precision in computation 

% Try setting RelTol and AbsTol to get not so accurate solution.

options = odeset('RelTol',1e-13, 'AbsTol',1e-12, 'Stats','on');
Tspan = [0 5*2*pi];
vy0 = 0.15;
y0 = [2;0;0;vy0];
% try vy0 = 0.5, 0.75, 0.02, ...

% [T,Y] = ode78(@tbode, Tspan, y0, options);
[T,Y] = ode89(@tbode, Tspan, y0, options);

%% Plot
figure;
  plot(T,Y(:,1),'k-',T,Y(:,3),'b-');
  xlabel('time'); ylabel('coordinates');

%% Trajectory 
figure;
  plot(Y(:,1), Y(:,3), 'r-o');
  xlabel('x'); ylabel('y');




function dy = tbode(t, y)
  r = sqrt(y(1).^2+y(3).^2);
  dy = [y(2); -y(1)./(r.^3);y(4); -y(3)./(r.^3)];
end
