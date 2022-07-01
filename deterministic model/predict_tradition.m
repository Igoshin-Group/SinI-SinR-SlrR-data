tt=2:0.2:10;
grs=gr_t(tt);
vass=[1,1,0,1];
vss=[1,0,1,1];
vcs=[1,1,1,0];
for i=1:4
    va=vass(i);vs=vss(i);vc=vcs(i);
    ap=dap(va,vc,vs).*1.5;
    n1=1.5;n2=8;th1=0.8;th2=0.15;
    ta=ap.^n1./(ap.^n1+th1.^n1).*grs.^n2./(grs.^n2+th2.^n2)./(grs+1.4);
    %    ta=ap.^n1./(ap.^n1+th1.^n1).*th2.^n2./(ap.^n2+th2.^n2)./(grs+1.4);

    plot(tt,ta);hold on;
end
legend('1-1','1-0','0-1');



%%

tt=2:0.2:10;
grs=gr_t(tt);
vass=[1,1,0,1];
vss=[1,0,1,1];
vcs=[1,1,1,0];
for i=1:4
    va=vass(i);vs=vss(i);vc=vcs(i);
    ap=dap(va,vc,vs).*1.5;
    n1=1.5;n2=8;th1=0.15;th2=2.5;
    %ta=ap.^n1./(ap.^n1+th1.^n1).*grs.^n2./(grs.^n2+th2.^n2)./(grs+1.4);
        ta=ap.^n1./(ap.^n1+th1.^n1).*th2.^n2./(ap.^n2+th2.^n2)./(grs+1.4);

    plot(tt,ta);hold on;
end
legend('1-1','1-0','0-1');

function x=dap(va,vc,vs)
x=[];
tt=2:0.2:10;
grs=gr_t(tt);
for gr = grs
    x=[x get_ap(gr,va,vc,vs)];
end
end


