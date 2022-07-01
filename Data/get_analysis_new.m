load('signal.mat');


data=[mean(signal(1).("wt")),mean(signal(3).("wt")),mean(signal(2).("wt")),0,0,mean(signal(1).("ds")),mean(signal(3).("ds")),mean(signal(2).("ds")),0,0,mean(signal(1).("dc")),mean(signal(3).("dc")),mean(signal(2).("dc"))];
x=1:13;
bar(x,data);

err= [std(signal(1).("wt")),std(signal(3).("wt")),std(signal(2).("wt")),0,0,std(signal(1).("ds")),std(signal(3).("ds")),std(signal(2).("ds")),0,0,std(signal(1).("dc")),std(signal(3).("dc")),std(signal(2).("dc"))];

hold on;
er = errorbar(x,data,err,"k.");    

ylim([0,0.8])

set(gca, 'XTickLabel', {'wt' 'wt','wt','','','ds' 'ds','ds','','','dc' 'dc','dc'})

%%
[h,p]=ttest(signal(1).("wt"),signal(3).("wt"))
[h,p]=ttest(signal(1).("ds"),signal(3).("ds"))
[h,p]=ttest(signal(1).("dc"),signal(3).("dc"))
[h,p]=ttest(signal(1).("wt")./signal(3).("wt"),signal(1).("ds")./signal(3).("ds"))
[h,p]=ttest(signal(1).("wt")./signal(3).("wt"),signal(1).("dc")./signal(3).("dc"))



