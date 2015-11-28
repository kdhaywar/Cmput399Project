%%Main
%

close all;
clear all;
setup
%% KNN

[trainImg trainLabel testImg testLabel] = loadData();
Xtrain = get_features(trainImg);
Xtest = get_features(testImg);

kmin = 1;
kmax = 8;
ks = [kmin:kmax];

error = cross_validate_knn(Xtrain,trainLabel,ks,10);
[val,ind] = min(error);
k = ks(ind);

kdtree = vl_kdtreebuild(Xtrain);
y = PredictDigit(Xtrain,trainLabel,Xtest,k,'mode');

%ei = mean(abs(y-testLabel));
c = sum(y == testLabel);

correct = c / length(testLabel);
wrong = (length(testLabel) - c) / length(testLabel);


