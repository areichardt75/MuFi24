% Polinom interpolation
% using population-year data of World Bank
% 

% importing basic data (1975-2010 measured, 2015-  estimated)
load('population.mat');
pop = 1000*pop; % count population in millions
% Basic data shown
figure; 
  plot(ev, pop, 'b-','LineWidth',2);
  xlabel('year'); 
  ylabel('population [*million]');

%% Cubic interpolation
% x = [A;B;C;D] 
% y = A * x^3 + B * x^2 + C * x + D
%
Amat = vander(ev(4:7));
B = transpose(pop(4:7));
coeff3 = Amat \ B;

% 4th-order approximation
Amat4 = vander(ev(4:8));
B4 = transpose(pop(4:8));
coeff4 = Amat4 \ B4;

% 7th order approximation
Amat = vander(ev(1:8));
B = transpose(pop(1:8));
coeff7 = Amat \ B;

%% Show all the approximations together in a common figure
% Calculate interpolated population for cubic approximation
pop3 = coeff3(4);
for id=1:3
  pop3 = pop3 + coeff3(id)*(ev.^(4-id));
end

% population of 4th order approximation
pop4 = coeff4(5);
for id=1:4
  pop4 = pop4 + coeff4(id)*(ev.^(5-id));
end

% population of 7th order approximation
pop7 = coeff7(8);
for id=1:7
  pop7 = pop7 + coeff7(id)*(ev.^(8-id));
end

%% Plot all approximations and create a 
figure; 
  plot(ev, pop3, 'r-',ev,pop4,'b-',...
    ev,pop7,'m-',...
    ev,pop,'bo',...
    'MarkerSize',10,'MarkerFaceColor','b','LineWidth',2);
