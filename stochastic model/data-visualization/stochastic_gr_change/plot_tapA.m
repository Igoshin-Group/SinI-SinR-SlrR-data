load("gr_change_n100.mat");
n100t=time;
n100tap=tapA;
load("gr_change_n10.mat");
n10t=time;
n10tap=tapA;
load("gr_change_n1.mat");
n1t=time;
n1tap=tapA;

plot(n100t,n100tap.sum);hold on;
plot(n10t,(n10tap.sum-14)/1.5+14);hold on;
plot(n1t,n1tap.sum);hold on;
xlim([2 16]);
legend(["n100","n10","n1"])