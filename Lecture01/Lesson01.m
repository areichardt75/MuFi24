% Lesson #1 / 04/09/2024
2+3
first
3*4
a = 3
b = 4;
c = a * b
whos
clear all
whos
A = 1:3:19
linspace(1,19,7)
logspace(log10(1), log10(19),7)
length(A)
B = (2:4:27)
A*B
A*transpose(B)
transpose(A)*B
C = transpose(A)*B
det(C)
inv(C)
A = [2 3;-3 10];
B = [-4;5]
x = inv(A)*B
% A*x#
A*x
x2 = A\B
W = magic(5)
det(W)
inv(W)
transpose(W)
W'
whos
D = 10*rand(5,5)+1i*20*rand(5,5)
j
transpose(D)
D'
D'-transpose(D)
clc
close all
whos
clear A
whos
clear
whos
clear all
t = 0:pi/100:2*pi;
x = 2*sin(2*pi*t/0.5);
plot(t,x,'r-');
xlabel('time');
ylabel('x(t)');
title('Simple sine of time...');
y = cos(x);
plot(t,y,'b-');
hold on;
plot(t,x,'r-');
figure;
yyaxis;
yyaxis(1)
yyaxis("left")
plot(t,x,'r-','LineWidth',2);
plot(t,x,'b-','LineWidth',2);
yyaxis("right");
plot(t,y,'r-','LineWidth',2);
% indexing inside a vector
clear all
close all
help rand
rng('shuffle');
a = rand(20,1)
b = rand(1,20)
L = length(b)
for id=1:L-1 bdiff(id) = b(id+1)-b(id); end
bdiff
bdiff2 = b(2:end) - b(1:end-1)
b(2:end)
clear a
clear a; tic; a = sum(b(2:end)*b(1:end-1)); t2 = toc
clear a; tic; a = sum(b(2:end).*b(1:end-1)); t2 = toc
clear d; tic; for id=2:length(a) d(id) = b(id).*b(id-1); end; e=sum(d); toc
clear d; tic; for id=2:length(b) d(id) = b(id).*b(id-1); end; e=sum(d); toc