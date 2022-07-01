

function cpnumber(gr,pos1,pos2)
tr_time=0.78+0.15./gr;
cyc_time=0.69./gr;


dup_time=tr_time*pos1;
t=[0,dup_time,cyc_time];
c=[1,2,2];
figure('Renderer', 'painters', 'Position', [10 10 300 150]);
stairs(t,c,"LineWidth",1); hold on;


dup_time=tr_time*pos2;
t=[0,dup_time,cyc_time];
c=[1,2,2];

stairs(t,c,"LineWidth",1);

ylim([0,3]);
xlim([0,cyc_time])
xlabel("time (h)");
ylabel("copy number");
legend(["pos="+pos1,"pos="+num2str(pos2)])
title("gr="+num2str(gr));

end