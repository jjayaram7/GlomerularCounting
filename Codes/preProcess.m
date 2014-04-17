
% close all

image_number = 190;
path1 = 'C:\Users\Berk\Desktop\images\';   % input folder
path3 = 'C:\Users\Berk\Desktop\images\';   % output folder

ii = image_number;
if length(num2str(ii)) == 2
    name1 = ['B00' num2str(ii) '.bmp'];
    name2 = ['B00' num2str(ii) '_cropped.bmp'];
elseif length(num2str(ii)) == 3
    name1 = ['B0' num2str(ii) '.bmp'];
    name2 = ['B0' num2str(ii) '_cropped.bmp'];
else
    name1 = ['B000' num2str(ii) '.bmp'];
    name2 = ['B000' num2str(ii) '_cropped.bmp'];
end
path2 = [ path1 name1 ];

I = imread(path2);
BW = roipoly(I);
a = true(256);
b = ~(a & BW);
% b = logical(a - BW);
I(b) = 0;
imshow(I)

imwrite(I, name2, 'bmp');
if ~strcmp( path1, path3 )
    movefile(name2, path3);
end