function f=Phi(i,yComp,T,P)
global n R 
Up1=Bij(i,i,T)*(P-PiSat(i,T));%First part of the summation at the top of the equation 14.6 
SumPhi=0;
for j=1:1:n %loop of summation for j
    for k=1:1:n %loop of summation for k
        SumPhi=SumPhi+yComp(1,j)*yComp(1,k)*(2*S(j,i,T)-S(j,k,T)); %Second part of the summation at the top of equation 14.6 without multiplying 0.5*P
    end
end
Up2=0.5*P*SumPhi;%Multiplication of SumPhi with 0.5*P 
f=exp((Up1+Up2)/R/(T+273.15)/1000);%1000 is conversion factor, 1/100 for kPa to bar 1/10 for Rydberg constant
end