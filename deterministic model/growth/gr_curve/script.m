%% fitted parameter
x30=[   2.8208    0.9502    3.4488    0.6158    4.6424    1.0018    1.5307  100.0000    0.0500    0.0778];
x37=[      5.0000    1.1602    2.0000    0.9367    3.3021    2.2228    1.0000  100.0000    0.0500    0.0000];
xd=[      1.9541    1.5300   26.0427    1.4832    3.6801    1.4982    3.3620  100.0000    0.0500    0.0527
];

%% growth data 
t0=[2,3,4,5,6,7];
od37_10_1=[0.51 1.28 1.38 1.38 1.37 1.58];
od37_10_2=[0.47 1.35 1.35 1.4 1.64 1.48];
od37_25_1=[0.63 1.89 2.58 3.05 2.7 2.39];
od37_25_2=[0.54 1.66 2.43 3.24 2.74 2.59];
od37_50_1=[0.52 1.68 2.88 4.49 4.77 4.31];
od37_50_2=[0.57 1.72 2.55 3.98 4.57 4.49];
od37_100_1=[0.57 1.86 3.00 4.81 5.61 7.23];
od37_100_2=[0.51 1.80 3.01 3.6 4.8 5.92];
od30_10_1=[0.2 0.62 1.27 1.29 1.48 1.53];
od30_10_2=[0.23 0.52 1.07 1.18 1.32 1.51];
od30_25_1=[0.21 0.52 1.41 1.93 2.38 2.87];
od30_25_2=[0.24 0.51 1.13 1.87 2.41 2.6 ];
od30_50_1=[0.23 0.58 1.47 2.1 2.91 4.29];
od30_50_2=[0.16 0.48 1.20 1.83 2.53 3.87];
od30_100_1=[0.25 0.44 1.14 1.95 2.86 3.63];
od30_100_2=[0.20 0.51 1.21 2.15 2.80 4.21];
dsm1=[	0.29	0.94	2.29	2.66	2.95	2.88	3.12	3.38];
dsm2=[	0.21	0.67	1.93	2.60	3.04	3.21	3.66	3.93];
dsm3=[	0.24	0.82	2.15	2.82	3.12	3.60	4.25	4.28];
%% Fitted curve plot
para=x37;
in=2;% 1---nutrient   2---cells
t0=[2,3,4,5,6,7];
od37_10_1=[0.51 1.28 1.38 1.38 1.37 1.58];
od37_10_2=[0.47 1.35 1.35 1.4 1.64 1.48];
od37_25_1=[0.63 1.89 2.58 3.05 2.7 2.39];
od37_25_2=[0.54 1.66 2.43 3.24 2.74 2.59];
od37_50_1=[0.52 1.68 2.88 4.49 4.77 4.31];
od37_50_2=[0.57 1.72 2.55 3.98 4.57 4.49];
od37_100_1=[0.57 1.86 3.00 4.81 5.61 7.23];
od37_100_3=[0.11	0.32	1.36	2.35	3.97	5.77	7.83];
od37_100_4=[0.13	0.50	1.26	2.31	3.71	4.64	6.05];
od37_100_5=[0.09	0.27	0.80	1.76	3.05	3.95	5.34];

od37_100_2=[0.51 1.80 3.01 3.6 4.8 5.92];
kc=para(1);
vm=para(2);
Kn=para(3);
kd=para(4);

Kd=para(5);m=para(6);h=para(7);N0=para(8);C0=para(9);Tau=para(10);
[t,x]=ode15s(@(t,x100)F(x100,kc,vm,Kn,kd,Kd,m,h),[Tau,8],[N0,C0]);
plot(t,x(:,in),'g','LineWidth',1.5); hold on;
[t,x]=ode15s(@(t,x50)F(x50,kc,vm,Kn,kd,Kd,m,h),[Tau,8],[N0/2,C0]);
plot(t,x(:,in),'k','LineWidth',1.5); hold on;
[t,x]=ode15s(@(t,x25)F(x25,kc,vm,Kn,kd,Kd,m,h),[Tau,8],[N0/4,C0]);
plot(t,x(:,in),'r','LineWidth',1.5); hold on;
[t,x]=ode15s(@(t,x10)F(x10,kc,vm,Kn,kd,Kd,m,h),[Tau,8],[N0/10,C0]);
plot(t,x(:,in),'b','LineWidth',1.5); hold on;
para=xd;
t0=[1,2,3,4,5,6,7,8];
kc=para(1);
vm=para(2);
Kn=para(3);
kd=para(4);
Kd=para(5);m=para(6);h=para(7);
N0=para(8);C0=para(9);Tau=para(10);
legend('100%','50%','25%','10%');
t0=[2,3,4,5,6,7];
errorbar(t0,(od37_10_1+od37_10_2)./2,sqrt((od37_10_1-od37_10_2).^2./2),'bo');hold on;
errorbar(t0,(od37_25_1+od37_25_2)./2,sqrt((od37_25_1-od37_25_2).^2./2),'ro');hold on;
errorbar(t0,(od37_50_1+od37_50_2)./2,sqrt((od37_50_1-od37_50_2).^2./2),'ko');hold on;
errorbar(t0,(od37_100_1+od37_100_2)./2,sqrt((od37_100_1-od37_100_2).^2./2),'go');hold on;
xlabel('time');
ylabel('cell density(OD600)');


