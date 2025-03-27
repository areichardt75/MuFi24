function [U, Fx, Fy] = gravpot(G, x,y)
%GRAVPOT Calculation of gravitational potential and force
% 
U = zeros(size(x));
r = sqrt(x.^2+y.^2);
rhat = 1./(r.^3);
Fx = -G*x.*rhat;
Fy = -G*y.*rhat;
U = -G./rhat;
end

