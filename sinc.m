function y = sinc( x )
    c = sin(pi*x)./(pi*x);
    c(isnan(c)) = 1;
    y = c;
end

