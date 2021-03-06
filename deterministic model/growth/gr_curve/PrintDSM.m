function s=Print30(para)
in=2;
t0=[0,1,2,3,4,5,6,7,8];

od30_200_1=[0.05	0.65	1.69	3.48	4.86	4.57	3.57	3.20	3.65];
od30_100_1=[0.05	0.49	1.40	2.61	2.86	2.21	1.63	2.02	2.50];
od30_50_1=[0.05	0.44	1.00	1.57	1.70	1.37	1.07	1.11	1.19];
od30_25_1=[0.05	0.33	0.82	1.01	0.99	0.99	0.87	0.73	0.68];
od30_10_1=[0.05	0.20	0.47	0.57	0.55	0.53	0.48	0.43	0.37];


g200=[6 10 17.33035714	17.10434174	19.01950719	38.93453664	85.86138968	86.14309211	53.75]./100;
g100=[6 6 7.6171875	5.312386487	38.10553633	51.09170306	117.3018293	91.01351351	57.8125]./100;
g50=[6 6 6.414473684	7.428892216	41.31540698	38.21743929	69.27777778	113.0818318	83.47338936]./100;
g25=[4 4 4.00152439	15.68452381	44.73536036	42.09735577	34.82603093	53.38855422	77.71577381]./100;
g10=[3 3 2.904929577	14.77678571	28.8377193	23.95833333	21.81122449	17.52717391	17.03869048]./100;

% 
% para=[   41.4404    1.9492   25.8799    1.0000    1.8101];
% 
% para=[   37.1301    2.0666   14.6515    1.0000    1.5159];
% para=[     31.3481    2.1274   14.8638    1.0000    1.1191];
% para=[     23.1139    3.0652   19.9262    1.0000    1.1490];
% 
% para=[     14.6418    3.9498    9.0274    1.0000    1.7126];


x=[0,1,2,3,4,5,6,7,8];% sample points from simulation
N0=100;
kc=para(1);
vm=para(2);
Kn=para(3);
h=para(4);
pd=para(5);
p=1;
ttt=0;
[t200,x200]=ode15s(@(t,x100)F(x100,kc,vm,Kn,h,pd*interp1([-5,x],[0,g200],t-ttt,'spline'),p),[0,8],[N0*2,0.05]);
plot(t200,x200(:,in),'y'); hold on;
[t100,x100]=ode15s(@(t,x100)F(x100,kc,vm,Kn,h,pd*interp1([-5,x],[0,g100],t-ttt,'spline'),p),[0,8],[N0,0.05]);
plot(t100,x100(:,in),'g'); hold on;
[t50,x50]=ode15s(@(t,x100)F(x100,kc,vm,Kn,h,pd*interp1([-5,x],[0,g50],t-ttt,'spline'),p),[0,8],[N0/2,0.05]);
plot(t50,x50(:,in),'r'); hold on;
[t25,x25]=ode15s(@(t,x100)F(x100,kc,vm,Kn,h,pd*interp1([-5,x],[0,g25],t-ttt,'spline'),p),[0,8],[N0/4,0.05]);
plot(t25,x25(:,in),'b'); hold on;
[t10,x10]=ode15s(@(t,x100)F(x100,kc,vm,Kn,h,pd*interp1([-5,x],[0,g10],t-ttt,'spline'),p),[0,8],[N0/10,0.05]);
plot(t10,x10(:,in),'k'); hold on;

plot(t0,od30_200_1,'yv');hold on;
plot(t0,od30_100_1,'gv');hold on;
plot(t0,od30_50_1,'rv');hold on;
plot(t0,od30_25_1,'bv');hold on;
plot(t0,od30_10_1,'kv');hold on;

% 
% c=x200(:,in);n=x200(:,1);
% figure();
% dc=vm*(n.^h./(n.^h+Kn.^h));
% plot(t200,dc,'y');hold on;


% 
% c=x100(:,in);n=x100(:,1);
% dc=vm*(n.^h./(n.^h+Kn.^h));
% plot(t100,dc,'g');hold on;
% 
% c=x50(:,in);n=x50(:,1);
% dc=vm*(n.^h./(n.^h+Kn.^h));
% plot(t50,dc,'r');hold on;
% 
% c=x25(:,in);n=x25(:,1);
% dc=vm*(n.^h./(n.^h+Kn.^h));
% plot(t25,dc,'b');hold on;
% 
% c=x10(:,in);n=x10(:,1);
% dc=vm*(n.^h./(n.^h+Kn.^h));
% plot(t10,dc,'k');



end