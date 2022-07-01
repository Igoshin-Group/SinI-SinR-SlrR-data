load("full_da.frac_vs_mean.mat");
dat=time;
datap=mean;
dafrac=frac;
dalevel=mean_active;

load("full_ds.frac_vs_mean.mat");
dst=time;
dstap=mean;
dsfrac=frac;
dslevel=mean_active;

load("gr_change_n100.frac_vs_mean.mat");
wtt=time;
wttap=mean;
wtfrac=frac;
wtlevel=mean_active;

load("full_dc.frac_vs_mean.mat");
dct=time;
dctap=mean;
dcfrac=frac;
dclevel=mean_active;


plot(wtt,wttap,'k-');hold on;
plot(dat,datap,'b-');hold on;
plot(dct,dctap,'r-');hold on;
plot(dst,dstap,'m-');hold on;

xlim([2 17]);
legend(["wt","da","dc","ds"])
xlabel("Time (h)")
ylabel("mean tapA level of all cells")
%%
plot(wtt,wtfrac,'k-');hold on;
plot(dat,dafrac,'b-');hold on;
plot(dct,dcfrac,'r-');hold on;
plot(dst,dsfrac,'m-');hold on;

xlim([2 17]);
xlabel("Time (h)")
ylabel("fraction of tapA expressing cells")
legend(["wt","da","dc","ds"])
%%
plot(wtt,wtlevel,'k-');hold on;
plot(dat,dalevel,'b-');hold on;
plot(dct,dclevel,'r-');hold on;
plot(dst,dslevel,'m-');hold on;
xlabel("Time (h)")
ylabel("mean tapA level of tapA expressing cells")
xlim([2 17]);
legend(["wt","da","dc","ds"])