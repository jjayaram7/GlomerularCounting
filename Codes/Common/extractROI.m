function [ROI1 Image] = extractROI(Image)

H = imrect;
mask = createMask(H);

minval = find(mask,1);
maxval = find(mask,1,'last');
[m n] = size(Image);
x1 = mod(minval, m);
y1 = floor((minval/m) + 1);
x2 = mod(maxval, m);
y2 = floor((maxval/m) + 1);

Image = Image .* mask;

ROI1 = Image(x1:x2,y1:y2);
% 

