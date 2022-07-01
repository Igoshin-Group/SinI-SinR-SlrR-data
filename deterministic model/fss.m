function s = fss(no,ap,gr,ir)
%no: species order
%out:steady-state value
n=config('SinIR.txt');

xi=zeros(1,n);
if ir=='r'
xi(6)=1000;
else 
xi(3)=1000;    
end
 [t,y]=ode15s(@(t,x)SinIR(t,x,ap,gr),[0,100],xi);
 s=[];
 for i=1:length(no)
s=[s y(end,no(i))];
 end
 
end
