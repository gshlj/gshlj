%%������200*200�ľ������Ӽ��˳����Ƚ�
t = zeros(1,100);
A = rand(200,200);B = rand(200,200);C = rand(200,200);
for i=1:100
tic;
D=A+B;E=A.*D;F=B./(E+eps);
t(i)=toc;
end;mean(t)
%%%%ans = 2.4812e-04
t1 = gpuArray(zeros(1,100));
A1 = gpuArray(rand(200,200));
B1 = gpuArray(rand(200,200));
C1 = gpuArray(rand(200,200));
for i=1:100
tic;
D1=A1+B1;E1=A1.*D1;F1=B1./(E1+eps);
t1(i)=toc;
end;mean(t1)
%%%%ans = 1.2260e-04
%%%%%%�ٶȿ��˽�������
%%Ȼ�󽫾����С��ߵ�5000*5000��ʵ��
t = zeros(1,100);
A = rand(5000,5000);B = rand(5000,5000);C = rand(5000,5000);
for i=1:100
tic;
D=A+B;E=A.*D;F=B./(E+eps);
t(i)=toc;
end;mean(t)
%%%%ans = 0.0337
t1 = gpuArray(zeros(1,100));
A1 = gpuArray(rand(5000,5000));
B1 = gpuArray(rand(5000,5000));
C1 = gpuArray(rand(5000,5000));
for i=1:100
tic;
D1=A1+B1;E1=A1.*D1;F1=B1./(E1+eps);
t1(i)=toc;
end;mean(t1)
%%%%ans = 1.1730e-04
%%%mean(t)/mean(t1) = 287.1832 ����287��������