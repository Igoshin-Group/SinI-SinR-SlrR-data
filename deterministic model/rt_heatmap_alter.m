n=config('SinIR.txt');
rt=[];
grs=0.05:0.01:0.8;
aps=0.0:0.01:3.5;
% para: kdir,vi,vr,vl,Ki,Kl,kudi,kudr

para=[ 1.1661   24.9862   40.0000   80.2121    0.4    0.5  214.7179   39.6674];
for i=1:length(grs)
    i
 for j=1:length(aps)
     gr=grs(i);ap=aps(j);
rt(i,j)=fss(6,ap,gr,'l');
 end
end
save('rt.mat','rt')

%%
grs=0.05:0.01:0.8;
aps=0.0:0.01:3.5;
load('rt.mat','rt');
heatmap(grs,flip(aps),flip(log(rt),2)','GridVisible','off') ;
contourf(grs,aps,log(rt)',1);
xlabel('gr');
ylabel('ap');
%%

hold on;
plot_aps;

%%
