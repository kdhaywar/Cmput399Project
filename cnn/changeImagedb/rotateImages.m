%Takes the image data matrix from the MNIST database
%and creates a new image data matrix which consists
%of the original matrix and a new data matrix of
%the original images rotated 5 to 15 degrees

load('imdb.mat');
rImages.data = zeros(size(images.data));

for i=1:length(images.data)
    angle = randi(10)+5;
    im = images.data(:,:,:,i);
    imr = imrotate(im,angle);
    imr = imresize(single(imr), [28 28]);
    rImages.data(:,:,:,i) = imr;    
end

images.data(:,:,:,70001:140000) = single(rImages.data);
images.data_mean = single(mean(images.data, 4));
images.labels = [images.labels,images.labels];
images.set = [images.set,images.set];
meta.sets = meta.sets;
meta.classes = meta.classes;
save('imdbExtended.mat','-regexp','^images','^meta');