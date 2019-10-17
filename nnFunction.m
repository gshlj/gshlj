function [pred,nn_params,accuracy] = nnFuction(X, y, ho_layer_sizes,lambda,Iter)

addpath('./common');
addpath('./nn');

input_layer_size = size(X, 2);  % 20x20 Input Images of Digits
                          % (note that we have mapped "0" to label 10)

layer_sizes=[input_layer_size,ho_layer_sizes];

n=numel(ho_layer_sizes);
initial_nn_params = [];
pre_lsize= input_layer_size;
for i = 1:n
  next_lsize = ho_layer_sizes(i);
  tmp_th=randInitializeWeights(pre_lsize, next_lsize);
  initial_nn_params=[initial_nn_params;tmp_th(:)];
  pre_lsize = next_lsize;
end

options = optimset('MaxIter', Iter);

costFunction = @(p) nnCostFunction(p, layer_sizes, X, y, lambda);

[nn_params, cost] = fmincg(costFunction, initial_nn_params, options);

pred = predict(nn_params, layer_sizes, X);
accuracy=mean(double(pred == y));
fprintf('\nTraining Set Accuracy: %f\n', accuracy * 100);

end