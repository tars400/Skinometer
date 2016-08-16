function [ DIA ] = Diameter( input )
 
[I,bw]=segmentation(input);
m=imcomplement(bw);
ma=regionprops(m,'majoraxislength');
mi=regionprops(m,'MinorAxisLength');
max=ma.MajorAxisLength;
min=mi.MinorAxisLength;
if(max>=min)
    DIA=min;
end
 
            