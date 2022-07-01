tt=2:19;
data;
wt=(wt1+wt2)/2;
da=(da1+da2)/2;
ds=(ds1+ds2)/2;
dc=(dc1+dc2)/2;
wt_err=abs(wt1-wt);
da_err=abs(da1-da);
dc_err=abs(dc1-dc);
ds_err=abs(ds1-ds);

errorbar(tt,wt,wt_err,'ko-');hold on;
errorbar(tt,da,da_err,'bo-');hold on;
errorbar(tt,dc,dc_err,'ro-');hold on;
errorbar(tt,ds,ds_err,'mo-');hold on;

legend(["wt","da","dc","ds"])
