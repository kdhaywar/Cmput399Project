function [trainImg trainLabel testImg testLabel] = loadData(reload)
% Description:
% Reads both test and training images and labels and saves them to .mat
% files in /data if they do not already exist.  If they already exist
% then just loads .mat files
%
% Usage:
% [imgs labels] = loadDate(reload)
%
% Parameters:
% reload = optional parameter if reload = 'reload' then loadData will
%           delete existing .mat files and reload them
%
% Returns:
% trainImg = 20 x 20 x number of training imgs
% trainLabels = number of training imgs x 1 matrix containing labels
% testImg = 20 x 20 x number of test imgs
% testLabels = number of test imgs x 1 matrix containing labels
%
numTrain = 60000;
numTest = 10000;
testI = 't10k-images.idx3-ubyte';
testL = 't10k-labels.idx1-ubyte';
trainI = 'train-images.idx3-ubyte';
trainL = 'train-labels.idx1-ubyte';

if exist('reload','var')
    delete data/testimg.mat;
    delete data/testlabel.mat;
    delete data/trainimg.mat;
    delete data/trainlabel.mat;   
end

    if exist('testimg.mat','file') && exist('testlabel.mat','file') && ...
       exist('trainimg.mat','file') && exist('trainlabel.mat','file')
        load data/testimg.mat;
        load data/testlabel.mat;
        load data/trainimg.mat;
        load data/trainlabel.mat;
    else
        [trainImg, trainLabel] = readMNIST(trainI, trainL , numTrain, 0);
        [testImg, testLabel] = readMNIST(testI, testL, numTest, 0);
        save data/testimg.mat;
        save data/testlabel.mat;
        save data/trainimg.mat;
        save data/trainlabel.mat;
    end



end

