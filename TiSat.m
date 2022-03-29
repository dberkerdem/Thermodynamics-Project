function f=TiSat(i,P)
global M1 SpType

A=M1(SpType(1,i),1);
B=M1(SpType(1,i),2);
C=M1(SpType(1,i),3);

f=B/(A-log(P))-C;%Celcius,Antonie Eqn,P is in kPa
end
