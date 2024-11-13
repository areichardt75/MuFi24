% One-dimensional heat diffusion (transfer) 
% x in [0,L]
% T(x,0) = (x<L/2).*200*x+(x>=L/2).*(1-x)*200
% T(0,t) = 0
% T(0,L) = 0

L = 1;
alfa = 0.01;
T1 = 0;
T2 = 0;

% N = 210;
% dt = 0.001; 
N = 21*4;
dt = 0.1/16; 
x = linspace(0,L,N);
dx = x(2)-x(1);
Tmax = 10;
d = alfa*dt/(dx^2);

%%
Ntime = floor(Tmax/dt);
T = zeros(Ntime+1,N);
Tstart = setIC(x,L);
T(1,:) = Tstart;
for id=2:Ntime+1
  Tnext = FTCSD12(T(id-1,:), T1, T2, x, d);
  T(id,:) = Tnext;  
end

%% Plot solution

figure; 
%   plot(x,T(1,:), 'r-',x,T(end,:),'k-');
  plot(x,T([1:16*3:end],:));
  xlabel('x'); ylabel('T'); 
  


%% Private functions 
% FTCS with Dirichlet at B1 and B2
function fnext = FTCSD12(f,T1,T2,x,d)
  fnext= zeros(size(f));
  fnext(1) = T1;
  fnext(end) =T2;
  for id=2:length(x)-1
    fnext(id) = f(id) + d*(f(id-1)-2*f(id)+f(id+1));
  end
end

function TIC = setIC(x,L)
  Tmax = 100;
  TIC = (x<L/2).*2*Tmax.*x+(x>=L/2).*(L-x)*2*Tmax;
end