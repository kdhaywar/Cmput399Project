% Load the CNN learned before
vl_setupnn;
load('net-epoch-20.mat');
[net_fc, info_fc] = cnn_mnist(@cnn_mnist_init_vgg,'expDir', 'data/mnist-vgg', 'useBnorm', true);
n = 10;
indices = randperm(70000,n);
disp(indices);
imdb = load('imdb.mat');
% Load the sentence
images = imdb.images.data(:,:,:,indices);
labels = imdb.images.labels(indices);
net.layers{end}.type = 'softmax';
for i = 1:n
    res = vl_simplenn(net, images(:,:,i));
    scores = squeeze(res(end).x) ;
    [bestScore, best] = max(scores) ;
    fprintf(1,'Best score : %f, Digit : %d\n',bestScore,best-1);
    %imshow(images(:,:,i));
    %pause;
end

