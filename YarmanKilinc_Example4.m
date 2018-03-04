% Main Program YarmanKilinc_Example4.m
clear;clc;close all
% Given F(p)=a(p)/b(p) generate Exact Lowpass LC
% Ladder function
% F(p)=a(p)/b(p) via parametric approach.
%
% Inputs:
% a=[0 0.2755 0.1051 0.1182]; % Given by Example 1
% b=[1 0.3816 0.7390 0.1182]; % Given by Example 1

% Inputs Corrected according to Low Pass Topology
%a=[0 0.275685028606870 0.105258913364013 0.118321595661992];
%b=[1 0.381808594742783 0.739088901509729 0.118321595661992];
a =[ 0  0.2757805489624476  0.1052148500539130  0.1183215956619923]
b =[ 1  0.3815165734122888  0.7391774478941271  0.1183215956619923]

eps_zero=1e-8;% Threshold for Algorithmic zero
aa=a;bb=b;% Save the original form of a(p) and b(p)

% Step 1: Generate Exact Lowpass LC Ladder Function F(p)=a(p)/b(p)
[a,b,ndc]=Check_immitance(a,b);
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
[a2,b2]=ExactLowpassLadder(q)
eps_a=norm(aa-a2)
eps_b=norm(bb-b2)

% draw circuit schematic
CT=[8 1 8 9];CV=q;
Plot_Circuitv1(CT,CV,{},0.01)

