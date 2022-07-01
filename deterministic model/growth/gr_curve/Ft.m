function dnc=Ft(nc,kc,vm,Kn,kn2,k2,K2,h)

% n-nutrient   c-cell    dnc-[dn,dc] nc-[n,c]
n=nc(1,:);
c=nc(2,:);
dn=-c.*kc*(vm*(n.^h/(n.^h+Kn.^h))-kn2*K2.^k2./(K2^k2+n.^k2));
dc=c.*(vm*(n.^h/(n.^h+Kn.^h))-kn2*K2.^k2./(K2^k2+n.^k2));
% kc:the nutrient consuming rate
% vm: maximum growth rate
% Kn: half-maximum level of nutrient for growth
% kd: death rate
% Kd/m : suppose the death rate is determained by nutrient level in hill
% manner
% kn2 k2 K2: suppose there is a negative effect of the cell density on the
% generic growth rate
dnc=[dn ;dc];
end