figure();
para=x30;
in=2;
t0=[2,3,4,5,6,7];
od30_10_1=[0.2 0.62 1.27 1.29 1.48 1.53];
od30_10_2=[0.23 0.52 1.07 1.18 1.32 1.51];
od30_25_1=[0.21 0.52 1.41 1.93 2.38 2.87];
od30_25_2=[0.24 0.51 1.13 1.87 2.41 2.6 ];
od30_50_1=[0.23 0.58 1.47 2.1 2.91 4.29];
od30_50_2=[0.16 0.48 1.20 1.83 2.53 3.87];
od30_100_1=[0.25 0.44 1.14 1.95 2.86 3.63];
od30_100_2=[0.20 0.51 1.21 2.15 2.80 4.21];
kc=para(1);
vm=para(2);
Kn=para(3);
kd=para(4);

Kd=para(5);m=para(6);h=para(7);N0=para(8);C0=para(9);
Tau=para(10);
[t,x]=ode15s(@(t,x100)F(x100,kc,vm,Kn,kd,Kd,m,h),[Tau,8],[N0,C0]);
plot(t,x(:,in),'g','LineWidth',1.5); hold on;
[t,x]=ode15s(@(t,x50)F(x50,kc,vm,Kn,kd,Kd,m,h),[Tau,8],[N0/2,C0]);
plot(t,x(:,in),'k','LineWidth',1.5); hold on;
[t,x]=ode15s(@(t,x25)F(x25,kc,vm,Kn,kd,Kd,m,h),[Tau,8],[N0/4,C0]);
plot(t,x(:,in),'r','LineWidth',1.5); hold on;
[t,x]=ode15s(@(t,x10)F(x10,kc,vm,Kn,kd,Kd,m,h),[Tau,8],[N0/10,C0]);
plot(t,x(:,in),'b','LineWidth',1.5); hold on;
errorbar(t0,(od30_10_1+od30_10_2)./2,sqrt((od30_10_1-od30_10_2).^2./2),'bo');hold on;
errorbar(t0,(od30_25_1+od30_25_2)./2,sqrt((od30_25_1-od30_25_2).^2./2),'ro');hold on;
errorbar(t0,(od30_50_1+od30_50_2)./2,sqrt((od30_50_1-od30_50_2).^2./2),'ko');hold on;
errorbar(t0,(od30_100_1+od30_100_2)./2,sqrt((od30_100_1-od30_100_2).^2./2),'go');hold on;

xlabel('time');
ylabel('cell density(OD600)');
legend('100%','50%','25%','10%');


%% Data



tapA30_10=[115.31	99.09	72.00	122.63	211.24	260.06];  
tapA30_25=[98.21	114.06	113.21	216.95	349.33	442.68];  
tapA30_50=[88.32	100.54	131.08	194.91	346.51	422.84];  
tapA30_100=[88.75	85.42	124.59	178.60	279.46	381.06];  
tapA37_10=[29.31	38.83	58.97	56.49	58.77	45.43];  
tapA37_25=[45.40	57.23	102.48	77.04	49.61	22.12];  
tapA37_50=[54.39	61.01	112.63	143.23	191.27	143.02];  
tapA37_100=[44.50	57.60	110.42	177.34	380.29	469.87];  
spoIIG30_10=[1.90	1.50	1.31	2.01	1.78	34.42];  
spoIIG30_25=[1.30	0.86	1.36	1.34	2.39	29.77];  
spoIIG30_50=[4.10	1.56	1.12	1.88	3.24	5.73];  
spoIIG30_100=[3.75	2.70	1.45	1.54	2.49	4.78];  
spoIIG37_10=[0.86	0.58	0.74	5.33	41.57	129.39];  
spoIIG37_25=[0.06	1.13	1.14	67.41	231.93	208.59];  
spoIIG37_50=[1.37	0.91	3.85	36.98	222.65	313.42];  
spoIIG37_100=[2.02	0.94	1.91	44.25	160.52	180.74];  

