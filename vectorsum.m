function C=vectorsum(A,B)
% This function adds two vector A and B of different sizes
na=length(A);
nb=length(B);
if na>nb
    B=fullvector(na,B);
    C=A+B;
end
if nb>na
    A=fullvector(nb,A);
    C=A+B
end
if na==nb
    C=A+B;
end
end
