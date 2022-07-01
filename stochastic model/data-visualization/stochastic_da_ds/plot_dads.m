load("full_da.mat");
dat=time;
datap=tapA.sum;
load("full_ds.mat");
dst=time;
dstap=tapA.sum;
load("gr_change_n100.mat");
wtt=time;
wttap=tapA.sum;
load("full_dc.mat");
dct=time;
dctap=tapA.sum;


plot(wtt,wttap,'k-');hold on;
plot(dat,datap,'b-');hold on;
plot(dct,dctap,'r-');hold on;
plot(dst,dstap,'m-');hold on;

xlim([2 17]);
legend(["wt","da","dc","ds"])