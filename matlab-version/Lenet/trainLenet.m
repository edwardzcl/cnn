clear;clc;

%% ===============================================================
%load data
imageDim = 28;
numclasses = 10;
images = loadMNISTImages('train-images.idx3-ubyte');
images = reshape(images,imageDim,imageDim,[]);
labels = loadMNISTLabels('train-labels.idx1-ubyte');
labels(labels == 0) = 10;

%% initialparameters
lenet.layers = {
    struct('type','i')
    struct('type','C1','outputmaps',6,'kernelsize',5)
    struct('type','S2','scale',2)
    struct('type','C3','outputmaps',16,'kernelsize',5)
    struct('type','S4','scale',2)
    struct('type','C5','outputmaps',120)
    struct('type','F6','outputmaps',84)
    struct('type','Soft','num_classes',10)
};

lenet = initialParameters(lenet,images);

%% train the cnn
opts.alpha = 1;

opts.batchsize = 40;

opts.numepochs = 20;

lenet = cnnTrain(lenet,images,labels,opts);

%% test the cnn
testImages = loadMNISTImages('t10k-images.idx3-ubyte');
testImages = reshape(testImages,imageDim,imageDim,[]);
testLabels = loadMNISTLabels('t10k-labels.idx1-ubyte');
testLabels(testLabels == 0) = 10;

lenet = cnnff(lenet,testImages);

a = lenet.layers{8}.a;
[~,preds] = max(lenet.layers{8}.a,[],1);
preds = preds';

acc = sum(preds == testLabels) / length(preds);
fprintf('Accuracy is %f\n',acc);
