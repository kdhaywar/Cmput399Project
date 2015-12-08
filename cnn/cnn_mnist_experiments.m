%Based off cnn_mnist_experiments from https://github.com/vlfeat/matconvnet/tree/master/examples
%on Nov 20 2015
%Experiment with the cnn_mnist
[net_lenet, info_lenet] = cnn_mnist(@cnn_mnist_init_lenet,'expDir', 'data/mnist-lenet','imdbPath','imdb.mat','useBnorm', false);
[net_1, info_1] = cnn_mnist(@cnn_mnist_init_test1,'expDir', 'data/mnist-test1','imdbPath','imdb.mat','useBnorm', false);
[net_2, info_2] = cnn_mnist(@cnn_mnist_init_test2,'expDir', 'data/mnist-test2','imdbPath','imdb.mat','useBnorm', false);
[net_3, info_3] = cnn_mnist(@cnn_mnist_init_test3,'expDir', 'data/mnist-test3','imdbPath','imdb.mat', 'useBnorm', false);

x = [1:20]

plot(x,info_lenet.val.error(1,:),'b--x');hold on;
plot(x,info_1.val.error(1,:),'r--o');hold on;
plot(x,info_2.val.error(1,:),'k--*');hold on;
plot(x,info_4.val.error(1,:),'m--+');hold on;
legend('LeNet','test1','test2','test3');