function apth = get_ap_th(gr,para)
%GET_AP_TH  get the threshold of ap to activate the system(bistable)
for ap = 0.05:0.05:2
    if det_ana_fit(ap,gr,para)<10
        apth=ap;
        return
    end
end
apth=3.5;
end

