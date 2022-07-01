n=config('SinIR.txt');
rt=[];
grs=0.05:0.01:0.8;
aps=0.0:0.01:3.5;
% para: kdir,vi,vr,vl,Ki,Kl,kudi,kudr

para=[ 1.1661   24.9862   40.0000   80.2121    0.4    0.5  214.7179   39.6674];
gr=0.5;rt=[];lt=[];
 for j=1:length(aps)
     ap=aps(j);
rt(j)=fss(6,ap,gr,'r');
lt(j)=fss(6,ap,gr,'l');
 end
%%
plot(aps,rt);hold on;
plot(aps,lt);hold on;
set(gca,"XScale","log");
xlim([0.1,3])
%%
ap=1;
rt=[];lt=[];
 for j=1:length(grs)
     gr=grs(j);
rt(j)=fss(6,ap,gr,'r');
lt(j)=fss(6,ap,gr,'l');
 end

plot(grs,rt);hold on;
plot(grs,lt);hold on;
