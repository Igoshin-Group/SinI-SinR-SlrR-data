
% map:0.2->0.6

means=[17.4769,43.959,57.6615,53.5179,14.3077,29.2564,38.6667,32.8462,16.1795,28.1036,31.5385,27.8205];

ts=[4,6,8,12];strs=["gr_change_n100","full_dc","full_da"];count=1;
for s=strs
for t =ts
    fname=s+"_time_"+num2str(t)+".mat";
    load(fname);
    subplot(3,4,count);
    XCenter=edges(2:end)-(edges(2)-edges(1))/2;
    label=TapA(1);
    TapA(TapA>0.2)=0.6+(TapA(TapA>0.2)-0.2)*0.4;
    TapA(TapA<0.2)=(TapA(TapA<0.2))*3;
    bar(XCenter,TapA,1);
    set(gca,'YTick',[0.3,0.6,TapA(1)]);
    set(gca,'YTickLabel',{0.1,0.2,label});
    meant=means(count);
    count=count+1;
    ylim([0,1]);
    xlim([-5,600]);
    xlabel('tapA')
    ylabel('Freq')
    title(meant*20)
    end
    
end
%%

strs=["wt","dc","da"];count=1;
for s=strs
for t =ts
    fname="no_gr_noise_"+s+"_time_"+num2str(t)+".mat";
    load(fname);
    subplot(3,4,count);
    XCenter=edges(2:end)-(edges(2)-edges(1))/2;
    label=TapA(1);
    TapA(TapA>0.2)=0.6+(TapA(TapA>0.2)-0.2)*0.4;
    TapA(TapA<0.2)=(TapA(TapA<0.2))*3;
    bar(XCenter,TapA,1);
    set(gca,'YTick',[0.3,0.6,TapA(1)]);
    set(gca,'YTickLabel',{0.1,0.2,label});
    meant=sum(TapA(2:end).*(edges(2:end-1)+edges(3:end))./2);
    count=count+1;
    ylim([0,1]);
    xlim([-5,600]);
    xlabel('tapA')
    ylabel('Freq')
    title(meant*20)
end
end
