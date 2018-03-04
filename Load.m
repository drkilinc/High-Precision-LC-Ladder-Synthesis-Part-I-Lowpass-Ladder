function [RL,XL]=Load(w,RLoad,KFlag)
% This function generates the impedance data for a given R//C load
% Inputs:
%       w,R,KFlag
% Generate the load impedance 
p=sqrt(-1)*w;
wrL=3; CL=1; LL=1/wrL/wrL/CL;%(Noarmaized element values at the third harmonic)
%Cres_Load =1.515761362779956e-012; Actual element value
% Lres_Load = 4.210448229944320e-010; Actual Element values
    Yres=p*CL+1/p/LL;
    Zres=1/Yres;
    ZL=RLoad+Zres;
    YL=1/ZL;
      if KFlag==1;% Work with impedances
        RL=real(ZL);
        XL=imag(ZL);
      end
        if KFlag==0;%Work with admittances
            RL=real(YL);
            XL=imag(YL);
        end
       
end