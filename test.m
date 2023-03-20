
x = [-1 -1 1 1 -1]*G_size/2;
y = [1 -1 -1 1 1]*G_size/2;
figure;
hold on;

for iter=1:ln
plot(x+coords(iter,1), y+coords(iter,2), 'color', [0 0 0]);
end

xlim([-B B]);
ylim([-B B]);
grid on;

%%

figure;
hold on;

plot(1:64:length(accr1)*64, accr1, '-', 'color', [32 145 201]/255);
plot(1:64:length(accr1)*64, accr2, '--', 'color', [32 201 74]/255);
grid on;

legend('СКО', 'Кросс-энтропия');

%%

figure
imagesc([-B B], [-B B], angle(DOES1));
figure
imagesc([-B B], [-B B], angle(DOES2));

%%

num = randi([1 ln]);
W = resizeimage(Test(:,:,randi([1 TestData(num)]),num),N,AN);
[tmp, F] = recognize(W);
tmp = tmp./sum(tmp);
gr = gray;
gr = gr(end:-1:1, :);

figure;
imagesc([-B B], [-B B], abs(F).^2);
colormap(gr);
grid on;
axis xy;
for nt=1:length(nums)
    if tmp(nt) == max(tmp)
        text(coords(nt, 1)-A*4*0.2, coords(nt, 2)-A*4*0.4, sprintf('%.2f%%', tmp(nt)*100), 'fontsize', 14, 'color', [32, 145, 201]/255);
    else
        text(coords(nt, 1)-A*4*0.2, coords(nt, 2)-A*4*0.4, sprintf('%.2f%%', tmp(nt)*100), 'fontsize', 14);
    end
end

figure;
imagesc([-A A], [-A A], W(N/2-AN/2+1:N/2+AN/2, N/2-AN/2+1:N/2+AN/2));
colormap(gr);
axis xy;