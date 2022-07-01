ts=0:0.2:10;
plot(ts,gr_t(ts));
hold on;

plot(ts,gr_t_alter(ts));

%%

plot(ts,gr_t(ts));
hold on;
plot(ts,1./(1./gr_t(ts)+0.3*1./gr_t(ts)),"--");
hold on;
plot(ts,1./(1./gr_t(ts)-0.3*1./gr_t(ts)),"--");
