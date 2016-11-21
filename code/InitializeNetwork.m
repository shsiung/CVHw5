function [W, b] = InitializeNetwork(layers)
% InitializeNetwork([INPUT, HIDDEN, OUTPUT]) initializes the weights and biases
% for a fully connected neural network with input data size INPUT, output data
% size OUTPUT, and HIDDEN number of hidden units.
% It should return the cell arrays 'W' and 'b' which contain the randomly
% initialized weights and biases for this neural network.
layer_n = length(layers);
W = cell(layer_n-1,1);
b = cell(layer_n-1,1);
for i = 1:layer_n-1
   W(i) = mat2cell(randn(layers(i+1),layers(i))*sqrt(2/layers(i)),layers(i+1));
   b(i) = num2cell(zeros(layers(i+1),1),1);
end
end
