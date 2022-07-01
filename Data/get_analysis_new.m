clf;
sig_dir="./images/signal/";
files=dir(sig_dir+"*.mat");
files={files.name};
strain_map=containers.Map({'11412','11415','11414'},{'wt','ds','dc'});
signal=struct; % strain: signals (list)
signal(1).wt={};
signal(1).ds={};
signal(2).wt={};
signal(2).ds={};
signal(1).dc={};
signal(2).dc={};
area=struct; % strain: signals (list)
area(1).wt={};
area(1).dc={};
for i = 1:length(files)
filename=files{i};
load(sig_dir+filename,'sig');
filename
max(sig.signal1)
tind=regexp(filename,'T[0-9]');
t=str2num(filename(tind+1));
if t==1
    t=10;
end
strain=filename(1:5);
if strain ~= "11412" && strain ~= "11415" && strain ~= "11414"
    continue
end
strain=strain_map(strain);
if length(signal(1).(strain))<t
    signal(1).(strain){t}=[];
    area(1).(strain){t}=[];
    signal(2).(strain){t}=[];
end

signal(2).(strain){t}=[signal(2).(strain){t} max(0,sig.signal2)];
signal(1).(strain){t}=[signal(1).(strain){t} max(0,sig.signal1)];
area(1).(strain){t}=[area(1).(strain){t} sig.area];

end

result=struct;
result(1).signal=signal;
result(1).area=area;

%%
ts=[10,8];
Ts_wt=[];
Ts_dc=[];
Qs_wt=[];
Qs_dc=[];
Ts_ds=[];
Qs_ds=[];
for t =ts
    Qs_wt=[Qs_wt (signal(2).wt{t})];
    Ts_wt=[Ts_wt (signal(1).wt{t})./area(1).wt{t}];
end
for t =ts
    Qs_ds=[Qs_ds (signal(2).ds{t})];
    Ts_ds=[Ts_ds (signal(1).ds{t})./area(1).ds{t}];
end
for t =ts
    Qs_dc=[Qs_dc (signal(2).dc{t})];
    Ts_dc=[Ts_dc (signal(1).dc{t})./area(1).dc{t}];
end
figure;

Q_thres=0.1;

plot(log10(Ts_wt(Qs_wt>Q_thres)),(Qs_wt(Qs_wt>Q_thres)),'ro'); hold on;
plot(log10(Ts_wt(Qs_wt<Q_thres)),(Qs_wt(Qs_wt<Q_thres)),'ko'); hold on;


plot(log10(Ts_ds(Qs_ds>Q_thres)),(Qs_ds(Qs_ds>Q_thres)),'ro'); hold on;
  plot(log10(Ts_ds(Qs_ds<Q_thres)),(Qs_ds(Qs_ds<Q_thres)),'ko'); hold on;

xlabel('Tap')
ylabel("IIQ")
%%
hist(log10([Qs_wt ]))
Q_thres1=0.01;
%%
[a,x]=hist(log10(0.0001+[Ts_wt(Qs_wt>Q_thres1)]));

bar(x, a./length(Ts_wt(Qs_wt>Q_thres1)),1,"FaceAlpha",0.5);hold on;

[a,x]=hist(log10(0.0001+[Ts_wt(Qs_wt<Q_thres1)]));

bar(x, a./length(Ts_wt(Qs_wt<Q_thres1)),1,"FaceAlpha",0.5);hold on;

legend("spo","nospo")
%%
[a,x]=hist(log10(0.0001+[Ts_dc(Qs_dc>Q_thres1)]));

bar(x, a./length(Ts_dc(Qs_dc>Q_thres1)),1,"FaceAlpha",0.5);hold on;

[a,x]=hist(log10(0.0001+[Ts_dc(Qs_dc<Q_thres1)]));

bar(x, a./length([Ts_dc(Qs_dc<Q_thres1)]),1,"FaceAlpha",0.5);hold on;

legend("spo","nospo")


%%
[a,x]=hist(log10([0.0001+Ts_ds(Qs_ds>Q_thres1)]),-5:0.2:0);

bar(x, a./length(Ts_ds(Qs_ds>Q_thres1)),1,"FaceAlpha",0.5);hold on;

[a,x]=hist(log10([0.0001+Ts_ds(Qs_ds<Q_thres1)]),-5:0.2:0);

bar(x, a./length(Ts_ds(Qs_ds<Q_thres1)),1,"FaceAlpha",0.5);hold on;

legend("spo","nospo")

%%
Q_thres=0.01;
T_thres=0.01;
hist(Ts_wt(Qs_wt>Q_thres))
%%

Q_thres1=0.01;
T_thres1=0.001;
T_thres2=0.001;
T_thres3=0.001;

tq=Ts_wt(Qs_wt>Q_thres1);
wt1=length(tq(tq>T_thres1))/length(tq);
wt2=length(Ts_wt(Ts_wt>T_thres1))/length(Ts_wt);
wt3=(length(Ts_wt(Ts_wt>T_thres1))-length(tq(tq>T_thres1)))/(length(Ts_wt)-length(tq));

tq=Ts_dc(Qs_dc>Q_thres1);
dc1=length(tq(tq>T_thres2))./length(tq);
dc2=length(Ts_dc(Ts_dc>T_thres2))/length(Ts_dc);
dc3=(length(Ts_dc(Ts_dc>T_thres2))-length(tq(tq>T_thres2)))/(length(Ts_dc)-length(tq));



tq=Ts_ds(Qs_ds>Q_thres1);
ds1=length(tq(tq>T_thres3))/length(tq);
ds2=length(Ts_ds(Ts_ds>T_thres3))/length(Ts_ds);
ds3=(length(Ts_ds(Ts_ds>T_thres3))-length(tq(tq>T_thres3)))/(length(Ts_ds)-length(tq));

bar([wt1,wt3,wt2,0,0,ds1,ds3,ds2,0,0,dc1,dc3,dc2])
ylim([0,0.5])
length(Ts_wt(Qs_wt>Q_thres1))
length(Ts_wt)

length(Ts_dc(Qs_dc>Q_thres1))
length(Ts_dc)

length(Ts_ds(Qs_ds>Q_thres1))
length(Ts_ds)