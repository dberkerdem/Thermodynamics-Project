function f=PiSat(i,T)
global M1 SpType

A=M1(SpType(1,i),1);
B=M1(SpType(1,i),2);
C=M1(SpType(1,i),3);
f=exp(A-B/(T+C));%kPa,Antonie Eqn,T is in Celcius

end