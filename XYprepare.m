function [ X,y,y_work ] = XYprepare( data )
X=data(:,1:250);
pre_close=data(:,246);
y_work=data(:,251:304);
m=size(X,1);
y_=zeros(m,1);
y=zeros(m,1);
X_appendix=[X(:,4),X(:,4).*X(:,5)];
[X_apndx_norm, mu, sigma]=featureNormalize(X_appendix);
X=[X,X_apndx_norm];
work1_X=X(:,4);
work2_X=X(:,5);
for i=0:49
    X(:,i*5+1)=X(:,i*5+1)./work1_X;
    X(:,i*5+2)=X(:,i*5+2)./work1_X;
    X(:,i*5+3)=X(:,i*5+3)./work1_X;
    X(:,i*5+4)=X(:,i*5+4)./work1_X;
    X(:,i*5+5)=X(:,i*5+5)./work2_X;
end

y_open=y_work(:,4);
y_maxs=[];
for i=1:9
    y_maxs=[y_maxs,y_work(:,i*5+2)];
end
y_max=max(y_maxs,[],2);
outlet=2;
y_=(y_max-y_open)*100./y_open;
y_=double(y_>=outlet);
y(y_==1)=2;
y(y_==0)=1;
%extend
y_1=(y_max-y_open)*100./y_open;
y_2=(y_open-pre_close)*100./pre_close;
p_outlet=y_open*(100+outlet)./100;
i_out = sum(cumsum(bsxfun(@ge, y_maxs, p_outlet),2)==0,2)+1;
i_out(i_out>size(y_maxs,2)) = nan;
%min
y_mins=[];
for i=0:9
    y_mins=[y_mins,y_work(:,i*5+3)];
end
fun = @(mi,op) (mi-op)*100./op;
y_mins=bsxfun(fun, y_mins, y_open);
y_min=y_mins(:,2);%y_min=y_mins(:,1);
for i=3:10%for i=2:10
    min_tmp=y_min;
    tmpidx=find(i_out+1<i);
    y_min=min(y_min,y_mins(:,i));
    y_min(tmpidx)=min_tmp(tmpidx);
end
y_min(isnan(i_out))=nan;
%%%step2
stp2_idx=find(y==2 & y_min<-outlet);
y(stp2_idx)=1;
y_work=[y_work,y_2,y_min,i_out,y_1];

%J = sum(cumsum(a~=0,2)==0,2)+1;
%J(J>size(a,2)) = nan;

end

