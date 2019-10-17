%%
% X1=rand(10000,10);
% y1_tmp=((X1(:,3)-X1(:,2)).^2+X1(:,5).^3)./(X1(:,5)-X1(:,1));
addpath('./common');
addpath('./nn');
data=importdata('data1_180101_180701.txt');
[ X,y,y_work ] = XYprepare( data );%
call_date(data,20180320,20180516,20180525,50,X,y,y_work);%
%call_date(data,20180320,20180516,20180525,200);

X2=rand(10000,10);
y2_tmp= sin((X2(:,2)./(1-X2(:,4)))*10);


X=[X2];
y_tmp=[y2_tmp];
y=double(y_tmp>0);
y(y==1)=2;
y(y==0)=1;

%%
%data=importdata('data5_180101_180701.txt');
%data=data(1:10000,:);
%[ X,y ] = XYprepare( data );
%%
save('test','X','y');
%clear ; close all; clc
%ho_l_sizes=[10,10,10,2];
%nnCall(0.9, ho_l_sizes,0,200);