function er = fError(para)
    er=0;
    th1=get_ap_th(0.7,para);
    if th1<0.1
    er=er+1000000;
    end
    er=er+(th1-0.1)^2*10000;
    
    th2=get_ap_th(0.05,para);
    
    if th2<3
            er=er+100000;
    end
    
    th3=get_ap_th(0.15,para);
    if th3>0.6
            er=er+10000;
    end
    er=er+(th3-0.3)^2*5000;

end

