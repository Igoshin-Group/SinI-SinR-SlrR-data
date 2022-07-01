tt=2:19;
data;
wt=(wt1+wt2)/2;da=(da1+da2)/2;ds=(ds1+ds2)/2;
wtl=(wtl1+wtl2)/2; dal=(dal1+dal2)/2;dsl=(dsl1+dsl2)/2;
k=wt(end)/wtl(1);
wtl=wtl.*k;
k=da(end)/dal(1);
dsl=dsl.*k;
k=ds(end)/dsl(1);
dsl=dsl.*k;

wt=[wt1,wtl(2:end)];da=[da,dal(2:end)];ds=[ds,dsl(2:end)];
plot(tt,wt,'ko-');hold on;
wtgr1=[1.42	2.22	3.42	4.43	5.64	6.53	7.79	8.58	8.95	8.26

];


wtgr2=[7.85	7.68	7.30	7.12	7.34	7.09	6.69	6.59	6.18

];
ylabel('PtapA activity')
yyaxis right;
k=wtgr1(end)/wtgr2(1);
wtgr2=wtgr2.*k;
wtg=[wtgr1,wtgr2(2:end)];
plot(tt,wtg,'bo--');hold on;
ylabel('cell density (OD600)')

%plot(tt,da,'bo');hold on;plot(tt,ds,'ro');hold on;
%plot(tt,ds,'ro');
xlim([2,16]);
%legend('wt','dkinA','dsda')
xlabel('Time (h)')


%%

phy=[1177.69 2600.87 3423.45 4627.38 4618.67 5054.71 5108.92 4960.64 5396.67 5618.42];
phy2=[4984.28 5082.87 4049.90 4143.95 4441.66 3285.71 3631.96 3497.64 3308.30];

phya=[1131.20 2499.38 4972.15 2599.65 4524.16 5382.19 4811.16 4008.79 4865.22 4631.62 ];
phya2=[4871.02 4976.55 4501.97 4065.99 4460.39 4053.84 3938.03 3636.22 3562.86 ];

phy=(phy+phya)/2; phy2=(phya2+phy2)/2;
k=phy(end)/phy2(1);
phy2=phy2.*k;
tt=2:19;
p=[phy,phy2(2:end)];
plot(tt,p,'ko-');hold on;
wtgr1=[1.42	2.22	3.42	4.43	5.64	6.53	7.79	8.58	8.95	8.26

];


wtgr2=[7.85	7.68	7.30	7.12	7.34	7.09	6.69	6.59	6.18

];
ylabel('Phy-spank activity')
yyaxis right;
k=wtgr1(end)/wtgr2(1);
wtgr2=wtgr2.*k;
wtg=[wtgr1,wtgr2(2:end)];
plot(tt,wtg,'bo--');hold on;
ylabel('cell density (OD600)')

%plot(tt,da,'bo');hold on;plot(tt,ds,'ro');hold on;
%plot(tt,ds,'ro');
xlim([2,18]);
%legend('wt','dkinA','dsda')
xlabel('Time (h)')