% Main Program: YarmanKilinc_Example5.m
clear;clc;close all
% Given F(p)=a(p)/b(p) generate Exact Lowpass LC Ladder function
% F(p)=a(p)/b(p) via parametric approach.
% Inputs:
a1=1.0e+003*[0.00000 0.000243570982330 0.005942391196503 0.048441163672809 0.223771800321183 0.703166932444413 1.647563920173623 3.038406878823534];
a2=1.0e+003*[4.561480281228956 5.691843698397583 5.973794366516633 5.301481077928296 3.977617930832275 2.509345559081507 1.315779401254989];
a3=1.0e+003*[0.562150827666278 0.189558067896765 0.048032011167119 0.008431529662418 0.000827704427793];
a=[a1,a2,a3];
b1= 1.0e+004 *[0.0001 0.002439695870029    0.019914726153765 0.092525662299536 0.294017502515733 0.700877094923677 1.323370333662979];
b2=1e4*[2.047310741949944 2.650311854053223 2.907173323250695 2.719656869566401 2.173275287536554 1.479042415464306 0.850450799464403];
b3=1e4*[0.407297891494083 0.158774880981138 0.048562164264357 0.010905748934925 0.001542112526945 0.000082770442779];
b=[b1,b2,b3];
eps_zero=1e-8;% Threshold for Algorithmic zero
% Step 1: Generate Exact Lowpass LC Ladder Function F(p)=a(p)/b(p)
sa=a;sb=b;% Save the original form of a(p) and b(p)

[aa,bb,ndc]=Check_immitance(a,b);
% Check even part if it belongs to a ladder network.
% Part (a)
[A,B]=even_part(aa,bb)
% End of Part (a)
% Step 2:Remove poles at infinity which in turn yields the residues q(i)
% Part (b)
nplus1=length(b);n=nplus1-1;
%
for i=1:n-1
    [Q,a1,b1,ndc]=ExtractTrZero_infinity(eps_zero,a,b);
    q(i)=Q;
    clear a;clear b
    a=a1;b=b1;
end
% Now, we have least degree F1(p)=b1(p)/a1(p)
% Compute the last residue q(n)
q(n)=b1(1)/a1(2);
% Compute terminating constant q(n+1)
q(n+1)=b1(2)/a1(2)
% End of Part (b)
% Check the result
% Part (c): Generate the driving point input impedance from the topology.
[a2,b2]=ExactLowpassLadder(q);
eps_a=norm(sa-a2)
eps_b=norm(sb-b2)
% End of Part (c)
