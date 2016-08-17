function [black ,white ,red ,blue ,dark_brown ,light_brown,yellow,green,cyan,magenta] = Color_Histo( input )
I = imread(input);
[index,map] = rgb2ind(I,1024);
pixels = prod(size(index));
hsv = rgb2hsv(map);
h = hsv(:,1);
s = hsv(:,2);
v = hsv(:,3);
%Finds location of black and white pixels
darks = find(v < .2)';
lights = find(s < .05 & v > .85)';
h([darks lights]) = -1;
%Gets the number of all pixels for each color bin
black = length(darks)/pixels;
white = length(lights)/pixels;
red = length(find((h > .9167 | h <= .083) & h ~= -1))/pixels;
yellow = length(find(h > .083 & h <= .25))/pixels;
green = length(find(h > .25 & h <= .4167))/pixels;
cyan = length(find(h > .4167 & h <= .5833))/pixels;
blue = length(find(h > .5833 & h <= .75))/pixels;
magenta = length(find(h > .75 & h <= .9167))/pixels;
dark_brown = length(find((h >0.9694  | h <= 0.1361) & h ~= -1))/pixels;
light_brown = length(find((h >0.9722  | h <= 0.1388) & h ~= -1))/pixels;
end
