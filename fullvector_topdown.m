function B=fullvector_topdown(n,A)
% This function generates a full size vector for given size length "n"
% Inputs: 
%           Vector A with size na
%           n: New size of the vector
%
% Output:
%           B: New vector with size n which includes A
%           B=[0 0 ..0, A(1), A(2), ..., A(na)] of size "n"
na=length(A);
for i=1:na
    B(i)=A(i);
end
for i=1:(n-na)
        B(na+i)=0;
end
