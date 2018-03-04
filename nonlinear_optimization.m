function [ c ] = nonlinear_optimization( c0,wc1,wc2,T0,KFlag,W,ndc,a0,ntr,Koptimization,RGEN,RLoad )
%Call nonlinear data fitting function
%%%%%%%%%%% Preparation for the optimization %%%%%%%%%%%%%%%%%%%%%%%%%
%
if ntr==1; x0=[c0 a0];Nx=length(x0);end;%Yes transformer case
if ntr==0; x0=c0;Nx=length(x0);end;%No transformer case
%
%
 OPTIONS=optimset('MaxFunEvals',20000,'MaxIter',50000);
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
%
% Minimax Optimization
if Koptimization==1;
f = @(x)obj_PartI(x,T0,wc1,wc2,KFlag,ntr,ndc,W,a0,RGEN,RLoad);
[x,fval] = fminimax(f,x0);
end
%
if Koptimization==0
% Call optimization function lsqnonlin:    
x=lsqnonlin('obj_PartI',x0,[],[],OPTIONS,T0,wc1,wc2,KFlag,ntr,ndc,W,a0,RGEN,RLoad);
end
% After optimization separate x into coefficients
if ntr==1; %Yes transformer case 
    for i=1:Nx-1; 
    c(i)=x(i);
    end;
    a0=x(Nx);
end
if ntr==0;% No Transformer case
    for i=1:Nx; 
        c(i)=x(i);
    end;
end
%
%   Detailed explanation goes here


end

