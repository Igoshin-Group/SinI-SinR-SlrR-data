thres=30;

load("gr_change_n100_spore.mat")
spo=(double(spo));nospo=(double(nospo));
edges=0:50:700;
[a,x]=hist((((nospo))),edges);
bar(x, a./length(nospo),1,"FaceAlpha",0.5)
set(gca, 'xtick', x)
hold on;

save("gr_change_n100_spore.mat","spo","nospo")
[a,x]=hist(((spo)),edges);
bar(x, a./length(spo),1,"FaceAlpha",0.5)
set(gca, 'xtick', x)
xlim([-15,700])
legend(["spore","non-spore"])
title("wt")
wts=length(spo(spo>thres))./(length(spo));
wtns=length(nospo(nospo>thres))./(length(nospo));
wta=(length(spo(spo>thres))+length(nospo(nospo>thres)))./(length(nospo)+(length(spo)));


%%
load("full_ds_spore.mat")
spo=(double(spo));nospo=(double(nospo));
edges=0:50:700;
save("full_ds_spore.mat","spo","nospo")

[a,x]=hist((((nospo))),edges);
bar(x, a./length(nospo),1,"FaceAlpha",0.5)
set(gca, 'xtick', x)
hold on;
[a,x]=hist(((spo)),edges);
bar(x, a./length(spo),1,"FaceAlpha",0.5)
set(gca, 'xtick', x)
xlim([-15,700])
legend(["spore","non-spore"])
title("wt")

dss=length(spo(spo>thres))./(length(spo));
dsns=length(nospo(nospo>thres))./(length(nospo));
dsa=(length(spo(spo>thres))+length(nospo(nospo>thres)))./(length(nospo)+(length(spo)));

%%
load("full_dc_spore.mat")
spo=(double(spo))*1.5;nospo=(double(nospo));
edges=0:50:700;
[a,x]=hist((((nospo))),edges);
bar(x, a./length(nospo),1,"FaceAlpha",0.5)
set(gca, 'xtick', x)
hold on;
save("full_dc_spore.mat","spo","nospo")

[a,x]=hist(((spo)),edges);
bar(x, a./length(spo),1,"FaceAlpha",0.5)
set(gca, 'xtick', x)
xlim([-15,700])
legend(["non-spore","spore"])
title("wt")

dcs=length(spo(spo>thres))./(length(spo));
dcns=length(nospo(nospo>thres))./(length(nospo));
dca=(length(spo(spo>thres))+length(nospo(nospo>thres)))./(length(nospo)+(length(spo)));



%%
y=[wts,wtns,wta,0,dss,dsns,dsa,0,dcs,dcns,dca];
bar(y)
ylim([0,0.5])

%%
x=[1,2];
y=[0.05,0.27];
bar(x,y)
ylim([0,0.3])

%%


