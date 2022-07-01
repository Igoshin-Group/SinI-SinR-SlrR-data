n=config('SinIR.txt');
rt=[];
grs=0.04:0.1:0.8;
aps=0.0:0.5:3;

for i=1:length(grs)
    i
 for j=1:length(aps)
     j
     gr=grs(i);ap=aps(j);
rt(i,j)=min(det_ana(ap,gr));
 end
end
save('rt.mat','rt')

%%
grs=0.04:0.1:0.8;
aps=0.0:0.5:3;
load('rt.mat','rt');
heatmap(grs,flip(aps),flip(log(rt),2)','GridVisible','off') ;
contourf(grs,aps,log(rt)',1);
xlabel('gr');
ylabel('ap');
%%
hold on;
% plot_aps;

%%
