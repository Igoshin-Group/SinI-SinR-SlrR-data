set(0, 'DefaultLineLineWidth', 1);
%% 1 steady state
n=config('SinIR.txt');


tt=1:0.2:10;
global grs;
grs=gr_t(tt);

vas=[1,1,0,2,1];
vss=[1,0,1,1,1.5];
styles=["k-","r--","b-","r-","b--"];
for i=1:5
    va=vas(i);vs=vss(i);s=styles(i);
    tap=dtap(va,vs);
    plot(tt+1,tap,s);xlim([2,11]);hold on;
end
xlabel('Time(h)');
ylabel('TapA')
legend('WT','dsda','dkinA','kinA-overexpress','sda-overexpress')

%% 2 dynamics 
n=config('SinIR-traj.txt');


vas=[1,1,0,2,1];
vss=[1,0.2,1,1,1.5];

x0=zeros(1,n);
x0(11)=1000;

for i=1:5
    va=vas(i);vs=vss(i);s=styles(i);
     [t,y]=ode15s(@(t,x)SinIR(t,x,va,vs),[0,12],x0);
    plot(1+t,y(:,27),s);xlim([2,11]);hold on;
end
xlabel('Time(h)');
ylabel('TapA')
legend('WT','dsda','dkinA','kinA-overexpress','sda-overexpress')



%%

function x=dtap(va,vs)

global grs;
x=[];
for gr = grs
    x=[x fss(8,get_ap(gr,va,vs),gr,'i')];
end
end