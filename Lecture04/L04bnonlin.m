% Solution of nonlinear (algebraic) equations
% 
% Circuit theory sample of 3 different LEDs
% 
% Use fsolve to solve nonlinear equations 
% 
% nemlin.m has the function to solve in form of F(x) = 0

U0=10; R0=1;
R1=5;R2=5; R3=5;
alfa=1;
[x,fval] = fsolve(@(x) nemlin(x,U0,R0,R1,R2,R3,alfa),zeros(6,1));

% Show voltages and characteristics

%%
% more informations about solution process
% use options 
opts = optimoptions('fsolve','Display','iter');
x0 = zeros(6,1);
[x2, fval,~,output] = fsolve(@(x)nemlin(x,U0,R0,R1,R2,R3,alfa),x0,opts);

%% Start from another point
x02 = x0;
x02(4:6) = [1;1;2];
[x3] = fsolve(@(x)nemlin(x,U0,R0,R1,R2,R3,alfa),x0,opts);

