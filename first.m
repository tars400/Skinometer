%----------------------------------
 
%clear all
%close all
%clc
%k parameter can be changed to adjust intensity of image
ei=25;
st=35;
%k=10
k=ei*st;
I = imread('benign3.bmp');
%h=filter matrx
h = ones(ei,st) / k;
I1 = imfilter(I,h,'symmetric');
figure
subplot(2,2,1),imshow(I), title('Original image');%1
subplot(2,2,2), imshow(I1), title('Filtered Image');%1
IG=rgb2gray(I1);
%Converting to BW(black and white)
I11 = imadjust(IG,stretchlim(IG),[]);
level = graythresh(I11);
BWJ = im2bw(I11,level);
dim = size(BWJ)
IN=ones(dim(1),dim(2));
BW=xor(BWJ,IN);  %inverting
subplot(2,2,3), imshow(BW), title('Black and White');%1
%Finding of initial point
row = round(dim(1)/2);
col = min(find(BW(row,:)))
%Tracing
boundary = bwtraceboundary(BW,[row, col],'W');
subplot(2,2,4),imshow(I), title('Traced');%1
hold on;
%Display traced boundary
plot(boundary(:,2),boundary(:,1),'g','LineWidth',2);
hold off
% figure
% plot(boundary(:,2),boundary(:,1),'black','LineWidth',2);
 
nn=size(boundary);
KM=zeros(dim(1),dim(2));
 ii=0;
 %Create new matrix with boundary points. there fore we can get rid off
 %other distortions outside boundaries
 while ii<nn(1)
     ii=ii+1;
    KM(boundary(ii,1),boundary(ii,2))=1;
end
 figure
 subplot(2,2,1),plot(boundary(:,2),boundary(:,1),'black','LineWidth',2);%2
 subplot(2,2,2),imshow(KM)%2
%Fill inner boundaries where lesion is located
KM2 = imfill(KM,'holes');
subplot(2,2,3),imshow(KM2)%2
KM1=xor(KM2,IN);
% subplot(2,2,4),imshow(KM1)
%Geometrical center
IVx=[1:dim(2)];
IVy=[1:dim(1)];
IMx=ones(dim(1),1)*IVx;
IMy=ones(dim(2),1)*IVy;
IMy = imrotate(IMy,-90);
Koordx=IMx.*KM2;
Koordy=IMy.*KM2;
xmean=mean(Koordx,2);
yc=round(sum(xmean.*IMy(:,1))/sum(xmean));
ymean=mean(Koordy);
xc=round(sum(ymean.*IVx)/sum(ymean));
figure
imshow(I)%3
try0=mean2(I)
try01=std2(I)
hold on
i1=plot(boundary(:,2),boundary(:,1),'green','LineWidth',2);
i1
i2=mean2(i1)
hold on
plot(xc,1:dim(1),'red','LineWidth',2);
plot(1:dim(2),yc,'red','LineWidth',2);
hold off
% ID=im2double(I);
ID1(:,:,1)=im2double(I(:,:,1));
ID1(:,:,2)=im2double(I(:,:,2));
ID1(:,:,3)=im2double(I(:,:,3));
 figure
subplot(2,2,1), imshow(ID1);%4
subplot(2,2,2), imshow(ID1(:,:,1));%4
hold on
plot(xc,1:dim(1),'red','LineWidth',2);
plot(1:dim(2),yc,'red','LineWidth',2);
hold off
subplot(2,2,3), imshow(ID1(:,:,2));%4
subplot(2,2,4), imshow(ID1(:,:,3));%4
 try1=mean2(ID1)
 try2=std2(ID1)
%---------------------------------