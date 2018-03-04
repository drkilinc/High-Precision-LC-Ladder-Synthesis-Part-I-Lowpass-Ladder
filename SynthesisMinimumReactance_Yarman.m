function [CT,CV] = SynthesisMinimumReactance_Yarman(R0,f0,a,b,ndc)
% This function generates the circuit codes for CT and the element values CV for a minimum reactance impedance function
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
nb=length(b);% Total number elements with termination 
nL=nb-1-ndc;% Total number of lowpass elements (q)
% Step 1; Generate CVal which is the matrix consist of actual element
% values:
%--------------------------------------------------------------------------
% Case A: Minimum Reactance Design
% 
 KFlag=1; % Minimum Reactance Design start with shunt inductor j=2
             % Start with 1=1, j=2 then go to C(2,1).
             % Notice that here, inductors are odd rows, capacitors are even rows.  
% -------------------------------------------------------------------------
[A,CVal] = LadderSysnthesis_BSYarman( KFlag,R0,f0,ndc,a,b ); 
%
%             Extraction of Actual Highpass Elements
% For inductors use odd values of CT; for capacirors use even values of CT
%--------------------------------------------------------------------------
%j=2;% extraction starts with a shunt inductor; second column of CVal
% Extraction of Highpass Elements
if ndc==1; CT(1)=7; CV(1)=CVal(1,2);% First element is a shunt inductor
    if ndc==nb-1;CT(2)=9;CV(2)=R0*a(1)/b(1);end; % Termination is a resistor
end
if ndc>1
    k=even_odd(ndc); 
  if k==0; % ndc=even case
    for i=1:ndc/2
        CT(2*i-1)=7;% Start with a highpass shunt inductor L_HP
        CV(2*i-1)=CVal(2*i-1,2);% Value of the shunt inductor
        CT(2*i)=2;% Second element is a series capacitor
        CV(2*i)=CVal(2*i,1);% Value of the series capacitor
    end
     if (ndc==nb-1);CT(ndc+1)=9; CV(ndc+1)=R0*a(1)/b(1);end; % Termination is a resistor.
  end
  if k==1; % ndc=odd case
 %    
     for i=1:(ndc-1)/2+1
        CT(2*i-1)=7;% Start with a highpass shunt inductor L_HP
        CV(2*i-1)=CVal(2*i-1,2);% Value of the shunt inductor
        if (2*i)<ndc
        CT(2*i)=2;% Second element is a highpass series capacitor
        CV(2*i)=CVal(2*i,1);% Value of the series capacitor
        end
     end
%
      if ndc==1; CT(1)=7; CV(1)=CVal(1,2);end
 if (ndc==nb-1);CT(ndc+1)=9; CV(ndc+1)=R0*a(1)/b(1);end
  end
end
%
% End of extraction of highpass elements.
% KFlag is still one and ndc is still greater than zero: extraction of lowpass elements
        %j=3;% extraction starts with a shunt capacitor CT=8
        if nL==1;
            CT(ndc+1)=8; CV(ndc+1)=CVal(1,3);% First Lowpass element is a shunt capacitor.
            CT(ndc+2)=9; CV(ndc+2)=CVal(1,5);% Termination is always is given as a resistor.
        end; % Here CV(ndc+2) is a resistor in ohms. 
        if nL>1
            k=even_odd(nL); 
          if k==0; % nL=even case
            for i=1:nL/2
                CT(ndc+2*i-1)=8;% First Lowpass element is a shunt capacitor
                CV(ndc+2*i-1)=CVal(2*i-1,3);% Value of the shunt capacitor
                %
                CT(ndc+2*i)=1; % Code of a series inductor
                CV(ndc+2*i)=CVal(2*i,4);% Value of the series inductor
                
            end
            % Extract of the termination
            CT(ndc+nL+1)=9;R=CVal(1,5);
            CV(ndc+nL+1)=R;% Termination is always given as a resistor in ohms
          end
           if k==1; % nL=odd case
            for i=1:(nL-1)/2+1
                CT(ndc+2*i-1)=8;% First Lowpass element is a shunt capacitor
                CV(ndc+2*i-1)=CVal(2*i-1,3);% Value of the shunt capacitor
                if (2*i)<nL
                CT(ndc+2*i)=1; % Code of a series inductor
                CV(ndc+2*i)=CVal(2*i,4);% Value of the series inductor
                end
            end
            % Extract the termination which is always set to be a resistance R in
            % the synthesis algorithm.
            CT(ndc+nL+1)=9;R=CVal(1,5);
            CV(ndc+nL+1)=R;% Termination is always given as a resistor in ohms
           end
          
        end
        %Plot_Circuitv1(CT,CV)
             
end

