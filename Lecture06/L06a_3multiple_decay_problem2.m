% System of element decay - or kinetic reactions of elements
% ----------------------------------------------------------
% A --> B --> C   [la1, la2]
% B --> D         [la3]
% D --> A         [la4]
% D --> C         [la5]

% x = [NA, NB, NC, ND] 

x0 = [1000;0;0;0];
la = [0.02, 0.2, 0.42, 0.028, 0.062];

Tspan = [0 100];
options = odeset('RelTol',1e-5);
[T,Y] = ode45( @(t,x) MD2fun(t,x,la), Tspan, x0, options);

NA = Y(:,1); NB = Y(:,2); NC = Y(:,3); ND = Y(:,4);

% figure;
%   plot(T, NA, 'r-',T, NB, 'b-', T, NC, 'k-', T, ND, 'm-','LineWidth',2);
%   xlabel('time');
%   ylabel('number of particles');


%% Functions used in script
function xt = MD2fun(~,x,la)
  % xt = zeros(size(x));
  % xt(1) = -la(1)*x(1)+la(5)*x(4);
  % xt(2) = -la(2)*x(2)-la(3)*x(2)+la(1)*x(1);
  % xt(3) = la(2)*x(2)+la(4)*x(4);
  % xt(4) = la(3)*x(2)-la(4)*x(4)-la(5)*x(4);

  A = [-la(1) 0 0 la(5);...
    la(1) -la(2)-la(3) 0 0;...
    0 la(2) 0 la(4);...
    0 la(3) 0 -la(4)-la(5)];
  xt = A*x;
 
end