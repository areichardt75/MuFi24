% Numerical integration- of f(x)
% f(x) = x*exp(-x/14)*cos(2*pi/21*x)

% let's define function fx 
% Don't forget about elementwise operations!
fx = @(x) x.*exp(-x/14).*cos(2*pi/21*x);

% integrate between 0 and 6
Ix = integral(fx, 0, 6)

%% Make it more general
% Function is defined using parameters
% in a more general way
fxx  = @(x,tau,OM) x.*exp(-x/tau).*cos(OM*x);

IXx = integral(@(x) fxx(x,14,2*pi/21), 0, 6)

%% Create an integral function 
% use fxx defined earlier
p = 0:0.1:10;
Ixv = zeros(size(p));
for id=2:length(p)
  % It = integral( fx, 0, p(id));
  UL = p(id);
  % Ixv(id) = integral(fx, 0, UL);
  Ixv(id) = integral(@(x) fxx(x, 14, 2*pi/21), 0, UL);
end

figure; 
  plot(p, fxx(p,14,2*pi/21), 'r-', p, Ixv, 'b-');
  xlabel('x');
  ylabel('f(x), int(f(x))')
  legend('f(x)', 'Int(f(x), 0, x)', 'Location','southwest');


%% Calculate integral 0 to x of Gauss-function

fG = @(x) 2*exp(-(x.^2/0.5));
p = 0:0.1:20;
x = -20:0.1:20;
y = fG(x);

IG = zeros(size(p));
for id=1:length(IG)
  IG(id) = integral(fG, 0, p(id));
end

figure; 
  plot(x,y, 'r-', p, IG, 'b-');
  xlabel('x');
  ylabel('f(x), int(f(x))')
  legend('f(x)', 'Int(f(x), 0, x)', 'Location','southwest');

