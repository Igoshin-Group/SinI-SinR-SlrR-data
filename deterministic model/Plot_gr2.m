t=0:10;
wt=[0.05	0.33	1.80	3.44	4.60	6.16	6.84	6.88	6.97	7.05	7.14];
da=[0.05	0.21	1.22	2.42	3.92	5.13	6.77	8.05	6.78	5.20	4.68];
ds=[0.05	0.18	0.83	2.20	3.49	4.53	5.15	5.70	6.48	7.21	7.28];



%%
set(0, 'DefaultLineLineWidth', 1);
plot(t,wt,'o-');hold on;plot(t,da,'o-');hold on;plot(t,ds,'o-');hold on;
legend('wt','dkinA','dsda');
xlabel('time (h)');
ylabel('OD600');



