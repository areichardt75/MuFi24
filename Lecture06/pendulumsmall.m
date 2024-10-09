function [dypdt] = pendulumsmall(t,y, L)
%PENDULUMFUN Summary of this function goes here
%   Detailed explanation goes here
g = 10;
dypdt = zeros(size(y));
dypdt(1) = y(2);
dypdt(2) = -g*y(1)/L;
end

