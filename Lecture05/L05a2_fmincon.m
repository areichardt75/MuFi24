% Optimization using bounds on multiple variables
% 
% x = 0:pi;
% y = 0:pi;
% fun2 = 2*sin(x(1)*(2*pi/(4*pi/3)).*sin(x(2))
fun2 = @(x) 2*sin( x(1)*8/4).*sin(x(2));
x = 0:pi/100:3*pi/2;
y = 0:pi/100:pi;
[xx,yy] = meshgrid(x,y);
zz = zeros(size(xx));
% Plot
for idx=1:length(y)
  for idy=1:length(x)
    zz(idx,idy) = fun2([xx(idx,idy);yy(idx,idy)]);
  end
end

% Plot function
figure; 
  surf(xx,yy,zz);
  xlabel('x');
  ylabel('y');

%% Find minima 
% x0 = [max(x)*rand(1);max(y)*rand(1)]; % not always converges to global
% maxima
x0 = [max(x)*1/3+max(x)/2*rand(1);max(y)*rand(1)];
[xs fval] = fmincon(fun2, x0,[],[],[],[],[0;0],[max(x);max(y)])

%
hold on;
plot3(x0(1),x0(2), fun2(x0), 'bo','MarkerSize',12,'MarkerFaceColor','b')
plot3(xs(1), xs(2), fval, 'ro','MarkerSize',12,'MarkerFaceColor','g');
