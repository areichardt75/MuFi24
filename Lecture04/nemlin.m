function [y] = nemlin(x,U0,R0,R1,R2,R3,alfa)
%NEMLIN Residual form of solvable equation
% function [y] = nemlin(x,U0,R0,R1,R2,R3,alfa)

y = zeros(size(x));

y(1) = x(1)+x(4)*R1-U0+R0*(x(4)+x(5)+x(6));
y(2) = x(2)+x(5)*R2-U0+R0*(x(4)+x(5)+x(6));
y(3) = x(3)+x(6)*R3-U0+R0*(x(4)+x(5)+x(6));
y(4) = x(1)-alfa*x(4).^2;
y(5) = x(2)-alfa*x(5).^2;
y(6) = x(3)-0.8*alfa*x(6).^(3/2);
end

