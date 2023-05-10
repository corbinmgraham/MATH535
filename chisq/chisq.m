function y = chisq(B)%input vector of gray values (can be just red, green or blue)
 
%A is a matrix representative of the percent of the function for which we
%are taking the chi-squared distribution
counts = zeros(256,1);
for h=1:length(B)
    counts((B(h,1)+1),1)=counts(B(h,1)+1,1)+1;
end
 
%creates a matrix.  First column is actual even values (times -1).  Second
%column is average of PoV.
chiClass = zeros(128, 2);
for n = 1:128
    chiClass(n, 1) = -1*counts(2*n); %actual even values
    chiClass(n, 2) = (counts(2*n) + counts(2*n -1))/2; %estimated values
end
 
%combining bins.  First combines a bin with its neighbor to its right until
%a bin of atleast 5 is encountered.  Then combines a bin with its neighbor
%to its left.
k = 128;
m=1;
while (chiClass(m, 2)) < 5
    chiClass(m+1,:) = chiClass(m, :)+chiClass(m+1, :);
    chiClass(m,:) = [1 -1];
    m= m+1;
    k=k-1;
end
for i = (128-k+1): 128
    if chiClass(i,2) < 5
        chiClass(i,:) = chiClass(i,:) + chiClass(i-1,:);
        chiClass(i-1,:) = [1 -1];
        k=k-1;
    end
end
 
sum = 0;
for q = 1:128
   sum = sum + ((chiClass(q,1) + chiClass(q,2))^2)/chiClass(q,2);
end
y = 1 - (chi2cdf(sum,k-1));
 
