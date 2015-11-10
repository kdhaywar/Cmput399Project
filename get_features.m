function X = get_features(M)
%Returns feature vectors for all images
%as columns of X, Uses image histogram 
%as feature vector 

    [m,n,d] = size(M);
    b = 128;
    X = zeros(b,d);
    
    for i = 1:d
        [counts,centers] = hist(M(:,:,i),b);
        %divide by area to normalize histogram
        f = counts/trapz(centers, counts);
        X(:,i) = f;
    end
    
    
end

