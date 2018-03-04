function [p,k]=residues_evenpart(A,B)
% This function computes the residues k(j) of a given even part R(p^2)
% R(p^2)=A(p^2)/B(p^2)
% Inputs:
% ------- A(p^2); full coefficient numerator polynomial
% ------- B(p^2); full coefficient denominator polynomial
% Step 1: Find the LHP poles of R(p^2)
x=roots(B);
p=-sqrt(x);
% Step 2:Compute the product terms
prd=product(p);
n=length(p);
% Step 3: Generate residues
for j=1:n
    y=p(j)*p(j);
    Aval=polyval(A,y);
    k(j)=(-1)^n*Aval/p(j)/B(1)/prd(j);
end 
end