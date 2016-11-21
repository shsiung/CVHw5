function [W, b] = UpdateParameters(W, b, grad_W, grad_b, learning_rate)
% [W, b] = UpdateParameters(W, b, grad_W, grad_b, learning_rate) computes and returns the
% new network parameters 'W' and 'b' with respect to the old parameters, the
% gradient updates 'grad_W' and 'grad_b', and the learning rate.

for i = 1 : length(grad_W)
    updatedW = cell2mat(W(i)) - learning_rate * cell2mat(grad_W(i));
    W(i) = mat2cell(updatedW,size(updatedW,1));
    b(i) = num2cell(cell2mat(b(i)) - learning_rate * cell2mat(grad_b(i)),1);
end

end

