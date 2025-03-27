% Gravitacios problema 1. 
% 
gamma = 6.67;     % gravitacios allando
M = 2;            % kozponti tomeg nagysaga
G = gamma*M;      % potencial szorzo tenyezo
% kezdopont koordinatai (hely, sebesseg)
x0 = 100;
y0 = 0;
vx0 = 1;
vy0 = sqrt(1.60^2-vx0^2);
Tmax = 1500*2;
% Megoldo parametereinek beallitasa es a megoldo hivasa
r0 = [x0 y0 vx0 vy0];
Tspan = [0 Tmax];
options = odeset('RelTol',1e-5,'Abs');
[T,Y] = ode45(@(t,x) gravode(t,x,G), Tspan,r0, options);

x = Y(:,1); y = Y(:,2); vx = Y(:,3); vy = Y(:,4);
%% Eredmeny kirajzolasa

figure;
subplot(121); 
  plot( x, y, 'r-o','MarkerSize',2);
  xlabel('x'); ylabel('y');
  axis equal

% fazister
% figure;
subplot(122);
  plot( vx, vy, 'bo', 'MarkerFaceColor','b','MarkerSize',2);
  xlabel('vx'); ylabel('vy');
  axis equal

%% 
v = sqrt(vx.^2+vy.^2);
figure; 
  plot3( x, y ,v,'k-o','MarkerFaceColor','k');
  xlabel('x');
  ylabel('y');
  zlabel('v');
  ax = gca;
  ax.XGrid = 'on'; ax.YGrid = 'on'; ax.ZGrid = 'on';

maxv = max(v); idmax = find(v==maxv); 
minv = min(v); idmin = find(v==minv);
hold on; 
  plot3(x(idmin), y(idmin), minv, 'go',...
    'MarkerFaceColor','g',...
    'MarkerSize',10);
  plot3(vx(idmax), vy(idmax), maxv, 'go',...
    'MarkerFaceColor','g',...
    'MarkerSize',10);

%% Gravitacios potencial es ero kijelzese
[U,Fx,Fy] = gravpot(M*gamma,x, y);
Ekin = .5*(vx.^2+vy.^2);

figure; 
  plot(T, U, 'k-');
  xlabel(['time [s]']);
  ylabel('U');
  title('Gravitaional potential');

%% Gravitacios potencialis energia helyfuggese
  figure; 
    plot3(x,y,U,'k-o','MarkerSize',2);
    xlabel('x');
    ylabel('y');
    grid on;

%% Potencial es kinetikus energia

  figure; plot(T,Ekin,'g-');

