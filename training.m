
if exist('P', 'var') ~= 1; P = 5376; end
if exist('epoch', 'var') ~= 1; epoch = 1; end
if exist('speed', 'var') ~= 1; speed = 1e-1; end
if exist('speeddown', 'var') ~= 1; speeddown = 0.9996; end
if exist('batch', 'var') ~= 1; batch = 1; end
if exist('method', 'var') ~= 1; method = 1; end

Accr = 0;
cycle = 64;
lz = length(z)-1;

f = z(2:end)-z(1:end-1);

Target = zeros(N,N,ln);
for num=1:ln
    Target(:,:,num) = exp(-((X - coords(num,1)).^2 + (Y - coords(num,2)).^2)*(4/A)^2);
    Target(:,:,num) = Target(:,:,num)/sqrt(sum(sum(Target(:,:,num).^2)));
end

randind = randperm(P);
accr_graph(1) = nan;

tic;
for ep=1:epoch
    for iter7=batch:batch:P
        grad = zeros(N,N,lz);
        for iter8=0:batch*ln-1 % parfor
            num = mod(iter8, ln)+1;
            W = zeros(N,N,length(z));
            mi = zeros(ln, 2); % индексы с максимальной интенсивностью в области
            me = zeros(ln, 1); % значение максимальной интенсивности в области

            % прямое распространение
%             W(:,:,1) = readimage([path, 'train/', num2str(nums(num)), '/', num2str(randind(iter7-floor(iter8/ln))), ...
%                 '.bmp'], N, (N-AN)/2);
            W(:,:,1) = resizeimage(Train(:,:,randind(iter7-floor(iter8/ln)),num),N,AN);

            W(:,:,1) = parpropagation(W(:,:,1), z(1), k, U);
            for iter9=1:lz
                W(:,:,iter9+1) = parpropagation(W(:,:,iter9).*DOES(:,:,iter9), f(iter9), k, U);
            end

            % получение оценок
            for num2=1:ln
                [me(num2), mi(num2, 1:2)] = get_max_intensity(X, Y, W(:,:,end), coords(num2, 1), coords(num2, 2), G_size);
            end
            [~, argmax] = max(me);

            if argmax == num
                Accr = Accr + 1;
            else
                % обучение
                F = zeros(N);
                switch method
                    case 1
                        % Гаусс
                        F = conj(W(:,:,end)).*(abs(W(:,:,end)).^2 - Target(:,:,num));
                    case 2
                        % СКО
                        me(num) = me(num) - 1;
                        for num2=1:ln
                            F(mi(num2,1),mi(num2,2)) = conj(W(mi(num2,1),mi(num2,2),end))*me(num2);
                        end
                    case 3
                        % Кросс энтропия
                        me = exp(me*5e3);
                        for num2=1:ln
                            F(mi(num2,1),mi(num2,2)) = conj(W(mi(num2,1),mi(num2,2),end))*me(num2);
                        end
                        F(mi(num,1),mi(num,2)) = F(mi(num,1),mi(num,2)) - conj(W(mi(num,1),mi(num,2),end))*sum(me);
                end
                T = zeros(N,N,lz);
                for iter9=0:lz-1
                    F = parpropagation(F, f(end-iter9), k, U).*DOES(:,:,end-iter9);
                    T(:,:,end-iter9) = imag(W(:,:,end-iter9-1).*F);
                end
                T = T/max(max(max(abs(T))));
                grad = grad + T;
            end
        end
    
        % обновляем веса
        DOES = DOES.*exp(2i*pi*speed*grad/ln/batch);
        speed = speed*speeddown;

        % вывод данных в консоль
        if mod(iter7, cycle) == 0
            Accr = Accr/cycle/ln*100;
            accr_graph(end+1) = Accr;
            display(['epoch = ' num2str(ep) '; iter = ' num2str(iter7) '/' num2str(P) ...
                 '; accr = ' num2str(accr_graph(end)) '%; time = ' num2str(toc) ';']);
            Accr = 0;
        end
    end
    DOES = exp(1i*angle(DOES));
%     save('DOE.mat', 'DOES', 'z');
end

% plot(accr_graph);
% ylim([0 100]);
% grid on;

clearvars num num2 iter7 iter8 iter9 ep epoch P speed me mi W F T argmax Accr cycle f Target ...
    randind grad batch method speeddown lz;
