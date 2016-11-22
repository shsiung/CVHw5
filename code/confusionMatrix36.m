function confusionMatrix36()
classes = 36;
layers = [32*32, 800, classes];

load('../data/nist36_test.mat', 'test_data', 'test_labels')
load('nist36_model.mat','W','b');

[outputs] = Classify(W, b, test_data);

test_labels =  mat2cell(test_labels,ones(1,size(test_labels,1)),size(test_labels,2));
group_known = cellfun(@(x) find(x==max(x)),test_labels);
outputs =  mat2cell(outputs,ones(1,size(outputs,1)),size(outputs,2));
group_predict = cellfun(@(x) find(x==max(x)),outputs);

[C,~] = confusionmat(group_known, group_predict);
imagesc(C);
colorbar
xticks([1:36]);
xticklabels({'A','B','C','D','E','F','G','H','I','J','K',...
             'L','M','N','O','P','Q','R','S','T','U','V',...
             'W','X','Y','Z','0','1','2','3','4','5','6','7',...
             '8','9'});
yticks([1:36]);
yticklabels({'A','B','C','D','E','F','G','H','I','J','K',...
             'L','M','N','O','P','Q','R','S','T','U','V',...
             'W','X','Y','Z','0','1','2','3','4','5','6','7',...
             '8','9'});
set(gca,'XAxisLocation','top','YAxisLocation','left','ydir','reverse');
end