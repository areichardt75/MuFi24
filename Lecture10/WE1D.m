% Wave Equation in one-dimension 
% Waves on a spring 
% x in (0, L)
% t in (0, T)
% IC : x(x,0) = 1*sin(2*pi*x/L)+1*sin(2*pi/(2*L))+1*sin(2*pi/(3*L))
% 
uR = 0; 
uL = 0;
Nx = 30;
Nt = 100;
L = 10;
T = 150;
c = 0.2;
ICfun = @(x) sin(2*pi*x/(L/4)).*(x<L/4);
% ...%1*sin(2*pi*x/L)+1*sin(2*pi*x/(L/2))+1*sin(2*pi*x/(L/4));
  % sin(2*pi*x/L);

x = linspace(0,L,Nx+1);
t = linspace(0,T,Nt+1);
dx = x(2)-x(1); dt = t(2)-t(1);
Cour = c*dt/dx;
% create solution matrix
u = zeros(length(t), length(x));
% set initial conditions
u(1,:) = set_IC(x, ICfun);
% id = 2 (id=-1 is eliminated)
% calculate 2nd time step (special because of the scheme)
un = next_time_step0( u(1,:), Cour, uL, uR );
u(2,:) = un;
% Calculate all the other time steps
for idt=2:length(t)-1
  un = next_time_step( u(idt,:), u(idt-1,:), Cour, uL, uR);
  % Don't forget to save into solution matrix the calculated next step
  u(idt+1, :) = un;
end


% ============================
% Functions used in the script 
% 
function unext = next_time_step0(unow, Cour, uL, uR)
% calculating 2nd time-step using special formula, eliminating id=-1 
  unext = zeros(size(unow));
  unext(1) = uL; unext(end) = uR;
  for id=2:length(unow)-1
    unext(id) = unow(id)-0.5*Cour^2*(unow(id+1)-2*unow(id)+unow(id-1));
  end
end

function unext = next_time_step( unow, uprev, Cour,uL, uR)
% Calculation of next timestep's solution
  N = length(unow);
  unext = zeros(size(unow));
  unext(1) = uL; 
  unext(end) = uR;
  for id=2:N-1
    unext(id) = -uprev(id) + 2*unow(id) + Cour^2*(unow(id+1)-2*unow(id)+unow(id-1));
  end
end

function unext = set_IC(x, ICfun)
% Set IC (u(x) = I(x)) for one-dimension
  unext = ICfun(x);
end
