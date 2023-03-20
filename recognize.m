function [Output, F] = recognize( Input )
global nums coords X Y G_size DOES z;
    
    F = propagation(Input, z(1));
    for iter=1:length(z)-1
        F = propagation(F.*DOES(:,:,iter), z(iter+1)-z(iter));
    end
    
    Output = zeros(1, length(nums));
    for nt = 1:length(nums)
		Output(nt) = get_max_intensity(X, Y, F, coords(nt, 1), coords(nt, 2), G_size);
    end
end

