function [Fa, Fb] = calcFaFb(fun, p, T)
%CALCFAFB Calculate Fourier-coefficients of fun
% 
OM0 = 2*pi/T;
% F0 = (1/T)*integral(@(t) fun(t), 0, T);
Fa = (2/T)*integral( @(t) fun(t).*cos(p*OM0*t), 0, T);
Fb = (2/T)*integral( @(t) fun(t).*sin(p*OM0*t), 0, T);
end

