% Load the CNN learned before
vl_setupnn;
load('learned_net1.mat');
n = 10;
indices = randperm(70000,n);
imdb = load('imdb.mat');
% Load the sentence
images = imdb.images.data(:,:,:,indices);
labels = imdb.images.labels(indices);

for i = 1:n
    res = vl_simplenn(net, images(:,:,:,i));
   
end

% Visualize the results
