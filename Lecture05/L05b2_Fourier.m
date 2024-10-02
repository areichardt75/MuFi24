% Calculation of Fourier-coefficients
% Let's start with a simple square function

T = 10; % period time [s]
OM0 = 2*pi/T; 
p = 1:5;
ft = @(x) (x>T/5).*(x<(3*T/4))*20;

Fa = zeros(size(p));
Fb = zeros(size(p));
F0 = integral(ft, 0, T)/T;
for id=p
  Fa(id) = integral(@(t) ft(t).*cos(id*OM0*t), 0, T)*(2/T);
  Fb(id) = integral(@(t) ft(t).*sin(id*OM0*t), 0, T)*(2/T);
end

% Create a simple table
fprintf('%3s | %8s | %8s \n','p','Fa','Fb');
fprintf('-----------------------------\n');
for id=1:length(p)
  fprintf('%3i | %8.4f | %8.4f \n',p(id), Fa(id), Fb(id));
end

%% A more complex function
% 
gt = @(t,T0) (t>(-1)*T0).*(t<T0).*(T0-t).*(T0+t);

p = 1:8;

G0 = integral(@(t) gt(t,T/4) , -T/2, T/2)/T;
Ga = zeros(size(p));
Gb = zeros(size(Ga));

for id=p
  Ga(id) = (2/T)*integral(@(t) gt(t, T/4).*cos(id*OM0*t), -T/2, T/2);
  Gb(id) = (2/T)*integral(@(t) gt(t, T/4).*sin(id*OM0*t), -T/2, T/2);
end

  
