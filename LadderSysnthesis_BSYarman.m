function [A,CVal] = LadderSysnthesis_BSYarman( KFlag,R0,f0,ndc,a,b )
[C_HP,L_HP,C_LP,L_LP,Termination] = BandPassLadderSynthesis_Yarman(KFlag,R0,f0,ndc,a,b);
nHP1=length(C_HP);nHP2=length(L_HP);nLP1=length(C_LP);nLP2=length(L_LP);
A=[nHP1 nHP2 nLP1 nLP2];
nmax=max(A);
CHP=fullvector_topdown(nmax,C_HP);
LHP=fullvector_topdown(nmax,L_HP);
CLP=fullvector_topdown(nmax,C_LP);
LLP=fullvector_topdown(nmax,L_LP);
Ter=fullvector_topdown(nmax,Termination);
A='    Series Capacitors(CHP)    Shunt Inductors(LHP)      Shunt Capacitors(CLP)    Series Inductors(LLP)        Termination';
format long e
CVal=[CHP', LHP', CLP', LLP', Ter'];


end

