% Solving set of linear equations given by sinusoidal 
Z1 = 10*j;
Z2 = -j*20;
Z3 = 20*j;
Z4 = -10*j;
Z5 = 30*j;
Z6 = -j*20;
Us = 10;
R = 5;

% Defining linear equations
A = [1/R+1/Z1+1/Z2 -1/Z2 0;-1/Z2 1/Z2+1/Z3+1/Z4+1/Z5 -1/Z6;...
  0 -1/Z4 1/Z4+1/Z5+1/(4*R)];
B = [1/R;0;0]*Us;
x = A \ B;

% Given by problem
om = 2;

% Complex amplitude of voltage
U3 = x(3);
fprintf('U3 =  %8.4f *exp(1i* %8.4f)\n',abs(U3), angle(U3));

%%
% Plot excitation and solution
t = linspace(0,4*2*pi/om,1e3);
u3t = abs(U3)*cos(om*t+angle(U3));
ust = abs(Us)*cos(om*t+angle(Us));
figure; 
  plot(t,ust,'r-','LineWidth',2); 
  hold on; 
  plot(t,u3t,'k-','LineWidth',2);
  xlabel('time [us]');
  ylabel('voltage [V]');
