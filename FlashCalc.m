function f=FlashCalc(zComp,P)
global n Law
yComp=zComp;%initally setting y compositions to given z comp
xComp=zComp;%initally setting x compositions to given z comp
FCBubbleT=BubbleT(xComp,P);%Bubble Temperature calculation with given P and initial x values
FCDewT=DewT(yComp,P);%Dew Temperature calculation with given P and initial y values
T=(FCBubbleT+FCDewT)/2;%initial temperature calculation with calculated DewT and BubleT
FCDewP=DewP(yComp,T);%DewP calculation with calculated T and initial y values
FCBubbleP=BubbleP(xComp,T);%BubbleP calculation with calculated T and initial x values
Const=(P-FCDewP)/(FCBubbleP-FCDewP);%Right Side of famous eqn at page 553
PhiFC=ones(1,n);%initially setting all phi values to 1
ActCoFC=ones(1,n);%initially setting all activ coef values to 1
K=zeros(1,n);%initially setting all vle ratios to 0
PsatFC=zeros(1,n);%initially setting all saturation pressure values to 0
[PhiDew,ActCoDew]=DewPFlash(yComp,T);%Calculating all Phi and Activity coefficients of the system at dew pressure by calculated temperature and initial y values
[PhiBub,ActCoBub]=BubblePFlash(xComp,T);%Calculating all Phi and Activity coefficients of the system at bubble pressure by using calculated temperature and initial x values
for i=1:1:n % a loop to calculate saturation pressure  
    PsatFC(1,i)=PiSat(i,T);%Antonie Equation
    ActCoFC(1,i)=Const*(ActCoBub(1,i)-ActCoDew(1,i))+ActCoDew(1,i);%activity coef values from eqn at page 553
    PhiFC(1,i)=Const*(PhiBub(1,i)-PhiDew(1,i))+PhiDew(1,i);%phi values from eqn at page 553
end
V=-Const+1;
Vold=0;%in order to start while loop initial values to calculate error set 0
yCompOld=0;%in order to start while loop initial values to calculate error set 0
xCompOld=0;%in order to start while loop initial values to calculate error set 0
while(abs((V-Vold))/V >0.001 || abs((xComp(1,1)-xCompOld))/xComp(1,1) >0.001 || abs((yComp(1,1)-yCompOld))/yComp(1,1) >0.001)%iteration loop for Flash Calculations
    xCompOld=xComp(1,1);
    yCompOld=yComp(1,1);
    Vold=V;
    F=0;
    dFdV=0;
    for i=1:1:n
        K(1,i)=ActCoFC(1,i)*PsatFC(1,i)/PhiFC(1,i)/P;
    end
    for i=1:1:n
        F=F+zComp(1,i)*(K(1,i)-1)/(1+V*(K(1,i)-1));
        dFdV=dFdV+zComp(1,i)*(K(1,i)-1)*(K(1,i)-1)/(1+V*(K(1,i)-1))/(1+V*(K(1,i)-1));
    end
    dFdV=-dFdV;
    DeltaV=-F/(dFdV);
    V=DeltaV+V;
    for i=1:1:n
        xComp(1,i)=zComp(1,i)/(1+V*(K(1,i)-1));
        yComp(1,i)=xComp(1,i)*K(1,i);
    end
    if Law==2 || Law==3
        for i=1:1:n
            ActCoFC(1,i)=ActivCoef(i,xComp,T);
            if Law==3
                PhiFC(1,i)=Phi(i,yComp,T,P);
            end
        end
    end
end
f=V;
end
