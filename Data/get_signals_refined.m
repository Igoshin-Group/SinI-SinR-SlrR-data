 function get_signals_refined()
bkg_dir="./segment/";
gfp_dir="./GFP/";
mch_dir="./RFP/";
ana_dir="./signal/";

files=dir(bkg_dir+"*.tif");
files={files.name};
lens=[];
for i = 1:length(files)
filename=files{i};
Io2=imread(bkg_dir+filename);
Io2=imresize(Io2,[512,672]);

itap2=imread(mch_dir+filename);
itap2=imresize(itap2,[512,672]);


ikinA=imread(gfp_dir+filename);
ikinA=imresize(ikinA,[512,672]);




background=0;
tind=regexp(filename,'T[0-9]');
t=str2num(filename(tind+1));

io2=rgb2gray(Io2);


 


bw= im2bw(io2,graythresh(io2));


conn= bwconncomp(bw,4);
c=conn.PixelIdxList;

sig.signal1=[];
sig.signal2=[];
sig.area=[];

sig.noise1=mean(mean(ikinA));
sig.noise2=mean(mean(itap2));
for i =1:length(c)
sig.signal1(i)=max(mean(ikinA(c{i})),0);
sig.signal2(i)=max(mean(itap2(c{i})),0);
itap2(c{i})=0;
sig.noise1=sig.noise1-(mean(ikinA(c{i}))-sig.noise1)*length(c{i})/512/672;
sig.noise2=sig.noise2-(mean(itap2(c{i}))-sig.noise2)*length(c{i})/512/672;
lens(end+1)=double(length(c{i}));
sig.area(i)=length(c{i});
sig.std(i)=std(double(itap2(c{i})));




end


save(ana_dir+filename(1:end-4)+'.mat','sig');

end

end