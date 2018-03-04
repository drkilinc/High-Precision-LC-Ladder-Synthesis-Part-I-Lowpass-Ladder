% Main: YarmanKilinc_Example6.m
% Double Matching via RFDCT Parametric Approach
% February 11, 2012, Vanikoy, Istanbul.
% This program determines the driving point input immitance ZB(p)=a(p)/b(p)from the back-end:
% Generator immitance is computed using function [RGen,XGen]=Gen(w,RG,KFlag)
% Load immitance is computed using function [RL,XL]=Load(w,RLoad,KFlag)
%--------------------------------------------------------------------------
%
% Design of impedance transforming filter from fc1=850 MHz to fc2=2100 MHz
% For the case under consideration: 
%                   RG=12ohm+LG//CG+Cx
% where Normalized Value of CG=1 or CG=1.515761362779956e-012 (Actual)
% LG=1/wres/wres/CG LG=9.473508517374721e-010 (Actual)
%                   Cx=7.6228e-012 (Actual) or Cx=5.029 (Normalized)
% Resonance frequency frG=4200 MHz (Normalized wrG=2)
%                   RL=50ohm+LL//CL
% where Normalized Value of CL=1 or CL=1.515761362779956e-012 (Actual)
% LL=1/wres/wres/CL LL=4.210448229944320e-010 (Actual)
% Resonance frequency frG=6300 MHz (Normalized wrL=3)
%
% Inputs:
%           x0: Initialized unknowns
%           T0: Flat gain level
%           wc1: Beginning of optimization
%           wc2: End of optimization
%           KFlag: =1>Work with impedance functions
%           KFlag: =0>Work with admittance functions
%           ntr:=1> work with transformer
%           ntr:=0> work without transformer. For sure you have LC Low pass
%           structure for the equalizer.
%           ndc: Zero of transmissions at DC
%           W: Zero of transmissions at finite frequencies. It is usually
%           zero.
%           a0: Initial for R(w)=a0*a0*W/B(w^2)
%           
clc
clear
close all
Program='Main_RFDCT.m';

%
fs1=0; fs2=7e9;		fc1=850e6; fc2=2100e6;
ws1=fs1/fc2; ws2=fs2/fc2;	wc1=fc1/fc2; wc2=fc2/fc2;
RGEN=12/50; RLoad=1;T0=1;
KFlag=1;ndc=0;W=0;ntr=0;a0=1;W=0;
%
format short
c0=[-4.638 -8.04165 19.01759 26.4176 -6.1324 -8.2095];
Koptimization=1;
%disp('Enter optimization Method (1 -> minimax, 0 -> least square):=');
%input(Koptimization);
%--------------------------------------------------------------------------
for i=1:5
	[ c ] = nonlinear_optimization( c0,wc1,wc2,T0,KFlag,W,ndc,a0,ntr,Koptimization,RGEN,RLoad );
	c0=c;
end
% Generate analytic form of Fmin(p)=a(p)/b(p)
[a,b]=Minimum_Function(ndc,W,a0,c)

% Compute Double Matching Gain and plot the results:
% Step 6: Print and Plot results
Nprint=1001;
DW=(ws2-ws1)/(Nprint-1);
w=ws1;
Tmax=-1000;
Tmin=0;
RGEN=12/50; RLoad=1;
for j=1:Nprint
	WA(j)=w;
	[RG,XG]=Gen(w,RGEN,KFlag);
	[RL,XL]=Load(w,RLoad,KFlag);
	[ T_Double ] = Gain_DoubleMatching( w,a,b,ndc,KFlag,RG,XG,RL,XL );
	TA(j)=10*log10(T_Double);
	%
	% Compute the performance parameters:Tmax,Tmin,Tave and detT
	if max(TA(j))>Tmax
		wmax=WA(j);Tmax=TA(j);
	end
	if w>=wc1
		if w<=wc2
			if min(TA(j))<Tmin
				wmin=WA(j);Tmin=TA(j);
			end
		end
	end
	w=w+DW;
end
%
figure
fA=WA*fc2;
plot(fA,TA);
title('Double Matching Via RFDT')
xlabel('Actual Frequency (GHz)')
ylabel('Double Matching Gain in dB')
legend('RFDCT Gain')
ax=axis();
%
f0=2100e6;R0=50;
[CT,CV] = CircuitPlot_Yarman(KFlag,R0,f0,a,b,ndc);
Plot_Circuitv1(CT,CV)

% Print Performance parameters:
wmax, Tmax,
wmin, Tmin,
T_Average=(Tmax+Tmin)/2
delT=T_Average-Tmin
DrawLCLadder_withGenLoad(KFlag,ndc,a,b,R0,f0)

% Compute the errors accumulated during the synthesis proccess
q=LowpassLadder_Yarman(a,b);
[a2,b2]=ExactLowpassLadder(q)
eps_a=norm(a-a2)
eps_b=norm(b-b2)
%
N=251;fs1=0;fs2=7e9;
df=(fs2-fs1)/(N-1);
f=0;RG=13; fA=zeros(1,N); TdB_Cir=zeros(1,N);
for i=1:N
	[ Gain,Rin,Xin ] = Example6_Topology( f,RG );
	fA(i)=f;
	TdB_Cir(i)=10*log10(Gain);
	f=f+df;
end

figure
plot(fA,TdB_Cir)
xlabel('Actual Frequency f')
ylabel('Gain ib dB from Circuit Toplogy')
title('Double Matching Gain computed from the circuit topology')
axis(ax);
