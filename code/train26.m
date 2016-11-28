num_epoch = 30;
classes = 26;
layers = [32*32, 400, classes];
learning_rate = 0.001;

load('../data/nist26_train.mat', 'train_data', 'train_labels')
load('../data/nist26_test.mat', 'test_data', 'test_labels')
load('../data/nist26_valid.mat', 'valid_data', 'valid_labels')

[W, b] = InitializeNetwork(layers);

% Shuffle Data
I = randperm(size(train_data,1));
train_data = train_data(I, :);
train_labels = train_labels(I, :);

% Normalize Data
train_data = normalize(train_data);
test_data = normalize(test_data);
valid_data = normalize(valid_data);

plt_train_acc = zeros(num_epoch,1);
plt_valid_acc = zeros(num_epoch,1);
plt_train_loss = zeros(num_epoch,1);
plt_valid_loss = zeros(num_epoch,1);
plt_test_acc = zeros(num_epoch,1);
plt_test_loss = zeros(num_epoch,1);

for j = 1:num_epoch
    [W, b] = Train(W, b, train_data, train_labels, learning_rate);
    [train_acc, train_loss] = ComputeAccuracyAndLoss(W, b, train_data, train_labels);
    [valid_acc, valid_loss] = ComputeAccuracyAndLoss(W, b, valid_data, valid_labels);
    [test_acc, test_loss] = ComputeAccuracyAndLoss(W, b, test_data, test_labels);
    
    fprintf('Epoch %d - accuracy: %.5f, %.5f \t loss: %.5f, %.5f \n', j, train_acc, valid_acc, train_loss, valid_loss)
    plt_train_acc(j) = train_acc;
    plt_valid_acc(j) = valid_acc;
    plt_train_loss(j) = train_loss;
    plt_valid_loss(j) = valid_loss;
    plt_test_acc(j) = test_acc;
    plt_test_loss(j) = test_loss;
end
subplot(1,2,1)
plot(1:30,plt_train_acc,'LineWidth',1.5);
hold on;
plot(1:30,plt_valid_acc,'LineWidth',1.5);
plot(1:30,plt_test_acc,'LineWidth',1.5);

subplot(1,2,2)
plot(1:30,plt_train_loss,'LineWidth',1.5);
hold on;
plot(1:30,plt_valid_loss,'LineWidth',1.5);
plot(1:30,plt_test_loss,'LineWidth',1.5);

save('nist26_model_01.mat', 'W', 'b')
