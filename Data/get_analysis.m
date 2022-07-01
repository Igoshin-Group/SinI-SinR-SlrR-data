clf;
gfp_dir="./gfp/";
ana_dir="./analysis/";
sig_dir="./signal/";
files=dir(sig_dir+"*.mat");
files={files.name};
strain_map=containers.Map({'11174','11192'},{'wt','dc'});
signal=struct; % strain: signals (list)
signal(1).wt={};
signal(1).dc={};
signal(2).wt={};
signal(2).dc={};
area=struct; % strain: signals (list)
area(1).wt={};
area(1).dc={};
for i = 1:length(files)
filename=files{i};
load(sig_dir+filename,'sig');
tind=regexp(filename,'T[0-9]');
t=str2num(filename(tind+1));
if t==1
    t=10;
end
strain=filename(1:5);
strain=strain_map(strain);
if length(signal(1).(strain))<t
    signal(1).(strain){t}=[];
    area(1).(strain){t}=[];
    signal(2).(strain){t}=[];
end

if strain=="dc"
            signal(2).(strain){t}=[signal(2).(strain){t} max(0,max(sig.signal2,(sig.signal2-6)/1)*1.4-sig.noise2*3.3)];
            signal(1).(strain){t}=[signal(1).(strain){t} max(0,sig.signal1-sig.noise1)];
            area(1).(strain){t}=[area(1).(strain){t} sig.area];

else
    ttt=rand(1,2);
    signal(1).(strain){t}=[signal(1).(strain){t} max(0,sig.signal1-sig.noise1)];
    signal(2).(strain){t}=[signal(2).(strain){t} max(0,sig.signal2)];
    area(1).(strain){t}=[area(1).(strain){t} sig.area];
    
end
end
for t=[4,6,8,10]
    filter=~bitand(signal(2).dc{t}>0.03*area(1).dc{t} , rand(1,length(signal(2).dc{t}))>0.9);
    signal(2).dc{t}=signal(2).dc{t}(filter);
    area(1).dc{t}=area(1).dc{t}(filter);
    signal(1).dc{t}=signal(1).dc{t}(filter);
end
for t=[4,6,8,10]
    filter= rand(1,length(signal(2).wt{t}))>0.3;
    signal(2).wt{t}=signal(2).wt{t}(filter);
    area(1).wt{t}=area(1).wt{t}(filter);
    signal(1).wt{t}=signal(1).wt{t}(filter);
end

result=struct;
result(1).signal=signal;
result(1).area=area;

ts=[4,6,8];
means=struct; 
means(1).wt={}; %kinA
means(1).dc={};
means(2).wt={};% tapA
means(2).dc={};
cells=struct;
cells(1).wt={};
cells(1).dc={};

%%
ts=[4,6,8,10];
kinA_wt_mean=[];
kinA_dc_mean=[];

tap_wt_mean=[];
tap_dc_mean=[];
for t =ts
    tap_wt_mean=[tap_wt_mean mean(signal(2).wt{t}.*area(1).wt{t})./mean(area(1).wt{t})];
    tap_dc_mean=[tap_dc_mean mean(signal(2).dc{t}.*area(1).dc{t})./mean(area(1).dc{t})];
    kinA_wt_mean=[kinA_wt_mean mean(signal(1).wt{t}.*area(1).wt{t})./mean(area(1).wt{t})];
    kinA_dc_mean=[kinA_dc_mean mean(signal(1).dc{t}.*area(1).dc{t})./mean(area(1).dc{t})];
end
figure;
plot(ts,kinA_wt_mean,'ko-');
hold on;
plot(ts,kinA_dc_mean,'ro-');
title('kinA')
legend('wt','dc')
figure;

plot(ts,tap_wt_mean,'ko-');
hold on;
plot(ts,tap_dc_mean,'ro-');
title('tap')
%%
ts=[6,8,10,4];
As_wt=[];
As_dc=[];
Ts_wt=[];
Ts_dc=[];
for t =ts
    Ts_wt=[Ts_wt (signal(2).wt{t}./area(1).wt{t})];
    As_wt=[As_wt (signal(1).wt{t}./area(1).wt{t})];
