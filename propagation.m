function Out = propagation(Field, z, k, U)   
    F = exp(1i*z*U); 
    % U = sqrt(k^2 - U)
    % U = k - U/2/k
        
    Out = ifft2(fft2(Field).*F);
end