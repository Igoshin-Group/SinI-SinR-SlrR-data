t=0:10;
wt=[0.05	0.33	1.42	2.22	3.42	4.43	5.64	6.53	7.79	8.58	8.95	];



da=[0.05	0.21	1.22	2.42	3.92	5.13	6.77	8.05	6.78	5.20	4.68];
ds=[0.05	0.18	0.83	2.20	3.49	4.53	5.15	5.70	6.48	7.21	7.28];

os0=[0.05	0.51	1.95	3.30	4.10	5.57	7.03	7.63	7.62	7.86	7.68];
os20=[0.05	0.36	1.66	3.09	3.99	5.12	6.22	6.77	7.39	7.65	7.37];
os50=[0.05	0.44	1.86	3.45	4.59	6.00	7.32	7.81	7.51	7.39	7.23];
os100=[0.05	0.51	1.90	3.26	3.94	4.97	6.13	6.96	7.66	7.55	7.63];

oa0=[0.05	0.34	1.42	2.74	3.36	4.79	5.83	6.87	7.53	8.06	7.78];
oa20=[0.05	0.25	1.11	2.57	3.47	3.78	4.46	4.36	4.48	4.48	5.08];
oa50=[0.05	0.32	0.96	1.29	1.63	1.62	1.69	1.85	1.66	1.45	1.58];
oa100=[0.05	0.30	1.08	1.46	1.56	1.79	1.94	2.78	2.28	2.16	1.73];

set(0, 'DefaultLineLineWidth', 1);
plot(t,wt,'o-');hold on;plot(t,ds,'o-');hold on;
plot(t,os0,'o-');hold on;plot(t,os20,'o-');hold on;
plot(t,os50,'o-');hold on;plot(t,os100,'o-');hold on;
legend('wt','dsda','sda-induction-0','sda-induction-20','sda-induction-50','sda-induction-100');
xlabel('time (h)');
ylabel('OD600');
%%
set(0, 'DefaultLineLineWidth', 1);
plot(t,wt,'ko-');hold on;
plot(t,oa0,'o-');hold on;plot(t,oa20,'o-');hold on;
%plot(t,oa50,'o-');hold on;
plot(t,oa100,'o-');hold on;
legend('wt','0','20','100');
xlabel('time (h)');
ylabel('cell density (OD600)');
%%
set(0, 'DefaultLineLineWidth', 1);
plot(t,wt,'ko-');hold on;
plot(t,os0,'o-');hold on;plot(t,os20,'o-');hold on;
%plot(t,oa50,'o-');hold on;
plot(t,os100,'o-');hold on;
legend('wt','0','20','100');
xlabel('time (h)');
ylabel('cell density (OD600)');


