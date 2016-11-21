num_epoch = 5;
classes = 36;
layers = [32*32, 800, classes];
learning_rate = 0.01;

load('../data/nist26_model_60iters.mat','W','b');
load('../data/nist36_train.mat', 'train_data', 'train_labels')
load('../data/nist36_test.mat', 'test_data', 'test_labels')
load('../data/nist36_valid.mat', 'valid_data', 'valid_labels')

[W_new, b_new] = InitializeNetwork(layers);
W_new{1} = W{1};
b_new{1} = b{1};

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
for j = 1:num_epoch
    [W_new, b_new] = Train(W_new, b_new, train_data, train_labels, learning_rate);
    [train_acc, train_loss] = ComputeAccuracyAndLoss(W_new, b_new, train_data, train_labels);
    [valid_acc, valid_loss] = ComputeAccuracyAndLoss(W_new, b_new, valid_data, valid_labels);
    
    fprintf('Epoch %d - accuracy: %.5f, %.5f \t loss: %.5f, %.5f \n', j, train_acc, valid_acc, train_loss, valid_loss)
    plt_train_acc(j) = train_acc;
    plt_valid_acc(j) = valid_acc;
    plt_train_loss(j) = train_loss;
    plt_valid_loss(j) = valid_loss;
end
subplot(1,2,1)
plot(1:num_epoch,plt_train_acc,'LineWidth',1.5);
hold on;
plot(1:num_epoch,plt_valid_acc,'LineWidth',1.5);

subplot(1,2,2)
plot(1:num_epoch,plt_train_loss,'LineWidth',1.5);
hold on;
plot(1:num_epoch,plt_valid_loss,'LineWidth',1.5);

save('nist36_model.mat', 'W', 'b')
