function k=even_odd(n) 
% This function determines if an integer n is even or odd.
% if k=1 then, n is odd
% if k=0 then, n is even
n1=n/2;
n2=fix(n1);
delta=n1-n2;
k=1;
if(delta==0)k=0;
end
end
