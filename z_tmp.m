data=importdata('data1.txt');
X=data(:,1:250);
y_work=data(:,251:302);
X=X(1:10000,:);
y_work=y_work(1:10000,:);
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
y_=(y_max-y_open)*100./y_open;
y_=double(y_>=5);
y(y_==1)=2;
y(y_==0)=1;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% X1=rand(10000,10);
% y1_tmp=((X1(:,3)-X1(:,2)).^2+X1(:,5).^3)./(X1(:,5)-X1(:,1));

X2=rand(10000,10);
y2_tmp= sin((X2(:,2)./(1-X2(:,4)))*10);


X=[X2];
y_tmp=[y2_tmp];
y=double(y_tmp>0);
y(y==1)=2;
y(y==0)=1;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

SET SESSION group_concat_max_len = 10240;
drop procedure if exists pro10;
  --/
create procedure pro10()
begin
DECLARE i,cnt,intvl,rst_len,rst_x,j,cnt_j,wk_lmt1,wk_lmt2,lmt_end,lmt_end1,
        mrk_dt,mrkdt_end,mrkdt_end1 INT  DEFAULT 1;
declare cur_smbl char(9);
declare item1,item2 varchar(10000);
declare dt_start , dt_end, tmp_date date;
set dt_start='20180101',dt_end='20180701';
set intvl = 1,rst_len=60,rst_x=50;

CREATE TEMPORARY TABLE t_symbol(select (@i:=@i+1) as num,symbol from 
  (select distinct symbol from tbl_stk_pd1 )s,(select   @i:=0)it );
CREATE TEMPORARY table t_rst
  (str varchar(10000));
select count(1) into cnt from t_symbol;

  while i <= cnt do
    select symbol into cur_smbl from t_symbol where num = i;
    CREATE TEMPORARY TABLE t_work(select * from tbl_stk_pd1 where symbol=cur_smbl and date between dt_start and dt_end order by date);
    select count(1) into cnt_j from t_work;
    -- select * from t_work;
    while j+rst_len-1 <= cnt_j do
      set wk_lmt1=j-1;
      set wk_lmt2=wk_lmt1+rst_x;
      set lmt_end=wk_lmt1+rst_len;
      set lmt_end1=wk_lmt1+rst_len-1;
      -- convert(right(date_format(DATE, '%Y%m%d'),6),DECIMAL)
      select convert(date_format(DATE, '%Y%m%d'),DECIMAL) into mrk_dt from t_work limit wk_lmt2,1;
      select convert(date_format(DATE, '%Y%m%d'),DECIMAL) into mrkdt_end1 from t_work limit lmt_end1,1;
      select convert(date_format(DATE, '%Y%m%d'),DECIMAL) into mrkdt_end  from t_work limit lmt_end,1;
      select group_concat(CLOSEP,',',HIGH,',',LOW,',',OPENP,',',VOLUM order by date) into item1 from (select * from t_work limit wk_lmt1,rst_len) a;
      select group_concat(item1,',',mrk_dt,',',mrkdt_end1,',',mrkdt_end,',',CONVERT(cur_smbl,DECIMAL)) into item2;
      insert into t_rst values (item2);
      set j=j+intvl;
    end while;
    drop table t_work;
    set i=i+1,j=1;
    set cnt_j=0;
  end while;

end;
/
  -- ,',',HIGH,',',LOW,',',OPENP,',',VOLUM
  call pro10();

drop table t_symbol;     

select * from t_rst
INTO OUTFILE 'D:/gs/Desktop/data5_180101_180701.txt';
-- FIELDS ENCLOSED BY '' TERMINATED BY '' ESCAPED BY ''
-- LINES TERMINATED BY '';

drop table t_rst;

