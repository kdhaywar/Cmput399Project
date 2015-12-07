%Takes the image data matrix from the MNIST database
%and creates a new image data matrix which consists
%of the original matrix and a new data matrix of
%the original images filtered by an average filter

load('imdb.mat');
fImages.data = zeros(size(images.data));

h = fspecial('average');
for i=1:length(images.data)
    im = images.data(:,:,:,i);
    imf = imfilter(im,h);
    fImages.data(:,:,:,i) = imf;    
end

images.data_mean = single(mean(fImages.data, 4));
images.data = single(fImages.data);
images.labels = images.labels;
images.set = images.set;
meta.sets = meta.sets;
meta.classes = meta.classes;
save('imdbFiltered.mat','-regexp','^images','^meta');