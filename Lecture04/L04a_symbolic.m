% Solution of transfer characteristics using symbolic toolbox
% 1. set up variable
% 2. set of equations
% 3. solve equations using solve
% 4. "create" transfer functions
% 5. plot transfer functions using polynomial 

% 1. set up variables
syms jw L C U1 U2 U3 Us R 

% 2. set equations 
Z1 = jw*L; Z2 = 1/(jw*C); Z3 = jw*2*L; 
Z4 = 1/(jw*2*C); Z5 = jw*3*L; Z6=1/(jw*C);
eq1 = U1/Z1+(U1-Us)/(R)+(U1-U2)/Z2 == 0;
eq2 = U2/Z3+U2/Z4+(U2-U3)/Z5+(U2-U1)/Z2 == 0;
eq3 = U3/(4*R)+ U3/Z6+(U3-U2)/Z5 == 0;
sol = solve([eq1,eq2,eq3],[U1,U2,U3]);

%%
% let's print in a readable form
pretty( simplify( sol.U3));

%% substitue in the R,L,C parameters
% Given by problem R=2 kOhm, L=5 mH, C = 0.025 nF
% omega = 2 Mrad/s at L04a_sincircuit problem
pretty( simplify(subs(sol.U3,{R,L,C},{2,5,0.025})));


%% Read outn from previous line numerator and denumerator
num = [80 0 0 0];
% den = [3 135 676 1060 2320 1440 256];
den = [3 105 504 670 1192 720 128];

% calculate value of transfer functions for some frequencies
om = logspace(-2,2,1e4);
H = polyval(num, j*om) ./ polyval(den, j*om);
K = abs(H);
fi = angle(H);

%% Effect different scaling of x- and y-axes
% and show an amplitude characteristics 
figure; plot(om, K,'r-');
figure; semilogx(om, K, 'r-');
figure; loglog(om, K, 'r-');


