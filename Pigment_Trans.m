function [ l,lg ] = Pigment_Trans( input)
%pigment transtion Summary of this function goes here
%Detailed explanation goes here
%this function used to calculate mean&variance of the gradient of luminace
%of pigment transtion
map=imread(input);
hsv=rgb2hsv(map);
L=hsv(:,3);
[Gmag] = imgradient(L,'prewitt');
l=mean2(Gmag);
lg=var(Gmag);
end
