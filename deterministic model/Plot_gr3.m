tt1=2:11;tt2=11:19;
wt1=[1.80	3.44	4.60	6.16	6.84	6.88	6.97	7.05	7.14	6.53
];
da1=[	1.22	2.42	3.92	5.13	6.77	8.05	6.78	5.20	4.68	4.98
];
ds1=[	0.83	2.20	3.49	4.53	5.15	5.70	6.48	7.21	7.28	7.68
];

wt2=[8.72	7.86	7.27	7.19	7.21	7.27	6.83	6.92	6.63
];
da2=[7.24	7.10	6.93	6.72	6.78	6.47	5.94	4.81	4.25
];
ds2=[9.10	8.63	8.60	8.55	9.11	9.29	8.91	9.05	8.97
];

%%

set(0, 'DefaultLineLineWidth', 1);
tt1=2:11;tt2=11:19;
plot(tt1,ds1,'ro-');hold on;plot(tt1,da1,'bo-');hold on;plot(tt1,wt1,'ko-');hold on;

plot(tt2,ds2,'ro-');hold on;plot(tt2,da2,'bo-');hold on;plot(tt2,wt2,'ko-');hold on;

legend('dsda','dkinA','wt');
xlabel('time (h)');
ylabel('OD600');



