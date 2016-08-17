function [fractal]=Fractal_Dim(input)
clc;
[I,bw]=Segmentation(input);

e2 = edge(bw,'canny');
figure(2)
imshow(e2)
 
 
Nx = size(e2,1);
Ny = size(e2,2);
 
for numBlocks = 1:25
     
    sizeBlocks_x = floor(Nx./numBlocks);
    sizeBlocks_y = floor(Ny./numBlocks); 
     
    flag = zeros(numBlocks,numBlocks);
    for i = 1:numBlocks
        for j = 1:numBlocks
            xStart = (i-1)*sizeBlocks_x + 1;
            xEnd   = i*sizeBlocks_x;
             
            yStart = (j-1)*sizeBlocks_y + 1;
            yEnd   = j*sizeBlocks_y;
             
            block = e2(xStart:xEnd, yStart:yEnd);
             
            flag(i,j) = any(block(:)); %mark this if ANY part of block is true
        end
    end
    boxCount = nnz(flag);
    table(numBlocks,1)    = numBlocks;
    table(numBlocks,2)    = boxCount;
end
 
 
x      = table(:,1);    % x is numBlocks
y      = table(:,2);    % y is boxCount
 
p      = polyfit(x,y,1);
BestFit = polyval(p,x);
 
figure(3)
hold on
grid on
plot(x,y,       'ko','LineWidth',1)
plot(x,BestFit, 'k-','LineWidth',2)
xlabel('Number of blocks, N','FontSize',12)
ylabel('Box Count, N(s)','FontSize',12)
 
 
% calculate Hausdorff Dimension
x2 = log(x);
y2 = log(y);
 
p2       = polyfit(x2,y2,1);
BestFit2 = polyval(p2,x2);
 
figure(4)
hold on
grid on
plot(x2,y2,       'bo','LineWidth',1)
plot(x2,BestFit2, 'b-','LineWidth',2)
xlabel('Number of blocks, log N','FontSize',12)
ylabel('Box Count, log N(s)'    ,'FontSize',12)
 
fractal = p2(:,1)
 
    
