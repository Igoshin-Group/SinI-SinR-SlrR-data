n100=[58.33	113.71	154.04	259.02	281.63	392.88	432.44	441.72	462.93	370.39	520.99	496.26	472.34	374.55	348.15	258.40	231.90	175.50	140.52];
n10=[63.92	106.54	123.20	104.85	121.50	98.21	66.89	30.35	17.44	11.87	4.99	11.69	11.10	9.01	8.53	5.50	3.41	2.23	1.68];
n1=[50.21	77.46	124.85	146.80	135.87	61.86	19.97	8.63	6.10	4.85	4.46	12.15	22.35	17.00	9.26	3.95	2.42	1.89	1.38];
n100e=[5.03	7.34	54.25	57.46	8.75	99.06	34.02	18.34	38.94	45.11	88.85	64.83	110.60	127.19	96.25	132.33	113.68	98.67	89.71];
n10e=[1.73	9.83	73.82	17.90	22.54	8.91	18.37	0.90	1.95	1.17	1.42	0.58	3.18	2.47	2.14	1.58	0.96	0.53	0.37];
n1e=[2.93	3.57	18.18	24.09	15.70	5.55	1.25	0.70	1.35	0.66	0.21	1.09	5.61	6.07	4.35	1.29	0.69	0.62	0.76];
tt=2:20;

errorbar(tt,n100,n100e,'ko-');hold on;
errorbar(tt,n10,n10e,'ro-');hold on;
errorbar(tt,n1,n1e,'bo-');hold on;
xlim([2 18]);
legend(["n100","n10","n1"])