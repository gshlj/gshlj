%function[] = call_date( data,date1,date2,date3,iter )
%call_date(20180504,20180614,20180624,200);

%%
%[ X,y,y_work ] = XYprepare( data );
function[] = call_date( data,date1,date2,date3,iter,X,y,y_work )
addpath('./common');
addpath('./nn');
train_dt_f=date1;
train_dt_t=date2;
train_idx=find(y_work(:,53)>=train_dt_f & y_work(:,53)<train_dt_t);
fprintf('\nsize_train: %f\n', size(train_idx,1));
dt_test_f=date2;
dt_test_t=date3;
test_idx=find(y_work(:,51)>=dt_test_f & y_work(:,51)<dt_test_t);
fprintf('\nsize_test: %f\n', size(test_idx,1));
X_train=X(train_idx,:);
y_train=y(train_idx,:);
m_train=size(X_train,1);
shuffle=randperm(m_train);
X_train=X_train(shuffle,:);
y_train=y_train(shuffle);
X_train=X_train(1:30000,:);
y_train=y_train(1:30000,:);
[pdummy,nn_params,accuracy] = nnFunction(X_train, y_train, [10,10,10,2],0,iter);
X_test=X(test_idx,:);
y_test=y(test_idx,:);
[pred,dummy] = predict(nn_params, [252,10,10,10,2], X_test);
accuracy=mean(double(pred == y_test));
fprintf('\nAccuracy: %f\n', accuracy * 100);

all=size(y_test,1);
pos=size(y_test(y_test==2),1);
fprintf('pos/all:%f\n',pos*100/all);

x=0.5;
tmpidx=find(pred==2 & dummy>x);
qty=size(tmpidx,1);
acc=mean(double(y_test(tmpidx)==2));
fprintf('0.5-----acc:%f  qty:%f\n',acc,qty);
x=0.6;
tmpidx=find(pred==2 & dummy>x);
qty=size(tmpidx,1);
acc=mean(double(y_test(tmpidx)==2));
fprintf('0.6-----acc:%f  qty:%f\n',acc,qty);
x=0.7;
tmpidx=find(pred==2 & dummy>x);
qty=size(tmpidx,1);
acc=mean(double(y_test(tmpidx)==2));
fprintf('0.7-----acc:%f  qty:%f\n',acc,qty);
x=0.8;
tmpidx=find(pred==2 & dummy>x);
qty=size(tmpidx,1);
acc=mean(double(y_test(tmpidx)==2));
fprintf('0.8-----acc:%f  qty:%f\n',acc,qty);
x=0.9;
tmpidx=find(pred==2 & dummy>x);
qty=size(tmpidx,1);
acc=mean(double(y_test(tmpidx)==2));
fprintf('0.9-----acc:%f  qty:%f\n',acc,qty);

[B,IX] = sort(dummy,'descend');
y_work_test=y_work(test_idx,:);
top10=IX(1:10);
aa=[y_work_test(top10,51:58),y_test(top10),dummy(top10)];
% intersect(a,b);

fprintf('\nquit');
end

