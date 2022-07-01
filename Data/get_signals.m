 function get_signals()
bkg_dir="./segment/";
gfp_dir="./refined/gfp/";
mch_dir="./refined/rfp/";
ana_dir="./refined/signal/";
open_dir="./refined/open/";
files=dir(bkg_dir+"*.tif");
files={files.name};
lens=[];
for i = 1:length(files)
    

    
filename=files{i};
if (filename(1:5)~="11412" && filename(1:5)~="11414" &&filename(1:5)~="11415")
    continue
end

Io2=imread(bkg_dir+filename);
Io2=imresize(Io2,[512,672]);

itap2=imread(mch_dir+filename);
itap2=imresize(itap2,[512,672]);


ikinA=imread(gfp_dir+filename);
ikinA=imresize(ikinA,[512,672]);

iopen=imread(open_dir+filename);
iopen=imresize(iopen,[512,672]);


io2=rgb2gray(Io2);


bw= im2bw(io2,graythresh(io2));


conn= bwconncomp(bw,4);
c=conn.PixelIdxList;

sig.signal1=[];
sig.signal2=[];
sig.area=[];

n1=ikinA; n2=itap2;
noise1=mean((double(n1(bw==0))));
noise2=mean((double(n2(bw==0))));
sig.noise1=std((double(n1(bw==0))));
sig.noise2=std((double(n2(bw==0))));


for i =1:length(c)

sig.signal1(i)=max(mean(ikinA(c{i}))-noise1,0);
sig.signal2(i)=max(mean(itap2(c{i}))-noise2,0);

% if sig.signal2(i)/length(c{i})>0.001  && (filename(1:5)=="11412")
%     labelr=iopen;
%     labelg=iopen;
%     labelb=iopen;
%     
%     labelg(c{i})=labelg(c{i})+ikinA(c{i}).*10;    
%     labelr(c{i})=labelr(c{i})+itap2(c{i}).*10;
% 
%     label(:,:,1)=labelr;
%     label(:,:,2)=iopen;
%     label(:,:,3)=iopen;
%     
%     lg(:,:,1)=iopen;
%     lg(:,:,2)=labelg;
%     lg(:,:,3)=iopen;
%     
%     imwrite(label,"./peek/"+filename(1:end-4)+"-"+num2str(i)+"-r.tif");
%     imwrite(lg,"./peek/"+filename(1:end-4)+"-"+num2str(i)+"-g.tif");
% end


sig.area(i)=length(c{i});
sig.std(i)=std(double(itap2(c{i})));

end
filename

save(ana_dir+filename(1:end-4)+'.mat','sig');

end

end