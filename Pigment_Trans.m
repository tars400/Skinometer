function [ l,lg ] = Pigment_Trans( input)
map=imread(input);
hsv=rgb2hsv(map);
L=hsv(:,3);
[Gmag] = imgradient(L,'prewitt');
l=mean2(Gmag);
lg=var(Gmag);
end
