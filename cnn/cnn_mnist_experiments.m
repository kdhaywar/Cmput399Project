%Experiment with the cnn_mnist_fc_bnorm
[net_lin, info_lin] = cnn_mnist(@cnn_mnist_init_linear,'expDir', 'data/mnist-linear', 'useBnorm', false);
[net_lenet, info_lenet] = cnn_mnist(@cnn_mnist_lenet,'expDir', 'data/mnist-lenet', 'useBnorm', false);
[net_1, info_1] = cnn_mnist(@cnn_mnist_init_test1,'expDir', 'data/mnist-test1', 'useBnorm', false);
[net_2, info_2] = cnn_mnist(@cnn_mnist_init_test2,'expDir', 'data/mnist-test2', 'useBnorm', false);
[net_3, info_3] = cnn_mnist(@cnn_mnist_init_test3,'expDir', 'data/mnist-test3', 'useBnorm', false);

%Experiments Tests with data augmentations 
%TODO
x = [1:20]

plot(x,info_lin.val.error(1,:),'g'); hold on;
plot(x,info_lenet.val.error(1,:),'b');hold on;
plot(x,info_1.val.error(1,:),'r');hold on;
plot(x,info_2.val.error(1,:),'y');hold on;
plot(x,info_3.val.error(1,:),'p');hold on;
legend('Linear','LeNet','test1','test2','test3');