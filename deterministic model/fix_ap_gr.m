n=config('SinIR.txt');
sol1=[];sol2=[];sol3=[];
grs=0.04:0.04:0.8;
ap=2;
 for j=1:length(grs)
     j
     gr=grs(j);
sol=det_ana(ap,gr);
if length(sol)==1
    if sol(1)<20
    sol1=[sol1 [gr,sol(1)]'];
    else
    sol3=[sol3 [gr,sol(1)]'];
    end
else
    if length(sol)==3
        sol=sort(sol);
        sol1=[sol1 [gr,sol(1)]'];
        sol3=[sol3 [gr,sol(3)]'];
        sol2=[sol2 [gr,sol(2)]'];
    end
end


 end

%%
plot(sol1(1,:),sol1(2,:));hold on;
plot(sol2(1,:),sol2(2,:));hold on;
plot(sol3(1,:),sol3(2,:));hold on;

%%
hold on;
% plot_aps;

%%
