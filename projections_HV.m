%Loading the image
imname = 'test';
inputfile = [imname, '.png'];
A = imread(inputfile);

%Checking the image dimensions
[m,n] = size(A);
disp(m)
disp(n)

%Computing the row and column sums
colsum = 1:n;
rowsum = 1:m;

for i = 1:n
   colsum(i) = (sum(A(:,i)));
   rowsum(i) = (sum(A(i,:)));
end

%Saving row and column sums
projfile = [imname, '_HVproj', '.mat'];
save(projfile, 'colsum', 'rowsum');