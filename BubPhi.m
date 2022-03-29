function f=BubPhi(xComp,T)
global n
%A function to calculate desired Bubble pressure by given x values and Temperature
P=100;%kPa,An initial value for Pressure in order to enter while loop
PoldBubP=0;%An initial values for Pressure in order to enter the while loop
PhiBubP=ones(1,n);
PsatBubP=zeros(1,n);%A matrix to hold Saturation Pressure values of species
ActCoBubP=zeros(1,n);%A matrix to hold Activity Coefficient values of species
yCompBubP=zeros(1,n);%A matrix to hold calculated y values
for i=1:1:n %a loop to calculate Activity coefficients and Saturation pressures of species by given x and Temp values
    PsatBubP(1,i)=PiSat(i,T);
    ActCoBubP(1,i)=ActivCoef(i,xComp,T);
end
while( abs((P-PoldBubP))/P >0.00001)%an iterion to convergence on final values for P
    PoldBubP=P;
    P=0;
    for i=1:1:n %To find P from eqn 14.10
       P=P+xComp(1,i)*ActCoBubP(1,i)*PsatBubP(1,i)/PhiBubP(1,i);%kPa
    end
    for i=1:1:n %To find y values from eqn 14.8
       yCompBubP(1,i)=xComp(1,i)*ActCoBubP(1,i)*PsatBubP(1,i)/PhiBubP(1,i)/P;
    end
    for i=1:1:n %To find Phi values from eqn14.6
        PhiBubP(1,i)=Phi(i,yCompBubP,T,P);
    end
end
f=yCompBubP;%Final values of P
end