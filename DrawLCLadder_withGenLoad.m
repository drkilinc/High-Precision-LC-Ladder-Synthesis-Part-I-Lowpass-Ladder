function DrawLCLadder_withGenLoad(KFlag,ndc,a,b,R0,f0)
% This function draws the matching network with generator and load models
% CT=3> Series resistor which may be on the generator side
% CT=4> Inductor L in L//C in series configuration
% CT=5> Capacitor C in L//C in series configuration
% CT=2> Series Capacitor
% CT=7> Shunt inductor L
% CT=8> Shunt capacitor C
% CT=1> Series inductor L
% CT=9> Final terminating resistor R of the ladder in shunt configuration
%
% Synthesis with normalized elements:
RN=1;fN=1/2/pi;KFlag=1;R0=50;f0=2100e6;ndc=0
[CTN,CVN] = CircuitPlot_Yarman(KFlag,RN,fN,a,b,ndc);% Normalized Circuit
Plot_Circuitv1(CTN,CVN);
% -------------------------------------------------------------------------
% Synthesis with actual elements:
[CTA,CVA] = CircuitPlot_Yarman(KFlag,R0,f0,a,b,ndc);% Actual Circuit
Plot_Circuitv1(CTA,CVA);
%--------------------------------------------------------------------------
CT_Gen=[3 4 5 2];CV_Gen=[12 9.473508517374721e-010 1.515761362779956e-012 7.622763893420397e-012];
CT_Load=[4 5 9]; CV_Load=[4.210448229944320e-010 1.515761362779956e-012 50];
[CT,CV] = CircuitPlot_Yarman(KFlag,R0,f0,a,b,ndc);% Actual Elements
n_CT=length(CT); %for i=1:(n_CT-1);CTa(i)=CT(i);CVa(i)=CV(i);end
CTa=fliplr(CT(1:end-1));CVa=fliplr(CV(1:end-1));
Plot_Circuitv1([CT_Gen CTa CT_Load],[CV_Gen CVa CV_Load])


end

