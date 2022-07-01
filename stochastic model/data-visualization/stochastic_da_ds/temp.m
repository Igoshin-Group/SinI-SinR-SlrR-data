load("ds_feedback.mat");
dsft=time;
dsftap=tapA.sum;
load("full_ds.mat");
dst=time;
dstap=tapA.sum;

plot(dsft,wttap,'k-');hold on;
plot(dst,dstap,'m-');hold on;

xlim([2 17]);
legend(["ds_feedback","ds"])