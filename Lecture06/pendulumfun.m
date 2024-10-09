function [dypdt] = pendulumfun(t,y, L)
%PENDULUMFUN Summary of this function goes here
% function [dypdt] = pendulumfun(t,y, L)
% Detailed explanation goes here


g = 10;
dypdt = zeros(size(y));
dypdt(1) = y(2);
dypdt(2) = -g*sin(y(1))/L;
end

