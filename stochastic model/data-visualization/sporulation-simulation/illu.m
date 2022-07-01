n=16;
F=@(x,th)x.^n./(x.^n+th.^n);
n1=2;n2=16;
F2=@(x,th1,th2)x.^n1./(x.^n1+th1.^n1).*th2.^n2./(x.^n2+th2.^n2);
xx=0:0.01:5;
plot(xx,F(xx,3.4));hold on;
plot(xx,F(xx,2.7));hold on;
plot(xx,F2(xx,1,3));