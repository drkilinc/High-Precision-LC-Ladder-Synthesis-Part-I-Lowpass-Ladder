% Main Program: YarmanKilinc_Example7.m
% This program synthesizes an impedance tranforming filter betwee 12 ohm
% and 50 ogn over the frequency band of 850 MHz to 2100 MHz
% High Precision LC Ladder Synthesis Part I: Lowpass LC Ladder Synthesis
clc
clear
close all
% Description of the minimum reactance part of the driving point impedance:
% Inputs to  to describe LC Lowpass Ladder
KFlag=1;ndc=0;W=0;a0=1;
R0=1;f0=1/2/pi;
c=6*rand(1,40)
% Generate Minimum Function
[a,b]=Minimum_Function(ndc,W,a0,c);
% High Precision Lowpass LC Ladder Synthesis:
q=LowpassLadder_Yarman(a,b)
%--------------------------------------------------------------------------
% Draw result of synthesis:
[CT,CV] = CircuitPlot_Yarman(KFlag,R0,f0,a,b,ndc);
Plot_Circuitv1(CT,CV)
% Generate the driving point input impedance from the topology.
[a1,b1]=ExactLowpassLadder(q);
% Computer errors
eps_a=norm(a-a1)/norm(a)
eps_b=norm(b-b1)/norm(b)
% End of Part (c)
