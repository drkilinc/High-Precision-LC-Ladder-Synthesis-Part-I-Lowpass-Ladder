% Main Program: YarmanKilinc_Example3.m
clear;clc;close all
% Example 3:
% Given Exact Lowpass LC Ladder form for Z1(p)=a1(p)/b1(p)
%                                       as obtained in Example 2;
a1 =[ 0  0.2757805489624476  0.1052148500539130  0.1183215956619923]
b1 =[ 1  0.3815165734122888  0.7391774478941271  0.1183215956619923]

% Generated Even Part R(p)=A2(p)/B2(p)from Z1(p) and observe the numercai
% precison in R(p):
%Data given for Example2
A1=[0 0 0 0.0140];% Exact Lowpass Ladder form of the numerator of R(p)
B1=[-1 -1.3328 -0.4561 0.0140]; % Denominator of R(p)

% Generate even part of Z1(p);
format long e
[A2,B2]=even_part(a1,b1)