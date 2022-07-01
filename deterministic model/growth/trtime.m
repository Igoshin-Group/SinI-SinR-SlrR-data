
gr=0.1:0.02:0.8;
tr_time=0.78+0.15./gr;
cyc_time=0.69./gr;
plot(gr,tr_time,"LineWidth",1);hold on;
plot(gr,cyc_time,"LineWidth",1);
xlabel("growth rate (1/h)");
ylabel("duration (h)");
legend(["C period (replication)","cell cycle"])
%%
