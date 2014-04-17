function stats = blobcount(aa2)

aa3 = logical(aa2);
[m n] = size(aa2);

%countarr = zeros(m,n);

% count = 1;
% for i1 = 1:m
%     for i2 = 1:n
%         if (aa3(i1,i2) == 1)
%             if ((countarr(i1-1,i2) > 0) || (countarr(i1-1,i2-1) > 0) || (countarr(i1,i2-1) > 0))
%                 countarr(i1,i2) = count;
%             else
%                 count = count+1;
%                 countarr(i1,i2) = count;
%             end
%         end
%     end
% end

stats = regionprops(aa3,'PixelIdxList','Centroid');

