function [test_acc, test_loss] = visualizeWeight()
classes = 36;
layers = [32*32, 800, classes];

load('../data/nist36_test.mat', 'test_data', 'test_labels')
load('nist36_model.mat','W','b');

test_data = normalize(test_data);
[test_acc, test_loss] = ComputeAccuracyAndLoss(W, b, test_data, test_labels);

%% Plot updated weight
layer_one = mat2cell(W{1},ones(1,size(W{1},1)),size(W{1},2));
II = zeros(32,32,1,length(layer_one));
for k = 1:length(layer_one)
    unit = layer_one{k};
    unit = (unit - min(unit))/(max(unit)-min(unit));
    II(:,:,1,k) = reshape(unit,32,32); 
end
figure(2)
montage(II);
%% Plot initial weight
[W1, ~] = InitializeNetwork(layers);
layer_one = mat2cell(W1{1},ones(1,size(W1{1},1)),size(W1{1},2));
I = zeros(32,32,1,length(layer_one));
for k = 1:length(layer_one)
    unit = layer_one{k};
    unit = (unit - min(unit))/(max(unit)-min(unit));
    I(:,:,1,k) = reshape(unit,32,32); 
end
figure(1)
montage(I);


end