function confusionMatrix()

classes = 26;
layers = [32*32, 400, classes];

load('../data/nist26_test.mat', 'test_data', 'test_labels')
% load('nist26_model.mat','W','b');

test_data = normalize(test_data);
% [outputs] = Classify(W, b, test_data);

test_labels =  mat2cell(test_labels,ones(1,size(test_labels,1)),size(test_labels,2));
group_known = cellfun(@(x) find(x==max(x)),test_labels);
outputs =  mat2cell(test_labels,ones(1,size(test_labels,1)),size(test_labels,2));
group_predict = cellfun(@(x) find(x==max(x)),test_labels);

[C,~] = confusionmat(group_known, group_predict);
imagesc(C)
colorbar


end