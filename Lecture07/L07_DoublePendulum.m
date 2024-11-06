% Double-pendulum problem - m1, m2, L1, L2 
% Diff. eq. derived using Lagrange formalism
% Variables : Th1, Th2 
% ODE variables : 
% x(1) --> Th1, x(2) --> Th1', x(3) --> Th2, x(4) --> Th2'
% (m1+m2)*L1^2*Th1''+m2*L1*L2*cos(Th2-Th1)*Th2'' 
%   - m2*L1*L2*(Th1')^2*sin(Th2-Th1)+(m1+m2)*g*L1*sin(Th1) = 0
% m2*L2*Th2''+m2*L1*L2*TH1''*cos(Th2-Th1)+m2*L1*L2*(Th1')^2
%   - m2*g*L2*sin(Th2) = 0
%  
L1 = 1/4; L2 = 1/2;
m1 = 1; m2 = 10;
g = 9.81;
T1 = sqrt(L1/g); T2 = sqrt(L2/g);
Tmax = 20*max([T1 T2]);
% Tmax = 0.1;
Tspan = [0:0.01:Tmax];
options = odeset('RelTol',1e-5,'Stats','on');
x0 = [pi/2; 0;pi/2;0];
d2theta1 = @(x) (m2*L2*x(4)^2*sin(x(3)-x(1))-(m1+m2)*g*sin(x(1))+m2*cos(x(3)-x(1))*(L1*x(2)^2*sin(x(3)-x(1))+g*sin(x(3))))/(L1*(m1+m2)-m2*L1*(cos(x(3)-x(1))^2));
d2theta2 = @(x) (-cos(x(3)-x(1))*(m2*L2*x(4)^2*sin(x(3)-x(1))-(m1+m2)*g*sin(x(1)))+(m1+m2)*(-L1*x(2)^2*sin(x(3)-x(1))-g*sin(x(3))))/(L2*(m1+m2)-m2*L2*cos(x(3)-x(1))^2);
odeFunc = @(t,x) ([x(2) ; d2theta1(x) ; x(4) ; d2theta2(x)]);
[T,Y] = ode45(odeFunc, Tspan, x0, options);
% [T,Y] = ode45(@(t,x) DPendulum(t,x,m1,m2,L1,L2), Tspan, x0, options);

%%
Th1 = Y(:,1); 
Th2 = Y(:,3);
x1 = L1*sin(Th1);
y1 = L1*cos(Th1);
x2 = x1 + L2*sin(Th2);
y2 = y1 + L2*cos(Th2);
y1 = (-1)*y1; y2 = (-1)*y2;

%% 
figure;
  plot(T,Th1, 'r-',T, Th2, 'k-');
  xlabel('time');
  ylabel('Angle of pendulum');
  legend('Th1','Th2','Location','best');

  %%
figure; 
  plot([0 x1(1)],[0 y1(1)],'r-o','MarkerSize',10,'MarkerFaceColor','r');
  ax = gca;
  ax.NextPlot = 'add'; % hold on;
  plot([x1(1) x2(1)],[y1(1) y2(1)], 'k-o', 'MarkerSize',10,'MarkerFaceColor','k');
  axis([-2 2 -2 2]);

  for id=2:length(T)
    ax.NextPlot = 'replacechildren';
    plot([0 x1(id)],[0 y1(id)],'r-o','MarkerSize',10,'MarkerFaceColor','r');
    ax.NextPlot = 'add';
    plot([x1(id) x2(id)],[y1(id) y2(id)], 'k-o', 'MarkerSize',10,'MarkerFaceColor','k');
    pause(0.02);
  end

%% Functions used in the script
% ODE function of the double pendulum problem
function dy = DPendulum(t,x, m1, m2, L1, L2)
% x(1) --> Th1
% x(2) --> Th1'
% x(3) --> Th2
% x(4) --> Th2'
  g = 9.81;
  Th = [x(1) x(3)];
  Aeh = [(m1+m2)*L1*L1 m2*L1*L2*cos(Th(2)-Th(1));m2*L1*L2*cos(Th(2)-Th(1)) m2*L2];
  B = [m2*L1*L2*(x(2).^2).*sin(Th(2)-Th(1))+(m1+m2)*g*L1*sin(Th(1));
    m2*g*L2*sin(Th(2))-m2*L1*L2*(x(2).^2)];
  xx = inv(Aeh)*B;
  dy = zeros(size(x));
  dy(1) = x(2);
  dy(2) = xx(1);
  dy(3) = x(3);
  dy(4) = xx(2);
end

 
