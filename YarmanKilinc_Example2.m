% Main Program: YarmanKilinc_Example2.m
clear;clc;close all
% Given R(p)=A(p)/B(p);
A1=[0 0 0 0.0140];% Exact Lowpass Ladder form of the numerator of R(p)
B1=[-1 -1.3328 -0.4561 0.0140]; % Denominator of R(p)

a=[0 0.2755 0.1051 0.1182]; % Given for Example 1
b=[1 0.3810 0.7390 0.1182];% Given for Example 1

% Find even part R(p)=A(p)/B(p)of Z(p)as an even-rational function:
format long e
[p,k]=residues_evenpart(A1,B1)
[a1,b1]=evenpartTo_MinFunc(A1,B1)
eps_a=norm(a-a1)
eps_b=norm(b-b1)
