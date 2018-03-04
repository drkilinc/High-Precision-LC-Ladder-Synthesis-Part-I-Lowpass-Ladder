% Main Program: YarmanKilinc_Example1.m
clear;clc;close all
% Given Z(p)=a(p)/b(p)
%Z(p)=(0p^3+0.2755p^2+0.1051p+0.1182)/(1p^3+0.3816p^2+0.7390p+0.1182)
% Given a(p) and b(p)
a=[0 0.2755 0.1051 0.1182]
b=[1 0.3810  0.7390 0.1182]
% Find even part R(p)=A(p)/B(p)of Z(p)as an even-rational function:
%format long e
[A,B]=even_part(a,b)
