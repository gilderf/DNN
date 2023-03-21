function [Score, F, CoordScore] = recognize(X, Y, Input, z, DOES, k, coords, G_size, U)    
    N = size(X,1);
    F = zeros(N,N,length(z));
    F(:,:,1) = propagation(Input, z(1), k, U);
    for iter=1:length(z)-1
        F(:,:,iter+1) = propagation(F(:,:,iter).*DOES(:,:,iter), z(iter+1)-z(iter), k, U);
    end
    
    ln = size(coords, 1);
    Score = zeros(1, ln);
    CoordScore = zeros(ln, 2);
    for nt = 1:ln
		[Score(nt), CoordScore(nt, :)] = get_max_intensity(X, Y, F(:,:,end), coords(nt, 1), coords(nt, 2), G_size);
    end
end

