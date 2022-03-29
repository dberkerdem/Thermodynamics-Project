function f=ActivCoef(i,xComp,T)%input temp must be in celcius
format short
global n 
%xComp is a matrix for x values of system which has dimension (1,n)
A=zeros(1,n);
End=0;
for j=1:1:n %to find middle part of equation 12.23
    A(1,j)=Eig(i,j,T);
end
Mid=A*transpose(xComp);
for k=1:1:n % big loop for Last part
    A=zeros(1,n);
for j=1:1:n %small loop for sum in denominator
    A(1,j)=Eig(k,j,T);
end
Down=A*transpose(xComp);
Up=Eig(k,i,T)*xComp(1,k);
End=End+Up/Down;%sum for last part of equation
end 
f=exp(1-log(Mid)-End); % eqn 12.23 

end