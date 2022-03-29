function f=DewT(yComp,P)
global n Law
PhiDewT=ones(1,n);
ActCoDewT=ones(1,n);
TsatDewT=zeros(1,n);
PsatDewT=zeros(1,n);
xCompDewT=zeros(1,n);
ToldDewT=0;
ActCoDewTold=0;
for i=1:1:n
    TsatDewT(1,i)=TiSat(i,P);
end
T=TsatDewT*transpose(yComp);
for i=1:1:n
    PsatDewT(1,i)=PiSat(i,T);
end
j=2;
PjSat=PsatDewT(1,j);
Hold=0;
for i=1:1:n
    Hold=Hold+yComp(1,i)*PhiDewT(1,i)*PjSat/ActCoDewT(1,i)/PsatDewT(1,i);
end
PjSat=P*Hold;
T=TiSat(j,PjSat);
for i=1:1:n
    PsatDewT(1,i)=PiSat(i,T);
    if Law==3
        PhiDewT(1,i)=Phi(i,yComp,T,P);
    end
end
for i=1:1:n
    xCompDewT(1,i)=yComp(1,i)*PhiDewT(1,i)*P/ActCoDewT(1,i)/PsatDewT(1,i);
end
if Law==2 || Law==3
    for i=1:1:n
        ActCoDewT(1,i)=ActivCoef(i,xCompDewT,T);
    end
end
Hold=0;
for i=1:1:n
    Hold=Hold+yComp(1,i)*PhiDewT(1,i)*PjSat/ActCoDewT(1,i)/PsatDewT(1,i);
end
PjSat=P*Hold;
T=TiSat(j,PjSat);
while( abs((T-ToldDewT))/T >0.00001)
    ToldDewT=T;
    for i=1:1:n
        PsatDewT(1,i)=PiSat(i,T);
        if Law==3
            PhiDewT(1,i)=Phi(i,yComp,T,P);
        end
    end
    while( abs((ActCoDewT(1,1)-ActCoDewTold))/ActCoDewTold >0.00001)
        ActCoDewTold=ActCoDewT(1,1);
        for i=1:1:n
            xCompDewT(1,i)=yComp(1,i)*PhiDewT(1,i)*P/ActCoDewT(1,i)/PsatDewT(1,i);
        end
            xCompDewT=normalize(xCompDewT,'norm',1);%Normalizing x values by using infinity norm
        if Law==2 || Law==3
            for i=1:1:n
                ActCoDewT(1,i)=ActivCoef(i,xCompDewT,T);
            end
        end
    end
    Hold=0;
    for i=1:1:n
        Hold=Hold+yComp(1,i)*PhiDewT(1,i)*PjSat/ActCoDewT(1,i)/PsatDewT(1,i);
    end
PjSat=P*Hold;
T=TiSat(j,PjSat);
end
f=T;
end
