% Three-body problem 
% 3 pearls with the same mass (m) are connected to each other by a spring
% with k spring-constant and initial length L0
% Place the system on the top of a table. Calculate distances of pearls if
% they are not moving?
m = 10;
k = 100;
L0 = 0.5;
mu0 = 0.5;
% L1 - distance 1 and 2, L2 - distance 1 and 3, 
% Positions of 1 and 3 are symmetrical on the top of the table.
% After some calculations it comes to the equations : 
% (m*g)/(2*k)*L1 = (L0-L1)*sqrt(4*L1^2-L2^2)
% 2*L1*L2 = L0*(L2+2*L1) (mu0==>0 limit?)
% mu0*m*g/(2*k) = 

options  = optimset('Display','iter-detailed');
x0 = [1.5;1.2];
x = fsolve(@(x) fthree(x,k,m,L0,mu0), x0, options);


function F = fthree(x,k,m,L0,mu0)
  g = 10;
  % F(1) = 2*x(1).*x(2)-L0*(x(2)+2*x(1)
  F(1) = mu0*m*g/(2*k)-L0*(1-x(2)./(2*x(1)))+3*x(2)/2;
  F(2) = (m*g/k)^2*x(1).^2-(L0-x(1)).^2.*(4*x(1).^2-x(2).^2);
end