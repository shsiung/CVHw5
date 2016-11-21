function [W, b] = UpdateParameters(W, b, grad_W, grad_b, learning_rate)
% [W, b] = UpdateParameters(W, b, grad_W, grad_b, learning_rate) computes and returns the
% new network parameters 'W' and 'b' with respect to the old parameters, the
% gradient updates 'grad_W' and 'grad_b', and the learning rate.

for i = 1 : length(grad_W)
    updatedW = W{i} - learning_rate * grad_W{i};
    W(i) = mat2cell(updatedW,size(updatedW,1));
    b(i) = num2cell(b{i} - learning_rate * grad_b{i},1);
end

end

