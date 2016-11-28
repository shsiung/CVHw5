function confusionMatrix()

classes = 26;
layers = [32*32, 400, classes];

load('../data/nist26_test.mat', 'test_data', 'test_labels')
load('nist26_model_01.mat','W','b');

test_data = normalize(test_data);
[outputs] = Classify(W, b, test_data);

test_labels =  mat2cell(test_labels,ones(1,size(test_labels,1)),size(test_labels,2));
group_known = cellfun(@(x) find(x==max(x)),test_labels);
outputs =  mat2cell(outputs,ones(1,size(outputs,1)),size(outputs,2));
group_predict = cellfun(@(x) find(x==max(x)),outputs);

[C,~] = confusionmat(group_known, group_predict);
imagesc(C)
colorbar
xticks([1:classes]);
xticklabels({'A','B','C','D','E','F','G','H','I','J','K',...
             'L','M','N','O','P','Q','R','S','T','U','V',...
             'W','X','Y','Z'});
yticks([1:classes]);
yticklabels({'A','B','C','D','E','F','G','H','I','J','K',...
             'L','M','N','O','P','Q','R','S','T','U','V',...
             'W','X','Y','Z'});
set(gca,'XAxisLocation','top','YAxisLocation','left','ydir','reverse');

end