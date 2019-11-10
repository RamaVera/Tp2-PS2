function [responses, filters] = filter_pattern(pattern, sigma, theta, lambda ...
    ,psi, gamma, type)
    
    amt_iters = length(sigma);
    responses = cell(amt_iters, 1);
    filters = cell(amt_iters, 1);
    for i=1 : amt_iters
        g = gabor_fn(sigma(i), theta(i), lambda(i), psi(i), gamma(i), type(i));
        responses(i) = {filter2(g, pattern)};
        filters(i) = {g};
    end
    
end

