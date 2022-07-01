
ttt=15;


kk=0:ttt;
para=[    12.4048    0.7000   30.0000    1.0000    0.2000    2.7026    5.0000    0.7456   65.0000   45.0000    0.3438
];

kc=para(1);
vm=para(2);
Kn=para(3);
h=para(4);kd=para(5);Kd=para(6);m=para(7);fn=para(8);
x=[1 0];% sample points from simulation
tau=0.0001;N10=para(9);N1=para(10);C0=para(11);

tt=0:0.1:ttt;
sol=ode15s(@(t,x)F(t,x,para(1:9)),[0,21],[100,C0]');
n=x*deval(sol,tt);
x100=vm.*(n.^h./(n.^h+Kn.^h));

sol=ode15s(@(t,x)F(t,x,para(1:9)),[0,21],[N10,C0]');
n=x*deval(sol,tt);
x10=vm.*(n.^h./(n.^h+Kn.^h));

sol=ode15s(@(t,x)F(t,x,para(1:9)),[0,21],[N1,C0]');
n=x*deval(sol,tt);
x1=vm.*(n.^h./(n.^h+Kn.^h));


plot(tt,x100,'k-');hold on;

plot(tt,x10,'b-');hold on;

plot(tt,x1,'r-');hold on;

xlabel('time(h)');
ylabel('gr');

%%
out=[0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15];
gr=interp1(tt,x1,out)

