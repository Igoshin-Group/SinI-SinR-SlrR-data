function res=det_ana(ap,gr)
% para: kdir,vi,vr,vl,Ki,Kl,kudi,kudr

vi=70;vr=126.4777;vl=110.9821;vi0=0;vl0=0;
kdr=0.3;kdi=0.3;kudr=247.34;kudi=169.53;
kb1=0.32;kb2=0.32; Ki=1.0844;Kl=2.2733;kdlr=0.9940;
vt=30;Kt=5;

apd= (13+4*ap-3.6*(13 + 8 *ap)^0.5)*125/2.^(0.95*(1.1 - gr));
kdeg=gr+0.2; kdegl=gr+0.8;
syms R L Id Ii IR LR Rt T;
assume(R >=0);
assume(L >=0);
assume(Id >=0);
assume(Ii >=0);
assume(LR >=0);
assume(IR >=0);

dx1=(vi0+vi*(apd)/(Ki+apd))*fglobal(gr,0.8)*400/8.3*1-kdi*Ii*Ii*2+kudi*Id*2-kdeg*Ii*1==0;
dx2=kb1*Id*R*2-kdeg*IR*1==0;
dx3=-kb1*Id*R*1+kdi*Ii*Ii*1-kudi*Id*1-kdeg*Id*1==0;
dx4=(vl0+vl*Kl/(Rt+Kl))*fglobal(gr,0.3)*200/8.3*1-kb2*L*R*1+kdlr*LR*1-kdegl*L*1==0;
dx5=kb2*L*R*1-kdlr*LR*1-kdeg*LR*1==0;
dx6=vr*fglobal(gr,0.8)*200/8.3*1-kb1*Id*R*1-kdr*R*R*2+kudr*Rt*2-kb2*L*R*1+kdlr*LR*1-kdeg*R*1==0;
dx7=kdr*R*R*1-kudr*Rt*1-kdeg*Rt*1==0;
dx8=vt*Kt/(Rt+Kt)*fglobal(gr,0.4)*200/8.3*1-1*T*1==0;


sol = vpasolve(dx1, dx2,dx3,dx4,dx5,dx6,dx7,dx8,'Random',true);
res=min(sol.R);
end


