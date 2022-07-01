function ap = get_ap(gr,va,vc,vs)
%no: species order
%out:steady-state value
fname="a"+va+"s"+vs+'.mat';
if isfile("cache/"+fname)
else
n=config('Spo0A.txt');
xi=zeros(1,n);

 [t,y]=ode15s(@(t,x)Spo0A(t,x,gr,va,vc,vs),[0,40],xi);
 
 ap=y(end,11);
end
end

