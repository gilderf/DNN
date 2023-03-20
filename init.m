global metric lambda k AN N A B X Y nums coords DOES z U G_size;

metric = 0.001; % m -> mm
lambda = 0.532e-6/metric; % mm
k = 2*pi/lambda;

AN = 28*2;
N = 512;

A = 36e-6*28/2/metric;  % half size figure
B = A*N/AN; % half full size area

x = linspace(-B, B, N+1); x(end) = [];
[X, Y] = meshgrid(x, x);

kx = linspace(-pi*N/2/B, pi*N/2/B, N+1); kx(end) = [];
[Kx, Ky] = meshgrid(kx, kx);
T = Kx.^2 + Ky.^2;
U(1:N/2,1:N/2) = T(N/2+1:N,N/2+1:N);
U(N/2+1:N,1:N/2) = T(1:N/2,N/2+1:N);
U(1:N/2,N/2+1:N) = T(N/2+1:N,1:N/2);
U(N/2+1:N,N/2+1:N) = T(1:N/2,1:N/2);

nums = [0 1 2 3 4 5 6 7 8 9];
ln = length(nums);
aa = A*4;
hh = aa; %aa*sqrt(3)/2;
coords = [-aa hh; 0 hh; aa hh; -1.5*aa 0; -0.5*aa 0; 0.5*aa 0; 1.5*aa 0; -aa -hh; 0 -hh; aa -hh];
G_size = A;

z = [0.3 0.6]/metric;
DOES = ones(N, N, length(z)-1);

% path = 'D:/mnist/';
load('D:/mnist/Train.mat');
load('D:/mnist/Test.mat');

clearvars aa hh kx Kx Ky T;
