gr=0.1:0.05:1;
slrr=fglobal(gr,0.3)./(gr+0.6);
sinr=fglobal(gr,0.85)./(gr+0.2)/1.2;

slrr=slrr./sinr(end);
sinr=sinr./sinr(end);
plot(gr,sinr./slrr,'r-');hold on;plot(gr,gr.*0+1,'k--')

ylabel("[SinR]/[SlrR] Ratio")