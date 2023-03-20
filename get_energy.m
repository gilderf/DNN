function E = get_energy(X, Y, W, x, y, size)
	MASK = (abs(X - x) < size/2).*(abs(Y - y) < size/2);
    
    E = sum(sum(abs(W.*MASK).^2));
end