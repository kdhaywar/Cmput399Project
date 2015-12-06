%Experiment with the cnn_mnist_fc_bnorm
%[net_fc, info_fc] = cnn_mnist(@cnn_mnist_init_linear,'expDir', 'data/mnist-linear', 'useBnorm', false);
[net_bn, info_bn] = cnn_mnist(@cnn_mnist_lenet,'expDir', 'data/mnist-lenet', 'useBnorm', false);
%[net_fc, info_fc] = cnn_mnist(@cnn_mnist_init_test1,'expDir', 'data/mnist-test1', 'useBnorm', false);
%[net_fc, info_fc] = cnn_mnist(@cnn_mnist_init_test2,'expDir', 'data/mnist-test2', 'useBnorm', false);
%[net_fc, info_fc] = cnn_mnist(@cnn_mnist_init_test3,'expDir', 'data/mnist-test3', 'useBnorm', false);

%Experiments Tests with data augmentations 
%TODO


% figure(1) ; clf ;
% subplot(1,2,1) ;
% semilogy(info_fc.val.objective, 'k') ; hold on ;
% semilogy(info_bn.val.objective, 'b') ;
% xlabel('Training samples [x10^3]'); ylabel('energy') ;
% grid on ;
% h=legend('BSLN', 'BNORM');
% set(h,'color','none');
% title('objective') ;
% subplot(1,2,2) ;
% plot(info_fc.val.error, 'k') ; hold on ;
% %plot(info_fc.val.top5e, 'k--') ;
% plot(info_bn.val.error, 'b') ;
% %plot(info_bn.val.topFiveError, 'b--') ;
% h=legend('BSLN-val','BSLN-val-5','BNORM-val','BNORM-val-5') ;
% grid on ;
% xlabel('Training samples [x10^3]'); ylabel('error') ;
% set(h,'color','none') ;
% title('error') ;
% drawnow ;