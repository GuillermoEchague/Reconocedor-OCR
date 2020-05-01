function [L,numComponents] = bwlabel1(BW,mode)
%BWLABEL Label connected components in 2-D binary image.

validateattributes(BW, {'logical' 'numeric'}, {'real', '2d', 'nonsparse'}, ...
              mfilename, 'BW', 1);

if (nargin < 2)
    mode = 8;
else
    validateattributes(mode, {'double'}, {'scalar'}, mfilename, 'N', 2);
end

if ~islogical(BW)
    BW = BW ~= 0;
end

[startRow,endRow,startCol,labelForEachRun,numComponents] = ...
    labelBinaryRuns(BW,mode);

% Given label information, create output matrix.
L = bwlabel2(startRow,endRow,startCol,labelForEachRun,size(BW,1), ...
    size(BW,2));
