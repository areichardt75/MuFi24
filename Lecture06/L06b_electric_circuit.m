% First order electric circuit (e.g. voltage excited serial RC-circuit)
% du/dt = -1/(R*C)*u + 1/(R*C)*us
% us(t) = pulse(t,T) = 
ust = @(t,T,Us0) Us0*(stepfun(t,0)-stepfun(t,T));

% resistor 
R = 10; % kOhm
% capacitance
C = 0.2; % uF 
U0 = 10; 
T = 8;
tau = R*C;

odefun = @(t,u,Rp,Cp,usf) -u/(Rp*Cp)+usf(t,T,U0)/(Rp*Cp);

[T,Y] = ode45( @(t,x) odefun(t,x,R,C,ust), [0 20], 0 );

%% Plot the solution
figure; 
  plot(T,Y,'k-'); 
  xlabel('time [ms]');
  ylabel('u [V]');

%% Try a more accurate solution
% It gives a better solution 
options = odeset('RelTol',1e-4);%'AbsTol',1e-6);
[T2,Y2] = ode45( @(t,x) odefun(t,x,R,C,ust), [0 20], 0, options );
figure; 
  plot(T2,Y2,'k-'); 
  xlabel('time [ms]');
  ylabel('u [V]');

%% Another strategy - use predefined time-steps
% 
tspan = 0:0.01:20;
[T3,Y3] = ode45( @(t,x) odefun(t,x,R,C,ust), tspan, 0);
figure; 
  plot(T2,Y2,'k-',T3,Y3,'r-',T,Y,'b-'); 
  xlabel('time [ms]');
  ylabel('u [V]');
  legend('sol 2','sol 3','sol 1','Location','northeast');
% Question (Exercise) : 
% Can we make a default time step and use interpolation for the missing
% points?

%% Try another tau 
R = 20; 
tau = R*C;

options = odeset('RelTol',1e-4);%'AbsTol',1e-6);
[T5,Y5] = ode45( @(t,x) odefun(t,x,R,C,ust), [0 20], 0, options );
figure; 
  plot(T5,Y5,'k-'); 
  xlabel('time [ms]');
  ylabel('u [V]');

%% more excitating source function
ustt = @(t,Us, om) Us*cos(om*t);
odefun = @(t,u,Rp,Cp,usf) -u/(Rp*Cp)+usf(t,10,2*pi/(4*Rp*Cp))/(Rp*Cp);
options = odeset('RelTol',1e-4);%'AbsTol',1e-6);
[T6,Y6] = ode45( @(t,x) odefun(t,x,R,C,ustt), [0 40], 0, options );
figure; 
  plot(T6,Y6,'k-'); 
  xlabel('time [ms]');
  ylabel('u [V]');
