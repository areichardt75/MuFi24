function [drdt] = gravode(t,r,G)
%GRAVODE ODE of gravitational problem
% 
drdt = zeros(size(r));
x = r(1); y = r(2);
d = (x.^2+y.^2).^(-3/2);
drdt(1) = r(3);
drdt(2) = r(4);
drdt(3) = -G*x*d;
drdt(4) = -G*y*d;
end

