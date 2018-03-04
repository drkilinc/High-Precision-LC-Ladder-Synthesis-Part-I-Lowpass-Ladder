function [ T_Double ] = Gain_DoubleMatching( w,a,b,ndc,KFlag,RG,XG,RL,XL )
% This  function computes the double matching gain
%
cmplx=sqrt(-1);
p=cmplx*w;
aval=polyval(a,p);
           bval=polyval(b,p);
           bval_conj=conj(bval);
        %
           eta=(-1)^ndc*bval_conj/bval;
        % 
           ZB=aval/bval;
        %
           RB=real(ZB); 
           XB=imag(ZB);
         %
           Sin=inputref_EL(KFlag,eta,RL,XL,RB,XB);
         %
            TEL=1-abs(Sin)*abs(Sin);
            ZG=complex(RG,XG);
            G22=(ZG-1)/(ZG+1);
            if KFlag==0
                G22=-G22;
            end
            Weight=(1-abs(G22)*abs(G22))/abs((1-G22*Sin))^2;
            T_Double=Weight*TEL;

end

