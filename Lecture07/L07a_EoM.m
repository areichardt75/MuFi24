% Equation of motion for a charged particle that moves inside a magnetic
% field of strength B0

% x(1) --> x,  x(2) --> vx, x(3) --> y,  x(4) --> vy
B0 = 10;
q = 1; 
m = 10;

options = odeset('RelTol',1e-2,'Stats','on');
Tspan = 0:.01:8;
x0 = [0;1;2;0];
[T,Y] = ode45( @(t,x) EoMode(t,x,q,B0,m), Tspan, x0, options);

x = Y(:,1); vx = Y(:,2); y = Y(:,3); vy = Y(:,4);

%% Show the results
figure; 
  plot(T,x,'r-',T,y,'k-');
  xlabel('time'); ylabel('position');

figure; plot(x,y,'k-o');
  xlabel('x'); ylabel('y');

%% Functions used in script
function dy = EoMode(t,y,q,B,m)
  F = Force(q,[y(2), y(4)], B);
  dy = zeros(size(y));
  dy(1) = y(2);
  dy(2) = (1/m)*F(1);
  dy(3) = y(4);
  dy(4) = (1/m)*F(2);
end


function F = Force(q,v,B)
  F(1) = q*v(2)*B;
  F(2) = -q*v(1)*B;
end

