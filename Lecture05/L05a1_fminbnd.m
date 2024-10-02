% Optimization in 1 dimension using a boundary interval
% Maximum power on a resistor attached to a Thevenin-generator
fun = @(x) (-1)*(10^2*x/((x+10).^2));
% a
% options set to display every iteration's information
opts = optimset('Display','iter');
[x fval] = fminbnd(fun, 0,100,opts);

%% Generalize the problem using anonymous function 
% (in a nested funciton call)
fun = @(x,R0,U0) (-1)*(U0^2*x/((x+R0).^2));
% Let's set U=20 V; R0 = 10 kOhm
[x fval] = fminbnd(@(x) fun(x,10,20), 0,100,opts);
% Let's set U0=10V; R)=20 kOhm
[x fval] = fminbnd(@(x) fun(x,20,10), 0,100,opts);