function ev = cross_validate_knn(X,y,ks,n)
% X: all feature vectors for all training set
% y: labels for training set
% ks: range of values of k 
% n: number of folds
% ev: mean error vector

[v,h] = size(X);
fn = floor(h/n); %size of each fold 
ev = zeros(length(ks),1);
index = 1;
for i = ks
    ei = zeros(1,n);
    for j = 1 : n
        %find range of current test fold, and extract into Xi , yi
        range = ((j-1)*fn+1):((j-1)*fn + fn);
        Xi  = X(:,range);
        yi  = y(range);
        
        %remove test range from training data 
        Xi_ = X;
        Xi_(:,range) = [];
        yi_ = y;
        yi_(range) = [];
       
        yip = PredictDigit(Xi_,yi_,Xi,i,'mode');
        %ei(j) = mean(abs(yi-yip));
        c = sum(yi==round(yip));
        ei(j) = (fn - c) / fn;
    end 
   ev(index) = mean(ei);
   index = index + 1;
end

