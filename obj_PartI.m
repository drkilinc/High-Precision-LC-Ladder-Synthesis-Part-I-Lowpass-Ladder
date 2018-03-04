   function error=obj_PartI(x0,T0,wc1,wc2,KFlag,ntr,ndc,W,a0,RGEN,RLoad)
% Optimization via Direct - Parametric approach
% error: Error function - Output
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

%nd=length(T0);%by RK

if ntr==1; %Yes transformer case
    Nx=length(x0);
        for i=1:Nx-1; 
            c(i)=x0(i);
        end;
        a0=x0(Nx);
end
if ntr==0;% No Transformer case
    Nx=length(x0);
    for i=1:Nx; 
        c(i)=x0(i);
    end;
end
%
% Step 5: Generate analytic form of Fmin(p)=a(p)/b(p)
% Generate B(-p^2)
        C=[c 1];
        BB=Poly_Positive(C);% This positive polynomial is in w-domain
        B=polarity(BB);% Now, it is transferred to p-domain        
% Generate A(-p^2) of R(-p^2)=A(-p^2)/B(-p^2)
nB=length(B);
        A=(a0*a0)*R_Num(ndc,W);% A is specified in p-domain
nA=length(A);
if (abs(nB-nA)>0)
    A=fullvector(nB,A);
% Note that function RtoZ requires same length vectors A and B
end     
        [a,b]=RtoZ(A,B);% Here A and B are specified in p-domain
% 

       N_opt=51;
       %N_opt=nd;%by RK
        w=wc1;
       del=(wc2-wc1)/(N_opt-1);
       cmplx=sqrt(-1);
%
       for j=1:N_opt
           p=cmplx*w;
           %
           [RG,XG]=Gen(w,RGEN,KFlag);
           [RL,XL]=Load(w,RLoad,KFlag);
           %
           aval=polyval(a,p);
           bval=polyval(b,p);
           bval_conj=conj(bval);
        %
           eta=(-1)^ndc*bval_conj/bval;
        % 
           ZB=aval/bval;
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
            T_Double(j)=Weight*TEL;%(j) added by RK
           error(j)=abs(T_Double(j)-T0);%(j) added by RK
           w=w+del;
       end

