% Radioactive decay - 
% dN/dt = -la*N
% la = ln(2)/tau_half 
% simeq 0.693/tau_half
tau_half = 5730; % in years
la = log(2)/tau_half;
N0 = 1000;

decayode = @(x,gamma) -gamma*x;

[T,Y] = ode45(@(t,x) decayode(x,la),[0 7000],[N0]);

%% 
figure;
plot(T,Y,'k-'); xlabel('time [years]'); ylabel('number of particles');

% Find half-life time 
id = find(Y<(N0/2));
fprintf('half-life time : %8.3f years\n',T(id(1)));

tin = linspace(T(33),T(34),100);
yin = interp1(T,Y,tin);
hold on; plot(tin,yin,'ko');