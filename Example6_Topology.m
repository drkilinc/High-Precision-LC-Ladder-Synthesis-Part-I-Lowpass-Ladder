function [ Gain,Rin,Xin ] = Example6_Topology( f,RG )
% Example6_Topology
j=sqrt(-1);w=2*pi*f;p=j*w;
% ----- CELL 1:Load Side ----------
RL=50;
Z1=RL; 
%---- CELL 2: Load Resonator --------------
LL=4.210448229944321e-010;
CL=1.515761362779956e-012;
Y2=p*CL+1/p/LL; Z2=1/Y2;
%------ CELL 3  -------------
C1= 2.850577973021700e-012;
Y3=p*C1;Z3=1/Y3;
% ------ CELL 4 ------------
L2=4.032242603803811e-009;
Z4=p*L2;Y4=1/Z4;
%------- CELL 5 ------------
C3=5.462006221971515e-012;
Y5=p*C3;Z5=1/Y5;
%------- CELL 6 ------------
L4=3.497765699412665e-009;
Z6=p*L4;Y6=1/Z6;
%------- CELL 7 -------------
C5= 5.276723001651962e-012;
Y7=p*C5;Z7=1/Y7;
%------- CELL 8 ------------
L6=2.349750624836812e-009;
Z8=p*L6;Y8=1/Z8;
%-------- CELL 9: Generator Side ----------
Cx= 7.622763893420397e-012;
Y9=p*Cx;Z9=1/Y9;
%-------- CELL 10 ---------
CG=1.515761362779956e-012;
LG=9.473508517374721e-010;
Y10=p*CG+1/p/LG;Z10=1/Y10;
% --------- Computation of Input Impedance
Zin1=Z1; % Load Resistance 50 ohm      
Zin2=Z2+Zin1; Yin2=1/Zin2;  % RL+ZLres   
Yin3=Y3+Yin2;   Zin3=1/Yin3;% From C1
Zin4=Z4+Zin3;   Yin4=1/Zin4;% from L2
Yin5=Y5+Yin4;   Zin5=1/Yin5;% From C3
Zin6=Z6+Zin5;   Yin6=1/Zin6;% From L4
Yin7=Y7+Yin6;   Zin7=1/Yin7;% From C5
Zin8=Z8+Zin7;  %Yin8=1/Zin8;% From L6
Zin9=Z9+Zin8;   % From Cx
Zin10=Z10+Zin9; % From ZG Generator resonance Circuit
% --------Gain From the Generator Side ----------------
Rin=real(Zin10);Xin=imag(Zin10);
Gain=4*RG*Rin/((RG+Rin)^2+Xin^2);

end

