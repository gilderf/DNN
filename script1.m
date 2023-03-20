clear all;
N = 256;
AN = 28;
init;

z = [0.3 0.6]/metric;
DOES = ones(N,N,length(z)-1);


for iter11=1:3
	init;
	DOES = interp2(DOES, linspace(1, size(DOES, 1), N), linspace(1, size(DOES, 2), N)', 'nearest');
    DOES(isnan(DOES)) = 1;

	epoch = 1;
	batch = 1;
	speed = 10^(-iter11);
	speeddown = 0.1^(1/(size(Train,3)*epoch/batch));
	method = 'SCE';
	training;

	N = N*2;
	AN = AN*2;
end

N = N/2;
AN = AN/2;
check_result;
