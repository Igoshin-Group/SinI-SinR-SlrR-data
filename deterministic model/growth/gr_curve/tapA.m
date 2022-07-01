function tap = tapA(v0,gr,K,k,n,spo0A,K2,n2,k2)
%TAPA Summary of this function goes here
%   Detailed explanation goes here
tap=v0+k.*gr.^n./(K.^n+gr.^n).*spo0A.^n2./(spo0A.^n2+K2.^n2);

end

