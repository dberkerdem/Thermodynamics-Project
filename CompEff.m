function [y1,CompMatrix]=CompEff(CaseNo,n)

if CaseNo==1 || CaseNo==2  
disp('Please Enter the Temperature for Composition');
T=input('Temperature(Celcius)= ');
y1=T;
elseif CaseNo==3 || CaseNo==4 || CaseNo==5
disp('Please Enter the Pressures for Temperature Pressure effect');
P=input('Pressure(kPa)= ');
y1=P;
end

CompMatrix=zeros(3,n);
count=1;
while(count~=4)
summ=0;
disp(num2str(count,'For Row %.f'));
for i=1:1:(n-1)
CompMatrix(count,i)=input(num2str(i,'fraction of species %.f = '));
end
for j=1:1:(n-1)
summ=summ+CompMatrix(count,j);
end
CompMatrix(count,n)=1-summ;
count=count+1;
end
end