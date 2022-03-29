function f=Eig(i,j,T)
format short
global M2 M3 R SpType

f=M3(SpType(1,i),SpType(1,j))*exp(-M2(SpType(1,i),SpType(1,j))*4.18/R/(T+273.15));%conversion factor for cal to joule 

end
        

