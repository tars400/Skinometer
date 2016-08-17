function [Asymmtry,CI]=Asym(input)
[I,bw]=Segmentation(input);
a=imcomplement(bw);
plp=regionprops(a,'perimeter');
pl=regionprops(a,'centroid');
pp=plp.Perimeter;
p=pl.Centroid(:,1);
pc=pl.Centroid(:,2);
p=round(p);
pc=round(pc);
a1=a(:,1:p);
a2=a(:,p+1:end);
[m n]=size(a);
r=m-p;
if(p<=r)
  p1= r-p;
   b1=a1;
   b4=p+p1;
   b1(:,p+1:b4)=0;
   b1 = circshift(b1,[0 p1]);
   a1=b1;
else
p2= p-r;
   b2=a2;
   b3=r+p2;
   b2(:,r:b3)=0;
   a2=b2; 
end
a3=fliplr(a2);
a4=xor(a1,a3);
subplot(2,2,1)
 imshow(a1)
 subplot(2,2,2)
 imshow(a2)
a5=bwarea(a4);
a6=bwarea(a);
AI1=(a5)/a6;
a7=a(1:pc,:);
a8=a(pc+1:end,:);
r1=n-pc;
if(pc<=r1)
    p3=r1-pc;
    b5=pc+p3;
    b6=a7;
    b6(pc+1:b5,:)=0;
    a7=b6;
    a7 = circshift(a7,[p3 0]);
else
    p4=pc-r1;
    b7=r1+p4;
    b8=a8;
    b8(r1:b7,:)=0;
    a8=b8;
end
a9=flipud(a8);
a10=xor(a7,a9);

a11=bwarea(a10);
AI2=(a11)/a6;
AI=(AI1+AI2)/2;
CI=(pp*pp)/(4*pi*a6);
 Asymmtry=1.3*AI;
