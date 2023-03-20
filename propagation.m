function Out = propagation(Field, z, k, U)   
    F = exp(1i*z*sqrt(k^2 - U));
%     F = exp(1i*z*k)*exp(-1i*z*U/2/k);
        
    Out = ifft2(fft2(Field).*F);
end