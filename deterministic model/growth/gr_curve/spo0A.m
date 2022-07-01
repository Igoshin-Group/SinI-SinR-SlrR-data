function spo = spo0A(v0,t,K,k,n)
%SPO0A_GROWTH Summary of this function goes here
%   Detailed explanation goes here
spo=v0+k.*t.^n./(K.^n+t.^n);

end

 