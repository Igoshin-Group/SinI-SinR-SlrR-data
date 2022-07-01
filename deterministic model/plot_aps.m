function plot_aps
tt=2:0.2:12;
grs=gr_t(tt);
function x=dap(va,vc,vs,gs)
x=[];
for gr = gs
    x=[x get_ap(gr,va,vc,vs)];
end
end
vas=[1,1,0,1];
vss=[1,1,1,0];
vcs=[1,0,1,1];
fts=[0.3,0.4,0.3];
for i=1:3
    va=vas(i);vs=vss(i);vc=vcs(i);ft=fts(i);
    ap=dap(va,vc,vs,grs)*1.5;plot(tt,ap);hold on;
    ap=dap(va,vc,vs,1./(1./grs+ft*1./grs))*1.5;plot(tt,ap,'--');hold on;
    ap=dap(va,vc,vs,1./(1./grs-ft*1./grs))*1.5;plot(tt,ap,'--');hold on;
end

xlim([2,12])
end