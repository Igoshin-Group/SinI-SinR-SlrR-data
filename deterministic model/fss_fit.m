function s = fss_fit(ap,gr,ir,para)
%no: species order
%out:steady-state value
n=7;
xi=zeros(1,n);
if ir=='r'
xi(6)=1000;
else 
xi(3)=1000;    
end
 [~,y]=ode15s(@(t,x)SinIR(t,x,ap,gr,para),[0,100],xi);
s= y(end,7);
end
