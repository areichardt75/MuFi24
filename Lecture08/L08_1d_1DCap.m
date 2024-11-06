% L08_1d_1DCap.m
% One dimensional model of capacitor with a multiple material layers
% inside
% 
clear all;
Uapp = 100;     % applied voltage - [V]
eps0 = 8.854e-12; % dielectric constant 

eps1 = 1;
eps2 = 2;
d = 0.1; 
d0 = 0.2;

% Create layers 
Nlayers = 10; 
Nfine = 5; 
Ncoarse = 10;

% type of materials (==0, "1"; ==1, "2"0
% type_of_mat = floor(rand(1,Nlayers)*2); % a way to create random pattern
type_of_mat = [0 1 1 0 1 0 1 0 1 0]; % for Nlayers = 10;
% Creating grid with coarse and fine 
xd = sort(rand(1,Nlayers-1)*d);   
dm = 0.25 * min(diff(xd));
xd = [0 xd d];
x = [];
for id=1:Nlayers
  x0 = xd(id); 
  x1 = xd(id+1);
  x = [x linspace(x0,x0+dm,Nfine) linspace(x0+dm, x1-dm, Ncoarse) linspace(x1-dm, x1, Nfine)];
end
x( diff(x)==0) = [];
h = [0 diff(x)];
epsr = zeros(size(x));
% Assemble equations
tipid = 1;
for id=1:length(x)
  if x(id)>xd(tipid+1) 
    tipid = tipid + 1; 
  end 
  if type_of_mat(tipid) == 0
    epsr(id) = eps1;
  else
    epsr(id) = eps2;
  end
end

% Assemblying equation
N = length(x);
A = sparse(N,N);
B = sparse(N,1);
A(1,1) = 1;
A(end, end) = 1;
for id=2:N-1
  epsrm = 0.5*(epsr(id-1)+epsr(id));
  epsrp = 0.5*(epsr(id)+epsr(id+1));
  A(id,id-1:id+1) =  2/(h(id)+h(id+1))*[epsrm/h(id) (-1)*(epsrm/h(id+1)+epsrp/h(id)) epsrp/h(id+1)];
end
B(end) = Uapp;

% Let's solve the problem
fi = A \ B;


%% Show some solution
figure;
  plot(x, fi, 'r-','LineWidth',2);
  xlabel('x [m]');
  ylabel('fi [V]');

%% Calculate electric field 
E = (-1)*diff(fi)./transpose(h(2:end));
E = [E; E(end)];

figure; 
  plot(x, E, 'k-');
  xlabel('x [m]');
  ylabel('electric field [V/m]');

%% More complex figure; 
figure; plot(x, abs(E)/max(abs(E)), 'k-', x, fi/Uapp, 'r-', x, epsr,'b-');

xlabel('x [m]');
ylabel('E, fi, eps_r');
legend('E norm', 'fi norm', 'eps_r', 'Location','southeast');
