function [Output, F] = recognize(X, Y, Input, z, DOES, k, coords, G_size, U)    
    F = propagation(Input, z(1), k, U);
    for iter=1:length(z)-1
        F = propagation(F.*DOES(:,:,iter), z(iter+1)-z(iter), k, U);
    end
    
    ln = size(coords, 1);
    Output = zeros(1, ln);
    for nt = 1:ln
		Output(nt) = get_max_intensity(X, Y, F, coords(nt, 1), coords(nt, 2), G_size);
    end
end

