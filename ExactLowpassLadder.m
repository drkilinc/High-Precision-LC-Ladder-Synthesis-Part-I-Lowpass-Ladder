function [a,b,A,B]=ExactLowpassLadder(q)
% This function generates the rational for of an exact lowpass LC ladder
% function from the given element values q(i); i=1,n
nplus1=length(q);
n=nplus1-1;
p=[1 0];% Simple polynomial in p
% Initialize auxilary polynomials A(p) and B(p)
A=vectorsum(q(n)*p,q(n+1));
B=1;
kplus1=even_odd(nplus1);
if kplus1==0;%nplus1=even Case--------|
 for i=1:n-1%                         |
    k=even_odd(i);%                   |
    if k==1; % k is odd case          |
        C=conv(q(n-i)*p,A);%          |
        B=vectorsum(C,B);%            |
    end%                              |
    if k==0; % k is even case         |
        C=conv(q(n-i)*p,B);%          |
        A=vectorsum(C,A);%            |
    end%                              |
A1=A(1);b=A/A1;%                      |
a=B/A1;a=[0 a];%                      |
 end%                                 |
end;% end nplus1=even case------------|
if kplus1==1% nplus1=odd case         |
    for i=1:n-1%
            k=even_odd(i);
    if k==1; % k is odd case
        C=conv(q(n-i)*p,A);
        B=vectorsum(C,B);
    end
    if k==0; % k is even case
        C=conv(q(n-i)*p,B);
        A=vectorsum(C,A);
    end
    end
    B1=B(1);
    a=[0 A]/B1;
    b=B/B1;
end
end