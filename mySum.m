function [ r ] = mySum( a,b )
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
end

