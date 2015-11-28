%%%% modified http://www.mathworks.com/solutions/machine-learning
%/examples.html?file=/products/demos/machine-learning
%/digit-classification-using-hog-features
%/digit-classification-using-hog-features.html


%%%%TODO I think this svm would work better if the images had some padding
%%%%readMnist function removes it so it would be best to readd some or
%%%% modify readmnist

imgFileTrain = 'train-images.idx3-ubyte';
labelFileTrain = 'train-labels.idx1-ubyte';
imgFileTest = 't10k-images.idx3-ubyte';
labelFileTest = 't10k-labels.idx1-ubyte';
numTrain = 1000;
numTest = 100;
offsetTrain = 0;
offsetTest = 0;
amin = 0; %min grayscale cutoff
amax = 1; %max grayscale cutoff
hogCellSz = 4;


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
for d = 0:9

    % Pre-allocate trainingFeatures array
    numTrainingImages = size(imgTrain,3);
    trainingFeatures  = zeros(numTrainingImages,hogFeatureSize,'single');

    % Extract HOG features from each training image. trainingImages
    % contains both positive and negative image samples.
    for i = 1:numTrainingImages
        %imgTrain = imread(trainingImages{i,d});

        %imgTrain = preProcess(imgTrain);

        trainingFeatures(i,:) = extractHOGFeatures(imgTrain(:,:,i),'CellSize',cellSize);
    end

    % Train a classifier for a digit. Each row of trainingFeatures contains
    % the HOG features extracted for a single training image. The
    % trainingLabels indicate if the features are extracted from positive
    % (true) or negative (false) training images.
    trainGroundTruth = labelsTrain == d; 
    options.MaxIter = 100000;
    svm(d+1) = svmtrain(trainingFeatures, trainGroundTruth, 'Options',options);
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
predictedLabels = zeros(numTest, numel(svm));
for digit = 1:numel(svm)
    predictedLabels(:,digit) = svmclassify(svm(digit), testFeatures);
end



%%%doesnt work fuck it
% for i = 1:10
%     x = sum(predictedLabels(:,i))/sum(labelsTest == i-1);
%     x =      /sum(labelsTest == i-1)
%     fprintf('%i error %d%%.\n',i-1,x*100);
% end


correct = sum(diag(predictedLabels(:,labelsTest(:)'+1)))/numTest;
error = 1-correct;
fprintf('Total error %d%%.\n',error*100);




