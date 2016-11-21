function [grad_W, grad_b] = Backward(W, b, X, Y, act_h, act_a)
% [grad_W, grad_b] = Backward(W, b, X, Y, act_h, act_a) computes the gradient
% updates to the deep network parameters and returns them in cell arrays
% 'grad_W' and 'grad_b'. This function takes as input:
%   - 'W' and 'b' the network parameters
%   - 'X' and 'Y' the single input data sample and ground truth output vector,
%     of sizes Nx1 and Cx1 respectively
%   - 'act_h' and 'act_a' the network layer pre and post activations when forward
%     forward propogating the input smaple 'X'

grad_W = cell(length(act_h)-1,1); 
grad_b = cell(length(act_h)-1,1); 

%dL/da
d_loss = act_h{end} - Y;
for i = length(act_h): -1 : 2
    gW = d_loss*act_h{i-1}';
    grad_W(i-1) = mat2cell(gW,size(gW,1));
    grad_b(i-1) = num2cell(d_loss,1);
    d_loss = (W{i-1}' * d_loss) .* (act_h{i-1}.*(1-act_h{i-1}));
end

end
