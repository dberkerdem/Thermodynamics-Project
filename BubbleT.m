function f=BubbleT(xComp,P)
global n Law
PhiBubT=ones(1,n);
TsatBubT=zeros(1,n);
PsatBubT=zeros(1,n);
ActCoBubT=ones(1,n);
yCompBubT=zeros(1,n);
ToldBubT=0;
for i=1:1:n
   TsatBubT(1,i)= TiSat(i,P);    
end
T=TsatBubT*transpose(xComp);
for i=1:1:n
   PsatBubT(1,i)= PiSat(i,T);
end 
if Law ==2 || Law==3
    for i=1:1:n
        ActCoBubT(1,i)=ActivCoef(i,xComp,T);
    end
end
j=2;
PjSat=PsatBubT(1,j);%j is 2nd species
Denom=0;
for i=1:1:n
    Denom=Denom+(xComp(1,i)*ActCoBubT(1,i)/PhiBubT(1,i)*PsatBubT(1,i)/PjSat);         
end
PjSat=P*(Denom^-1);
T=TiSat(j,PjSat);

while( abs((T-ToldBubT))/T >0.00001)%an iterion to convergence on final values for P
        ToldBubT=T;
        for i=1:1:n
            PsatBubT(1,i)= PiSat(i,T);
        end
        for i=1:1:n
            yCompBubT(1,i)=xComp(1,i)*ActCoBubT(1,i)*PsatBubT(1,i)/PhiBubT(1,i)/P;
        end
        if Law==2 || Law==3
            for i=1:1:n
                if Law==3
                    PhiBubT(1,i)=Phi(i,yCompBubT,T,P);
                end
                ActCoBubT(1,i)=ActivCoef(i,xComp,T);
            end
        end
        Denom=0;
        for i=1:1:n
            Denom=Denom+(xComp(1,i)*ActCoBubT(1,i)/PhiBubT(1,i)*PsatBubT(1,i)/PjSat);  
        end
        PjSat=P*(Denom^-1);
        T=TiSat(j,PjSat);
end
f=T;
end
               
      
    
    
    