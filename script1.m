clear all;
init;
z = [0.3 0.6]/metric;

DOES = ones(N,N,length(z)-1);
epoch = 2;
speed = 1e0;
slowdown = 0.9996;
training;
check_result;

Data{1,1} = DOES;
Data{1,2} = accr_graph;
Data{1,3} = tabl1;
Data{1,4} = tabl2;
Data{1,5} = accuracy;
clear accr_graph;


DOES = ones(N,N,length(z)-1);
epoch = 2;
speed = 1e0;
slowdown = 0.9996;
method = 'nesterov';
params = [0.9];
training;
check_result;

Data{2,1} = DOES;
Data{2,2} = accr_graph;
Data{2,3} = tabl1;
Data{2,4} = tabl2;
Data{2,5} = accuracy;
clear accr_graph;


DOES = ones(N,N,length(z)-1);
epoch = 2;
speed = 1e0;
slowdown = 0.9996;
method = 'adagrad';
params = [0.1];
training;
check_result;

Data{3,1} = DOES;
Data{3,2} = accr_graph;
Data{3,3} = tabl1;
Data{3,4} = tabl2;
Data{3,5} = accuracy;
clear accr_graph;


DOES = ones(N,N,length(z)-1);
epoch = 2;
speed = 1e0;
slowdown = 0.9996;
method = 'rmsprop';
params = [0.999, 0.1];
training;
check_result;

Data{4,1} = DOES;
Data{4,2} = accr_graph;
Data{4,3} = tabl1;
Data{4,4} = tabl2;
Data{4,5} = accuracy;
clear accr_graph;


DOES = ones(N,N,length(z)-1);
epoch = 2;
speed = 1e0;
slowdown = 0.9996;
method = 'adam';
params = [0.9, 0.999, 0.1];
training;
check_result;

Data{5,1} = DOES;
Data{5,2} = accr_graph;
Data{5,3} = tabl1;
Data{5,4} = tabl2;
Data{5,5} = accuracy;
clear accr_graph;