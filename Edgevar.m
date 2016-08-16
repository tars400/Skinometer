function [VI]=Edgevar(input)
[I,bw]=Segmentation(input);
M=imcomplement(bw);
[Nx,Ny]=size(M);
MM=zeros(Nx,Ny);
 
mx=0;
my=0;
for i=1:Nx
    for j=1:Ny
        if M(i,j)<1
            MM(i,j)=1;
            mx=mx+i;
            my=my+j;
        end
    end
end
% centroid 
mx=mx/sum(sum(MM));
my=my/sum(sum(MM));
D=zeros(Nx*Ny,1);
idx=0;
P=0;
e1=sqrt(0.5);
e2=1;
e3=2*e1;
% MM(i,j)+MM(i+1,j)*2+MM(i,j+1)*4+MM(i+1,j+1)*8;
T=filter2([1 4;2 8],double(MM),'same');
for i=1:Nx-1
    for j=1:Ny-1
        flag=T(i,j);
        if (flag==1 || flag==2 || flag==4 || flag==8)
            P=P+e1;
            idx=idx+1;
            D(idx)=sqrt((i+0.5-mx)^2+(j+0.5-my)^2);
        elseif (flag==3 || flag==10 || flag==12 || flag==5)
            P=P+e2;
            idx=idx+1;
            D(idx)=sqrt((i+0.5-mx)^2+(j+0.5-my)^2);
        elseif (flag==9 || flag==6)
            P=P+e3;
            idx=idx+1;
            D(idx)=sqrt((i+0.5-mx)^2+(j+0.5-my)^2);
        elseif (flag==11 || flag==14 || flag==13 || flag==7)
            P=P+e1;
            idx=idx+1;
            D(idx)=sqrt((i+0.5-mx)^2+(j+0.5-my)^2);
        end
    end
end
 
VI=var(D(1:idx)/mean(D(1:idx)));
VI
