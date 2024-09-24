% Calculate transfer function of a circuit using simulation at given
% frequencies

% Parameters
R = 2;
L = 5;
C = 0.05;
% amplitude of excitation
Us = 10;

OM1 = 1e-2; 
OM2 = 1e2;
NOM = 1e3; 
omv = logspace(log10(OM1), log10(OM2), NOM);

U3 = zeros(size(omv));

for id=1:length(omv)
  om = omv(id);
  Z1 = j*om*L;
  Z2 = 1/(j*om*C);
  Z3 = j*om*2*L;
  Z4 = 1/(j*om*2*C);
  Z5 = j*om*3*L;
  Z6 = 1/(j*om*2*L);
  % Defining linear equations
  A = [1/R+1/Z1+1/Z2 -1/Z2 0;-1/Z2 1/Z2+1/Z3+1/Z4+1/Z5 -1/Z5;...
    0 -1/Z5 1/Z5+1/Z6+1/(4*R)];
  B = [1/R;0;0]*Us;
  x = A \ B;
  U3(id) = x(3);
end

K = abs(U3);
fi = angle(U3);

%%
figure;
  semilogx(omv,K, 'r-');
  xlabel('om');
  ylabel('abs(H)');

