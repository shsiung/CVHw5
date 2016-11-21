function [] = checkGradient(layer)
    load('mydata.mat');
    data = testx;
    data = normalize(data);
    labels = testy;

    [M, N] = size(data);
    C = length(unique(int32(labels)));

    label_vector = zeros(M, C);
    for i = 1:M
        label_vector(i, int32(labels(i)) + 1) = 1.0;
    end
    labels = label_vector;

    % Shuffle data
    I = randperm(M);
    X = data(I, :);
    y = labels(I, :);

    layers = [N 5 5 C];
    [W, b] = InitializeNetwork(layers);

    rand_sample = randi(500,1);
    data = X(rand_sample,:)';
    labels = y(rand_sample,:)';
    
    [~, act_h, act_a] = Forward(W, b, data);
    [grad_W, ~] = Backward(W, b, data, labels, act_h, act_a);

    W_anal = grad_W{layer};
    
    epsilon = 1e-4;
    for i = 1: layers(layer) * layers(layer+1)
        Wp = W;
        Wn = W;
        Wp{layer}(i) = Wp{layer}(i) + epsilon;
        Wn{layer}(i) = Wn{layer}(i) - epsilon;
        [output_p, ~, ~] = Forward(Wp, b, data);
        [output_n, ~, ~] = Forward(Wn, b, data);

        loss_p = -log(bsxfun(@(m,n) sum(m.*n),  output_p{1}, labels));
        loss_n = -log(bsxfun(@(m,n) sum(m.*n),  output_n{1}, labels));
        grad_num = (loss_p - loss_n) / (2*epsilon);
        grad_anal = W_anal(i);

        fprintf('Analytic: %.5f, Numeric: %.5f Diff: %.7f\n',grad_anal, grad_num, abs(grad_anal-grad_num));
    end
end




