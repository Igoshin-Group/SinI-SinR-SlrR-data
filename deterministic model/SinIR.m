function dx=SinIR(t,x,ap,gr)
vi=24.98;vr=40;vl=80.2;vi0=0;vl0=0;
kdr=0.3;kdi=0.3;kudr=39.7;kudi=214.7;
kb1=0.32;kb2=0.32; Ki=0.4;Kl=0.5;kdlr=1.1661;
kdeg=gr+0.2; kdegl=gr+0.8; apd= (13+4*ap-13^0.5*(13 + 8 *ap)^0.5)*125/2.^(0.95*(1.1 - gr));
vt=50;Kt=5;
I=x(1);
IR=x(2);
Id=x(3);
L=x(4);
LR=x(5);
R=x(6);
Rt=x(7);
T=x(8);
dx(1)=(vi0+vi*(apd)/(Ki+apd))*fglobal(gr,0.8)*400/8.3*1-kdi*I*I*2+kudi*Id*2-kdeg*I*1;
dx(2)=kb1*Id*R*2-kdeg*IR*1;
dx(3)=-kb1*Id*R*1+kdi*I*I*1-kudi*Id*1-kdeg*Id*1;
dx(4)=(vl0+vl*Kl/(Rt+Kl))*fglobal(gr,0.3)*200/8.3*1-kb2*L*R*1+kdlr*LR*1-kdegl*L*1;
dx(5)=kb2*L*R*1-kdlr*LR*1-kdeg*LR*1;
dx(6)=vr*fglobal(gr,0.8)*200/8.3*1-kb1*Id*R*1-kdr*R*R*2+kudr*Rt*2-kb2*L*R*1+kdlr*LR*1-kdeg*R*1;
dx(7)=kdr*R*R*1-kudr*Rt*1-kdeg*Rt*1;
dx(8)=vt*Kt/(Rt+Kt)*fglobal(gr,0.4)*200/8.3*1-1*T*1;
dx=dx';
end
