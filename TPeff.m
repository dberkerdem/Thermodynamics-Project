function [y1,CompMatrix]=TPeff(CaseNo,n)

T=zeros(1,3);
P=zeros(1,3);

if CaseNo==1 || CaseNo==2  
disp('Please Enter the Temperatures for Temperature Pressure effect');
for i=1:1:3
T(1,i)=input(num2str(i,'Temperature %.f(Celcius)='));
end
y1=T;
elseif CaseNo==3 || CaseNo==4 || CaseNo==5
disp('Please Enter the Pressures for Temperature Pressure effect');
for i=1:1:3
P(1,i)=input(num2str(i,'Pressure %.f(kPa)='));
end
y1=P;
end

CompMatrix=zeros(1,n);
for i=1:1:(n-1)
CompMatrix(1,i)=input(num2str(i,'fraction of species %.f ='));
end
CompMatrix(1,n)=1-sum(CompMatrix);
end