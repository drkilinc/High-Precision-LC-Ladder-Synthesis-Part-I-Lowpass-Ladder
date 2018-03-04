function Sin=inputref_EL(KFlag,eta,RL,XL,RB,XB)
ZL=complex(RL,XL);
ZB=complex(RB,XB);
ZBC=conj(ZB);
S=(ZL-ZBC)/(ZL+ZB);
Sin=eta*S;
if KFlag==0
    Sin=-Sin;
end