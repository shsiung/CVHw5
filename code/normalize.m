function [X] = normalize(X)
    [N, ~] = size(X);
    meanx = mean(X, 1);
    stdx = std(X, 1);
    stdx(stdx<1e-5) = 1.0; %prevent divide by zero
    X = ( X - repmat(meanx, [N, 1]) ) ./ repmat(stdx, [N, 1]);
end