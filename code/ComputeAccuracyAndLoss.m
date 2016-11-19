function [accuracy, loss] = ComputeAccuracyAndLoss(W, b, data, labels)
% [accuracy, loss] = ComputeAccuracyAndLoss(W, b, X, Y) computes the networks
% classification accuracy and cross entropy loss with respect to the data samples
% and ground truth labels provided in 'data' and labels'. The function should return
% the overall accuracy and the average cross-entropy loss.
[output] = Classify(W,b,data);

output_cells = num2cell(output',1);
label_cells = num2cell(labels',1);
loss = cellfun(@(x,y) -log(bsxfun(@(m,n) sum(m.*n), x,y)), output_cells, label_cells);
loss = sum(loss)/length(data);

accuracy = cellfun(@(x,y) find(x==max(x))==find(y==max(y)), output_cells, label_cells);
accuracy = sum(accuracy)/length(data);
end
