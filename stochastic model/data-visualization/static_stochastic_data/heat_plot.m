figure;
%scatter(sinR_t,slrR_d)


aps=[0,0.5,2];grs=[0.1,0.2,0.5];count=1;
for ap =aps
    for gr=grs
fname="test_r_"+num2str(gr)+"_ap_"+num2str(ap)+".mat";
    load(fname);
    subplot(4,3,count);
    count=count+1;
   [n,c]=hist3(log(rand(size([sinR_t;slrR_d]'))+double([sinR_t;slrR_d]')),'Edges',{0:0.2:8 0:0.2:8});
    contourf(c{1},c{2},n,[0,2,4,8,16,32,48,64])
    xlim([0,8]);
    ylim([0,8]);
    xlabel('SlrR (log scale)')
    ylabel('SinR (log scale)')
    end
    
end
subplot(4,3,count);

colorbar
