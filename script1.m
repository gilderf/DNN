clear all;
init;

z = [0.3 0.6]/metric;
DOES = ones(N,N,length(z)-1);

epoch = 1;
speed = 1e-1;
speeddown = 0.9996;
batch = 1;
method = 2;
training;
DOES1 = DOES;
accr1 = accr_graph;

check_result;