function [CT,CV] = CircuitPlot_Yarman(KFlag,R0,f0,a,b,ndc)
% This function generates the circuit code vector for a given Component matrix
% CVal(i,j) describes the rows and columns of CVal in actual element values
% -------------------------------------------------------------------------
% Series Capacitors(CHP)    Shunt Inductors(LHP)      Shunt Capacitors(CLP)    Series Inductors(LLP)        Termination
% -------------------------------------------------------------------------
% j=1> First Column of CVal gives the the series capacitors C_HP; CT=2
% j=2> Second Column of CVal gives the shunt inductors L_HP; CT=7
% j=3> Third Column of CVal(:;3) gives the shunt capacitors C_LP; CT=8
% j=4> Fourth Column of CVal(:;4) gives the series inductors L_LP; CT=1
% j=5> First Row (i=1) and Fitfh Column (j=5) gives the termination Ter=9
% -------------------------------------------------------------------------
if KFlag==1;[CT,CV] = SynthesisMinimumReactance_Yarman(R0,f0,a,b,ndc);end
if KFlag==0;[CT,CV] = SynthesisMinimumSuseptance_Yarman(R0,f0,a,b,ndc);end    
    
end

