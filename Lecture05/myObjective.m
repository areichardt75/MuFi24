function [f] = myObjective(xin)
%MYOBEJCTIVE 
% 
R = xin; 
% R0 = xin(2); 
R0 = 10;
U0 = 10;
f = (-1)*(R.*U0.^2./((R+R0).^2));
end

