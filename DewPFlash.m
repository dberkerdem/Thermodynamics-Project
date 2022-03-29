function [PhiDew,ActCoDew]=DewPFlash(yComp,T)
global n Law
ActCoDewP=ones(1,n);%initial Activity coefficient values of system set 1
PhiDewP=ones(1,n);%initial Phi values of system set 1
PsatDewP=zeros(1,n);%A matrix to hold Saturation Pressure values of species
xCompDewP=zeros(1,n);%A matrix to hold calculated x values
Pbot=0;%An initial value in order to make easy calculation for Pressure
PoldDewP=0;%An initial values for Pressure in order to enter the while loop
ActCoOld=0;%An initial value for Activity Coef in order to enter while loop
for i=1:1:n %a loop to calculate Activity coefficients and Saturation pressures of species by given x and Temp values
    PsatDewP(1,i)=PiSat(i,T);
end
for i=1:1:n %a loop to calculate Pressure from calculated Saturation pressure,given y values and other initial datas eqn 14.11
    Pbot=Pbot+(yComp(1,i)*PhiDewP(1,i)/ActCoDewP(1,i)/PsatDewP(1,i));%Pbot is the denominator of eqn 14.11
end
P=Pbot^-1;%Eqn 14.11
for i=1:1:n %a loop to calculate x values from eqn 14.9
    xCompDewP(1,i)=yComp(1,i)*PhiDewP(1,i)*P/ActCoDewP(1,i)/PsatDewP(1,i);
end
xCompDewP=normalize(xCompDewP,'norm',1);%Normalizing x values by using infinity norm
if Law==2 || Law==3
    for i=1:1:n %a loop to calculate Activity coef values from calculated x values
        ActCoDewP(1,i)=ActivCoef(i,xCompDewP,T);
    end
end
P=0;%set value of pressure to 0 in order to make new pressure calculations
for i=1:1:n %a loop to calculate Pressure from calculated Saturation pressure activity coefficient,given y values and other initial datas eqn 14.11
    P=P+1/(yComp(1,i)*PhiDewP(1,i)/ActCoDewP(1,i)/PsatDewP(1,i));
end
while(abs((P-PoldDewP))/PoldDewP >0.0001)%an iterion to convergence on final values for P
    PoldDewP=P;
    if Law==3
        for i=1:1:n
            PhiDewP(1,i)=Phi(i,yComp,T,P);
        end
    end
    while(abs((ActCoDewP(1,1)-ActCoOld))/ActCoOld >0.0001)%an iterion to convergence on final values for Acivity Coefficients
        ActCoOld=ActCoDewP(1,1);
        for i=1:1:n %a loop to calculate x values from eqn 14.9
            xCompDewP(1,i)=yComp(1,i)*PhiDewP(1,i)*P/ActCoDewP(1,i)/PsatDewP(1,i);
        end
        xCompDewP=normalize(xCompDewP,'norm',1);%Normalizing x values by using infinity norm
        if Law==2 || Law==3
            for i=1:1:n %a loop to calculate Activity coef values from calculated x values
                ActCoDewP(1,i)=ActivCoef(i,xCompDewP,T);
            end
        end
    end
    Pbot=0;
    for i=1:1:n %a loop to calculate Pressure from calculated Saturation pressure activity coefficient,given y values and other initial datas eqn 14.11
    Pbot=Pbot+(yComp(1,i)*PhiDewP(1,i)/ActCoDewP(1,i)/PsatDewP(1,i));%Pbot is the denominator of eqn 14.11
    end
    P=Pbot^-1;%Eqn 14.11
end
PhiDew=PhiDewP;
ActCoDew=ActCoDewP;
end