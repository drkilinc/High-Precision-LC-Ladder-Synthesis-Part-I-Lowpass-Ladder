function [RGen,XGen]=Gen(w,RG,KFlag)
% This function generates the impedance data 
%    for a given RG+L//C impedance
% Inputs:
%       w,RG,KFlag
% Compute the Generator impedance RG+Lres//Cres
%Resonance circuit:
% CG =1.515761362779956e-012 (Actual)
% LG =9.473508517374721e-010 (Actual) 
Cx=5.029;
wrL=2; CG=1; LG=1/wrL/wrL/CG;%(Normalized)
    p=sqrt(-1)*w;
    Yres=p*CG+1/p/LG;% Admittance of the Lres//Cres
    Zres=1/Yres;
   ZGen=RG+Zres+1/p/Cx;
   %ZGen=RG+Zres;
    YGen=1/ZGen;
    
      if KFlag==1;% Work with impedances
        RGen=real(ZGen);
        XGen=imag(ZGen);
      end
        if KFlag==0;%Work with admittances
            RGen=real(YGen);
            XGen=imag(YGen);
        end
     
end