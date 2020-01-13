# Brainoread
This source code is a tool which is a standalone binary classifier using machine learning algorithms from R, Java and Python. Currently used for diagnosis of patients suffering from brain disorders.

## Visible methods
### 1) getBestModel(x, y, iter = 100, verboseIter = FALSE){…}
####file : getBestModel.r

This function takes features(x) and labes(y) of training dataset as input, performs data
preprocessing (replace NA and NaN with 0). Evaluate train data for each model with
stratified sampling (70% - 30%) “iter” times, which is 100 by default. Function
returns a dataframe with model-name, environment, averaged AUC, specificity,
sensitivity, PPV, NPV. This function calls hidden methods getModelList() and
getAvgAUC() to get dataframe to be return with default 0 values and get averaged
values for “iter” iteration for each model in dataframe.

### 2) getTrainModel(x, y, methodName, verboseIter = FALSE, tuneLength = 10){…}
#### file : trainPredict.r

This function takes same features(x), and labels(y) of training dataset as input with
extra argument methodName – this is a row from dataframe returned by
getBestModel(). This function train model if the environment is R then tuneLength
parameter is used. For R environment trainControl() and train() from caret are used,
and if environment is JAVA then train dataset (features and labels) is written in file
and calls the hidden method javaCall(), this function calls java methods using rJava
library. Final model is written in file (currentModel.rds for R and currentModel.obj
for java). This function returns vector with model-name and environment.

### 3) getPredictProb(model, testData){…}
#### file : trainPredict.r

This function uses model (vector return from getTrainModel) and test dataset as
input. If environment is R model written in currentModel.rds is read and predict()
method from caret is used to get prediction probabilities, and for JAVA environment
test dataset is written in file with extra result file and call is made to javaCall()
method, to get prediction probabilities java class writes result in result_prob.csv file
which is read by hidden method getPredFromFile(). Function returns dataframe with
both class probabilities.

### 4) getLastModel(){…}
#### file : trainPredict.r
Method getTrainModel() creates one additional file info.csv which contains labels of
class, model-name and environment information. This function reads that file and
returns a vector same as getTrainModel() returns.

## Hidden Methods

### 1) getModelList(){…}
#### file : getAUC.r
This function creates a dataframe of model-name, environment and accuracy value fields
with default 0 and returns that dataframe.

### 2) getAvgAUC(x, y, methodName, iter, verboseIter){…}
#### file : getAUC.r
This method takes features(x), labels(y), method-name (row of model-list) and number of
iterations to be performed. Function returns vector with averaged values of accuracy
values. This function perform stratified sampling (70% - 30%) 70% is used for training
and 30% is used for testing. If environment is R then train() and predict() from caret is
used. If environment is JAVA then train and test dataset is written in files with addition
result file, and a call is made to javaCall() method. Java writes result in file which is read
by getPredFromFile() method. AUC is caluculated using caTools::colAUC() method and
rest values are calculated using caret::confusionMatrix() method.

### 3) removeNaN(x){…}
#### file : getAUC.r
This file replaces NaN values with 0 from dataframe and returns that dataframe .

### 4) getPredFromFile(){…}
#### file : getAUC.r
Java writes predictions of positive class in result_prob.csv. This functions reads this file
and place probabilities of negative class and returns dataframe with both class
probabilities.

### 5) javaCall (modelName, train = FALSE, test = FALSE){…}
#### file :javaCall.R
This function uses rJava to create object of java class file and calls method of that class
instance. This method uses model-name, with train and test arguments. If train and test
both are false then java methods performs both training and testing (used for stratified
sampling). If train is true then only train model and save in model in file, and if test is
true then read model saved in file test the dataset and write prediction in result_prob.csv

*Demo script is written in test.r file with dementia dataset (demen.csv)*
