% One-dimensional heat diffusion (transfer) 
% x in [0,L]
% T(x,0) = (x<L/2).*200*x+(x>=L/2).*(1-x)*200
% T(0,t) = 0
% T(0,L) = 0

L = 10;
alfa = 0.01;
T1 = 0;
T2 = 50;

% N = 210;
% dt = 0.001; 
N = 2100/4;
dt = 0.1; 
x = linspace(0,L,N);
dx = x(2)-x(1);
Tmax = 20*3;
d = alfa*dt/(dx^2);

Ntime = floor(Tmax/dt);
T = zeros(Ntime+1,N);
Tstart = setIC(x,L);
T(1,:) = Tstart;
for id=2:Ntime+1
  Tnext = BTCSD12( T(id-1,:), T1, T2, x, d);
  T(id,:) = Tnext;  
end

%% plot
figure; 
%   plot(x,T(1,:), 'r-',x,T(end,:),'k-');
  plot(x,T(1:20:end,:));
  xlabel('x'); ylabel('T'); 
  

%% private functions

% solving one step in time
function Tnext = BTCSD12( Tnow, T1, T2, x, d)
  imax = length(x); 
  A = zeros(imax,imax);
  B = transpose(Tnow);
  A(1,1) = 1; B(1) = T1;
  A(end,end) = 1; B(end) = T2;
  for id=2:imax-1
    A(id,id-1:id+1) = [-d 1+2*d -d];
  end
  Tnext = A \ B;
end

% setting initial condition
function TIC = setIC(x,L)
  Tmax = 100;
%   TIC = (x<L/2)*Tmax-(x>=L/2)*Tmax;
  TIC = x.*(x-5).*(x-20)*Tmax;
%   TIC = (x<L/2).*2*Tmax.*x+(x>=L/2).*(L-x)*2*Tmax;
end