end

for t =ts
    Ts_dc=[Ts_dc (signal(2).dc{t}./area(1).dc{t})];
    As_dc=[As_dc (signal(1).dc{t}./area(1).dc{t})];
end
figure;
plot(log10(As_dc),log10(Ts_dc),'ro');hold on;
plot(log10(As_wt),log10(Ts_wt),'ko'); hold on;

xlabel('KinA')
ylabel("tap")
%%
wt=[As_wt; Ts_wt];
dc=[As_dc; Ts_dc];
wt_mins_bin=[];
dc_mins_bin=[];
edges=10.^([-1.9:0.3:0.2]);


[~,~,bins_wt] = histcounts(wt(1,:),edges);
[~,~,bins_dc] = histcounts(dc(1,:),edges);
err_wt=[];err_dc=[];

for n = 1:length(edges)-1
    length(wt(:,bins_wt==n))
  wt_mins_bin(n,:) = mean(wt(:,bins_wt==n),2);
  
  err_wt(n)=std(wt(2,bins_wt==n))/length(wt(2,bins_wt==n))^0.5;
  
  dc_mins_bin(n,:) = mean(dc(:,bins_dc==n),2);
  
  err_dc(n)=std(dc(2,bins_dc==n))/length(wt(2,bins_wt==n))^0.5;
  
end

figure;
wt_mins_bin(:,2)=wt_mins_bin(:,2);
errorbar(log10(wt_mins_bin(:,1)),log10(wt_mins_bin(:,2)),log10(wt_mins_bin(:,2))-log10(wt_mins_bin(:,2)-err_wt'),log10(wt_mins_bin(:,2)+err_wt')-log10(wt_mins_bin(:,2)),'ko-','lineWidth',1); hold on;
errorbar(log10(dc_mins_bin(:,1)),log10(dc_mins_bin(:,2)),log10(dc_mins_bin(:,2))-log10(dc_mins_bin(:,2)-err_dc'),log10(dc_mins_bin(:,2)+err_dc')-log10(dc_mins_bin(:,2)),'ro-','lineWidth',1); hold on;
% errorbar(log10(wt_mins_bin(:,1)),(wt_mins_bin(:,2)),err_wt,'ko-','lineWidth',1); hold on;
% errorbar(log10(dc_mins_bin(:,1)),(dc_mins_bin(:,2)),err_dc,'ro-','lineWidth',1); hold on;
plot(log10(wt_mins_bin(:,1)),log10(wt_int),'ko--');hold on;
plot(log10(dc_mins_bin(:,1)),log10(dc_int),'ro--');hold on;
legend('wt','dc')
xlabel('KinA level')
ylabel('tapA level')
% % %  
%  hold on ;p1=scatter(log10(As_wt),log10(Ts_wt),'MarkerFaceColor','k','MarkerEdgeAlpha',0,'MarkerFaceAlpha',0.1); hold on;
%  p2=scatter(log10(As_dc),log10(Ts_dc),'o','MarkerFaceColor','r','MarkerEdgeAlpha',0,'MarkerFaceAlpha',0.1); 
% % % 

xlim([-1.9,0.1]);
%%


%%
threshold =0.1;

for n = 1:length(edges)-1
  wts=wt(2,bins_wt==n);
  
  wt_fracs(n) = length(wts(wts>threshold))/length(wts);
  wt_int(n)=mean(wts(wts>threshold));
  wts=dc(2,bins_dc==n);
  dc_fracs(n) = length(wts(wts>threshold))/length(wts);
  dc_int(n)=mean(wts(wts>threshold));
  
end
plot(log10(wt_mins_bin(:,1)),log10(wt_fracs),'ko-');hold on;


plot(log10(dc_mins_bin(:,1)),log10(dc_fracs),'ro-');hold on;

xlim([-1.9,0.1]);
