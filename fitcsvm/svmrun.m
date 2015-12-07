%%%% modified http://www.mathworks.com/solutions/machine-learning
%/examples.html?file=/products/demos/machine-learning
%/digit-classification-using-hog-features
%/digit-classification-using-hog-features.html


%%%%TODO I think this svm would work better if the images had some padding
%%%%readMnist function removes it so it would be best to readd some or
%%%% modify readmnist
clear all;
imgFileTrain = 'train-images.idx3-ubyte';
labelFileTrain = 'train-labels.idx1-ubyte';
imgFileTest = 't10k-images.idx3-ubyte';
labelFileTest = 't10k-labels.idx1-ubyte';
numTrain = 60000;
numTest = 10000;
offsetTrain = 0;
offsetTest = 0;
%%%%tested min .1 max .9 and min .4 max .6 and both did worse
amin = 0; %min grayscale cutoff
amax = 0; %max grayscale cutoff
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
hogCellSz = 4; %tested with cellsize 1:10 plot image found in file

%% feature ratio maybe fisher ratio? feature critia

%%%cn vanishing gradient problem , the deeper the nodes the shallower the
%%%gradient.


%%%q4  affine 6
%%%%q5 homo 4

[imgTrain, labelsTrain] = readMNIST(imgFileTrain, labelFileTrain, numTrain, offsetTrain);
[imgTest, labelsTest] = readMNIST(imgFileTest, labelFileTest, numTest, offsetTest);
imgTrain = mat2gray(imgTrain, [amin amax]);
imgTest = mat2gray(imgTest, [amin amax]);

cellSize = [hogCellSz hogCellSz];
BlockSize = [2 2]; %default
BlockOverlap = ceil(BlockSize/2); %default
NumBins = 9; %default
BlocksPerImage = floor((size(imgTrain,1)./hogCellSz - BlockSize)./(BlockSize - BlockOverlap) + 1);
hogFeatureSize = prod([BlocksPerImage, BlockSize, NumBins]);



% Train an SVM classifier for each digit
numTrainingImages = size(imgTrain,3);
trainingFeatures  = zeros(numTrainingImages,hogFeatureSize,'single');
for i = 1:numTrainingImages
    trainingFeatures(i,:) = extractHOGFeatures(imgTrain(:,:,i),'CellSize',cellSize);
end


for d = 0:9
    fprintf('Training digit%d.\n',d);
    % Pre-allocate trainingFeatures array


    % Extract HOG features from each training image. trainingImages
    % contains both positive and negative image samples.


    % Train a classifier for a digit. Each row of trainingFeatures contains
    % the HOG features extracted for a single training image. The
    % trainingLabels indicate if the features are extracted from positive
    % (true) or negative (false) training images.
    trainGroundTruth = labelsTrain == d; 
    %svm{d+1} = fitcsvm(trainingFeatures,trainGroundTruth,'Standardize',true,'KernelFunction','RBF',...
    %'KernelScale','auto');
%     svm{d+1} = fitcsvm(trainingFeatures,trainGroundTruth,'Standardize',true,'KernelFunction','polynomial',...
%     'KernelScale','auto'); %%%   1.2%

    svm{d+1} = fitcsvm(trainingFeatures, trainGroundTruth,'Standard',true ...
        ,'KernelFunction','polynomial','PolynomialOrder',7,'KernelScale','auto');
    %svm{d+1} = fitcsvm(trainingFeatures,trainGroundTruth);
    
end


digits = char('0'):char('9');

% Run each SVM classifier on the test images


% Pre-allocate testFeatures array
numImages    = size(imgTest,3);
testFeatures = zeros(numImages, hogFeatureSize, 'single');

% Extract features from each test image
for i = 1:numImages
    testFeatures(i,:) = extractHOGFeatures(imgTest(:,:,i),'CellSize',cellSize);
end

% Run all the SVM classifiers
predictedScore = zeros(numTest, numel(svm));
for digit = 1:numel(svm)
    [~, score ] = predict(svm{digit}, testFeatures);
    predictedScore(:,digit) = score(:,2);
end

for i=1:numTrain
    predictedLabels = double(bsxfun(@eq, predictedScore, max(predictedScore, [], 2)));

end


error = 0;
for i = 1:numTest
    if predictedLabels(i,labelsTest(i)+1) ~= 1;
        error = error + 1;
    end
end
 error = error/numTest;
fprintf('Total error %d%%.\n',error*100);

for i=1:size(svm,2)
    if not(svm{i}.ConvergenceInfo.Converged)
        fprintf('%d did not converge\n',i-1);
    end
end
    




