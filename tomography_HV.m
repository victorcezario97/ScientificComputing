%Loading projection data
imname = 'test';
projfile = [imname, '_HVproj', '.mat'];
load(projfile, 'colsum', 'rowsum');

%Kaczmarz algorithm


MAX_ITER = 150;
e = 0.1;
[m,n] = size(colsum);
finit = zeros(n,n);

for k = 1:MAX_ITER
    
    fold = finit;
    for i = 1:n
        b = computeBeta(fold, i, colsum);
        auxcol = ones(n, 1)*b;
        fnew = fold;
        fnew(:, i) = fnew(:, i) - auxcol;
        %fnew = max(fnew, zeros(n, n));
        %fnew = min(fnew, ones(n,n));
        fnew = minMax(fnew);
    end
    fold = fnew;
    
    for j = 1:n
        b = computeBeta(fold, j, rowsum);
        auxrow = ones(1, n)*b;
        fnew = fold;
        fnew(j, :) = fnew(j, :) - auxrow;
        fnew = minMax(fnew);
    end
    
    delta = abs(sum(fnew)-sum(finit))/(n^2);
    if delta < e
       break 
    end
    
    finit = fnew;
end

round(fnew);

recfile = [imname, '_HVrec_', '_150=', int2str(e), '.png'];
imwrite(fnew, recfile);

%Function to compute the value of Beta
function b = computeBeta(f, i, p)
    [~,n] = size(p);
    b = (sum(f(:,i)) - p(i))/n;
end

function f = minMax(matrix)
    [n, ~] = size(matrix);
    f = max(matrix, zeros(n, n));
    f = min(matrix, ones(n,n));
end