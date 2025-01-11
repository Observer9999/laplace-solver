function [x, w] = GLnodes(n, a, b)

    beta = 0.5 ./ sqrt(1 - (2*(1:n-1)).^(-2));
    J = diag(beta, 1) + diag(beta, -1);
    [V, D] = eig(J);
    x_standard = diag(D);
    w_standard = 2 * (V(1, :).^2)';
    x = (b - a) / 2 * x_standard + (a + b) / 2;
    w = (b - a) / 2 * w_standard;
end