%%  growth rate ver expression
figure();
in=1;
para=x37;
kc=para(1);
vm=para(2);
Kn=para(3);
kn2=para(4);kn22=kn2;
k2=para(5);K2=para(6);
h=para(7);
N0=para(8);C0=para(9);
Tau=para(10);
[t,x]=ode15s(@(t,x100)F(x100,kc,vm,Kn,kn2,k2,K2,h),[Tau,7],[N0,C0]);n=x(:,1);c=x(:,2);x=vm.*(n.^h./(n.^h+Kn.^h))-kn22.*c.^k2./(K2+c.^k2);
plot(t,x,'g','LineWidth',1.5); hold on;
[t,x]=ode15s(@(t,x50)F(x50,kc,vm,Kn,kn2,k2,K2,h),[Tau,7],[N0/2,C0]);n=x(:,1);c=x(:,2);x=vm.*(n.^h./(n.^h+Kn^h))-kn22.*c.^k2./(K2+c.^k2);
plot(t,x,'k','LineWidth',1.5); hold on;
[t,x]=ode15s(@(t,x25)F(x25,kc,vm,Kn,kn2,k2,K2,h),[Tau,7],[N0/4,C0]);n=x(:,1);c=x(:,2);x=vm.*(n.^h./(n.^h+Kn^h))-kn22.*c.^k2./(K2+c.^k2);
plot(t,x,'r','LineWidth',1.5); hold on;
[t,x]=ode15s(@(t,x10)F(x10,kc,vm,Kn,kn2,k2,K2,h),[Tau,7],[N0/10,C0]);n=x(:,1);c=x(:,2);x=vm.*(n.^h./(n.^h+Kn^h))-kn22.*c.^k2./(K2+c.^k2);
plot(t,x,'b','LineWidth',1.5); hold on;
ylim([0,4]);
para=xd;
t0=[1,2,3,4,5,6,7,8];
kc=para(1);
vm=para(2);
Kn=para(3);
kd=para(4);
Kd=para(5);m=para(6);h=para(7);
N0=para(8);C0=para(9);Tau=para(10);
[t,x]=ode15s(@(t,x100)F(x100,kc,vm,Kn,kn2,k2,K2,h),[Tau,9],[N0,C0]);n=x(:,1);c=x(:,2);x=vm.*(n.^h./(n.^h+Kn.^h));
legend('100%','50%','25%','10%','DSM');

xlabel('time');
ylabel('Growth Rate');
%% Plot DSM media growth curve
para=xd;
t0=[1,2,3,4,5,6,7,8];
kc=para(1);
vm=para(2);
Kn=para(3);
kd=para(4);
Kd=para(5);m=para(6);h=para(7);
N0=para(8);C0=para(9);Tau=para(10);
[t,x]=ode15s(@(t,x100)F(x100,kc,vm,Kn,kd,Kd,m,h),[Tau,9],[N0,C0]);
plot(t,x(:,2),'k','Linewidth',1.5); hold on;
plot(t0,dsm1,'ko','Linewidth',1.5); hold on;
plot(t0,dsm2,'ko','Linewidth',1.5); hold on;
plot(t0,dsm3,'ko','Linewidth',1.5); hold on;
legend('DSM');
xlabel('time');

ylabel('cell density(OD600)');

%% deval
figure();
in=1;
para=x37;
kc=para(1);
vm=para(2);
Kn=para(3);
kn2=para(4);
k2=para(5);K2=para(6);
h=para(7);
N0=para(8);C0=para(9);
Tau=para(10);
sol=ode15s(@(t,x100)F(x100,kc,vm,Kn,kn2,k2,K2,h),[Tau,7],[N0,C0]);x=deval(sol,[2,3,4,5,6,7]);n=x(1,:);c=x(2,:);x=vm.*(n.^h./(n.^h+Kn^h))-kn2.*c.^k2./(K2+c.^k2)

%%  growth rate ver expression
figure();
in=1;
para=x30;
kc=para(1);
vm=para(2);
Kn=para(3);
kn2=para(4);kn22=0;
k2=para(5);K2=para(6);
h=para(7);
N0=para(8);C0=para(9);
Tau=para(10);
[t,x]=ode15s(@(t,x100)F(x100,kc,vm,Kn,kn2,k2,K2,h),[Tau,7],[N0,C0]);n=x(:,1);c=x(:,2);x=kn2.*c.^k2./(K2+c.^k2);
plot(t,x,'g','LineWidth',1.5); hold on;
[t,x]=ode15s(@(t,x50)F(x50,kc,vm,Kn,kn2,k2,K2,h),[Tau,7],[N0/2,C0]);n=x(:,1);c=x(:,2);x=kn2.*c.^k2./(K2+c.^k2);
plot(t,x,'k','LineWidth',1.5); hold on;
[t,x]=ode15s(@(t,x25)F(x25,kc,vm,Kn,kn2,k2,K2,h),[Tau,7],[N0/4,C0]);n=x(:,1);c=x(:,2);x=kn2.*c.^k2./(K2+c.^k2);
plot(t,x,'r','LineWidth',1.5); hold on;
[t,x]=ode15s(@(t,x10)F(x10,kc,vm,Kn,kn2,k2,K2,h),[Tau,7],[N0/10,C0]);n=x(:,1);c=x(:,2);x=kn2.*c.^k2./(K2+c.^k2);
plot(t,x,'b','LineWidth',1.5); hold on;
para=xd;
t0=[1,2,3,4,5,6,7,8];
kc=para(1);
vm=para(2);
Kn=para(3);
kd=para(4);
Kd=para(5);m=para(6);h=para(7);
N0=para(8);C0=para(9);Tau=para(10);
[t,x]=ode15s(@(t,x100)F(x100,kc,vm,Kn,kn2,k2,K2,h),[Tau,9],[N0,C0]);n=x(:,1);c=x(:,2);kn2.*c.^k2./(K2+c.^k2);
%plot(t,x,'k--','LineWidth',2); hold on;
legend('100%','50%','25%','10%');

xlabel('time');
ylabel('Growth Rate');