function f=S(i,j,T)
%function for dummy (&=2*Bij-Bjj-Bii)
f=2*Bij(i,j,T)-Bij(j,j,T)-Bij(i,i,T);
end