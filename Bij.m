function f=Bij(i,j,T)
global M1 SpType
%function to calculate Bij by eqns 11.69-11.74
Tcij=(M1(SpType(1,i),6)*M1(SpType(1,j),6))^0.5;
Tr=(T+273.15) / Tcij;
wij=(M1(SpType(1,i),8)+M1(SpType(1,j),8))/2;
B0=0.083-(0.422/(Tr^1.6));
B1=0.139-0.172/(Tr^4.2);
Bhatije=B0+wij*B1;
Zcij=(M1(SpType(1,i),7)+M1(SpType(1,j),7))/2;
Vcij=((M1(SpType(1,i),5)^(1/3)+M1(SpType(1,j),5)^(1/3))/2)^3;
f=Bhatije*Vcij/Zcij;
end