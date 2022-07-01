a=0:1:300;
s=[  0.0000   46.4544  100.0918   99.6339    5.6179    0.7636  499.9976    4.6929    0.0000    2  47.2446];
para=s;
vs=para(1);
vt=para(2);
Ks=para(3);
ks=para(4);
ns=para(5);
Kt=para(6);
kt=para(7);
nt=para(8);
K2t=para(9);
n2t=para(10);
k2=para(11);
figure();

%plot(a,tapA(vt,a,Kt,kt,nt,spo0A(vs,a,Ks,ks,ns),K2t,n2t,k2));
%plot(a,spo0A(vs,a,Ks,ks,ns));
plot(a,tapA(vt,0.7636,Kt,kt,nt,a,K2t,n2t,k2),'LineWidth',2);
xlabel('[Spo0A~P]');
ylabel('tapA');
x37=[      5.0000    1.1602    2.0000    0.9367    3.3021    2.2228    1.0000  100.0000    0.0500    0.0000];

%PRINTTAP37 Summary of this function goes here
%   Detailed explanation goes here
vs=para(1);
vt=para(2);
Ks=para(3);
ks=para(4);
ns=para(5);
Kt=para(6);
kt=para(7);
nt=para(8);
K2t=para(9);
n2t=para(10);
k2t=para(11);
tap37_100=[44.50	57.60	110.42	177.34	380.29	469.87];
tap37_50=[54.39	61.01	112.63	143.23	191.27	143.02];
tap37_25=[45.40	57.23	102.48	77.04	49.61	22.12];
tap37_10=[29.31	38.83	58.97	56.49	58.77	45.43];
t0=[2,3,4,5,6,7];

in=1;
para=x37;
kc=para(1);
vm=para(2);
Kn=para(3);
kn2=para(4);
k2=para(5);K2=para(6);
h=para(7);
N0=para(8);C0=para(9);
Tau=para(10);
gr37_100=[    1.5777    0.8190    0.3804    0.2771    0.2390    0.2195];
gr37_50=[    1.5611    0.8229    0.3597    0.2354    0.1679    0.1054];
gr37_25=[    1.5145    0.8152    0.2319    0.0491    0.0088    0.0012];
gr37_10=[    1.3158    0.6605    0.0259    0.0006    0.0000    0.0000];

[t,x]=ode15s(@(t,x100)F(x100,kc,vm,Kn,kn2,k2,K2,h),[Tau,7],[N0/10,C0]);n=x(:,1);c=x(:,2);x=vm.*(n.^h./(n.^h+Kn.^h))-kn2.*c.^k2./(K2+c.^k2);

%x=kt.*x.^nt./(Kt.^nt+x.^nt);
x=k2t.*spo0A(vs,x,Ks,ks,ns).^n2t./(spo0A(vs,x,Ks,ks,ns).^n2t+K2t.^n2t);
%x=tapA(vt,x,Kt,kt,nt,spo0A(vs,x,Ks,ks,ns),K2t,n2t,k2t);
figure()
