function yt = PredictDigit(X, y, Xt, k, combine_method)
% This function returns predicted yt for test data Xt
% It uses k nearest neighbor with training data (X, y) and parameter value k

    kdtree = vl_kdtreebuild(X);
    [m,n] = size(Xt);

    % returns the k nearest neighbours index values and distances 
    %used a small max number of comparisons to speed up runtime time    
    [index,distance] = vl_kdtreequery(kdtree, X, Xt, 'NumNeighbors',k);
    if k == 1
        yt = y(index);  
    else if strcmp(combine_method, 'mean')
        %return mean of k nearest neighbours 
        yt = mean(y(index),1)'; 
    else
        yt = mode(y(index),1)';
    end
end