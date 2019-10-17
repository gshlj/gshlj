function [nn_params] = nnCall(ratio_train, ho_l_sizes,lambda,Iter)
addpath('./common');
addpath('./nn');
%load('ex4data1.mat');%%
load('test');
m=size(X,1);
shuffle=randperm(m);
X=X(shuffle,:);
y=y(shuffle);
size_train=floor(m*ratio_train);
%ho_l_sizes=[25,20,20,10];%%
[pred,nn_params,accuracy] = nnFunction(X(1:size_train,:), y(1:size_train,:), ho_l_sizes,lambda,Iter);
i_l_size = size(X, 2);
layer_sizes=[i_l_size,ho_l_sizes];
pred = predict(nn_params, layer_sizes, X(size_train+1:m,:));
y_test=y(size_train+1:m,:);
accuracy=mean(double(pred == y_test));
fprintf('\nAccuracy: %f\n', accuracy * 100);
save('theta','nn_params');
end