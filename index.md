# About
We have created a generic binary classiﬁer which we currently use for diagnosis of patients suﬀering from brain disorders. However, the tool is powerful enough to work on any binary class classiﬁcation problem. On prediction of 119,748 test subjects for Schizophrenia, we got a maximum accuracy of **91.78%**. And on cross validation of Dementia dataset, we got the maximum accuracy of close to **100%**. 
This tool can be easily ported to hospitals and can be used for prediction of any data provided the model is initially trained using similar known dataset. Initially the tool takes time for training all models and then tunes those using diﬀerent tuning parameters, and once the model is trained; prediction can be done in very less time. It provides the advantage of saving the model so it can be reused any number of times. 
Moreover, the prediction accuracy of the model can be increased by manually adding training subjects to the dataset.

# Features extracted from MRI scans
## FNC Features
Functional Network Connectivity (FNC) are relationship values that compress the general association between free cerebrum maps after some time.Therefore, the FNC feature gives a picture of the availability design after sometime between autonomous systems (or brain maps). These FNC features were obtained by Group Independent Component Analysis (GICA) of MRI images. The MRI chosen for the task were of both, healthy people and people suﬀering from Schizophrenia. An arrangement of cerebrum maps and timecourses relating to these mind maps were achieved by the GICA disintegration of the fMRI information. These timecourses demonstrated the action level of the comparing cerebrum map at every point in time. The FNC features are the relationships between these timecourses. For interpretation, FNC demonstrates a subject’s general level of ”synchronicity” between mind areas.As this information is derived from functional MRI scans, FNCs are considered a functional modality feature. They describe patterns of the brain function.

![](https://cloud.githubusercontent.com/assets/10834446/19800028/6355c83c-9d17-11e6-82b7-cf34fbda4eba.png)
## SBM Features
Source-Based Morphometry (SBM) loadings relate to the weights of brain maps obtained by applying Independent Component Analysis (ICA) on the gray-matter concentration maps.Gray-matter is the outer layer of the brain. Most of the signal processing of the brain occurs in gray-matter region.For interpretation, gray-matter concentrationindictes the ”computational power” available in a certain region of the brain.ICA investigation of basic MRI for gray-matter focus gives autonomous mind maps whose expres sion levels ﬂuctuate as indicated by the subjects. Basically, a close to zero stacking for a given ICA-determined mind map demonstrates that the cerebrum locales delineated in that guide are modest present in the subject (i.e., the presence of gray-matter concentration areas in those regions are very low in that subject). As this information is derived from structural MRI scans, SBM loadings are considered a structural modality feature. They describe patterns of the brain structure.

![](https://cloud.githubusercontent.com/assets/10834446/19799291/8abb8aa0-9d13-11e6-839e-93dcbd1365a7.png)
# Methods for Highly Accurate Results
Most of the algorithms are used individually in the first iterations. The results generated from top models can be sorted according to prediction accuracy and then they can be combined further for increasing accuracy. 

## k-fold Cross Validation 
Cross Validation is the method where we divide the entire training data into parts. k is the parameter through which we decide how many such parts should be made. Of them, we use 1 part for testing and k – 1 parts for training. Such training – testing cycle is repeated until all parts are dropped for testing i.e. the loop runs k times. For a value of k = 10, we divide the dataset into 10 parts; train for 9 parts and test for 1 part. Such process is repeated until every single part is used for testing and remaining 9 for training. Thus, the loop iterates 10 times. 

## Stratified Sampling 
For determining the best model we initially do stratified sampling of the training data. It is similar to k-fold cross validation. Here, we divide the entire data set into ratio of 70:30. We use the createDataPartition function of Caret package and pass parameter as 0.7. The training dataset is divided into random 70% and 30% of which we use 70% for training and 30% for testing. We repeat this procedure of randomly dividing the dataset into 70% and 30% for 100 iterations. The accuracy for each iteration is recorded and finally, average accuracy of prediction of data is calculated by taking the average of 100 accuracies. 

## Feature Selection
Feature Selection includes selection of most important features from a list of all features. Feature Selection helps the model to solve the problem of overfitting the training set. That is, it reduces variance from the train set. The methods used for feature selection are: 
* Recursive Feature Elimination (RFE) 
* Simulated Annealing Feature Selection (SAFS)
* varImp for Random Forest 

### FNC Feature Selection
![](https://cloud.githubusercontent.com/assets/10834446/19798727/79ebf960-9d10-11e6-8dc0-eac3f261e8d8.png)
### SBM Feature Selection
![](https://cloud.githubusercontent.com/assets/10834446/19798729/7a2bf1b4-9d10-11e6-8aeb-3689df07ad21.png)

# List of Algorithms 
Our package uses a list of all classification algorithms available in the mentioned packages. A few of the algorithms used for the project from Caret package are as follows:
* gpls (Generic Partial Least Squares)
* svm (Support Vector Machines)
* nb (Naive Bayes)
* nnet (Neural Network)
* lda (Linear Discriminant Analysis)
* rf (Random Forest)
* wsrf (Weighted Subspace Random Forest)
* LMT (Logistic Model Trees)
* glm (Generalized Linear Model)
* gbm (Gradient Boosting Machines)

# System Design
The following is a flow chart that explains the work flow of the model.

![](https://cloud.githubusercontent.com/assets/10834446/19798733/7a766ea6-9d10-11e6-8338-e65616915420.jpg)
# AUC Metric
We use AUC accuracy metric for calculation of prediction accuracy. AUC stands for Area Under the Curve of Receiver Operating Characteristic (ROC) Curve. The curve is basically a plot of true positive rate vs. false positive rate, where true positive rate is also known as sensitivity of the model and is calculated as the proportion of positive class members that are correctly classified by the model and false positive rate is calculated as (1 - Specificity) where specificity is known as true negative rate calculated as the proportion of negative class members that are correctly classified by the model as such. Fig 4 shows a sample AUC graph for determination of Nondemented people from our dataset. The area under the curve is the accuracy of prediction of Non demented people. The maximum accuracy, thus, is the area under the straight line from (0,1) to (1,1) which is 1.

![](https://cloud.githubusercontent.com/assets/10834446/19798941/750a2f60-9d11-11e6-991f-6f73e4525806.jpeg)
# Results and Analysis
## Plot for Analysis of Dementia Patients 
Below figure depicts the classification of Dementia patients plot against two features namely AWF and nWBV. We used a visualization function to give a graphical output of the data. The plot in red is people not suffering from Dementia whereas the blue plot shows the people suffering from the disease.

![](https://cloud.githubusercontent.com/assets/10834446/19800029/6359ef2a-9d17-11e6-82a5-fdf744e89a57.png)
## Basic Training Accuracies
The following table gives the training accuracy for all individual models for Schizophrenia dataset. The training data is divided into three parts namely FNC only, SBM only and both, FNC and SBM. The maximum accuracy for the each model is taken. Two methods for training the data are ‘cv’ i.e. cross validation and ‘boot’.

![](https://cloud.githubusercontent.com/assets/10834446/19815375/2145f50e-9d60-11e6-836f-d613a0f6325d.png)
## Final Models with Maximum Prediction Accuracy
The following table shows the maximum Kaggle score, i.e. the AUC accuracy for individual models on prediction of test data. We used stratified sampling and k-fold cross validation while training to increase the results. The most accurate models are selected from this analysis and are used for further progress of the project. 

![](https://cloud.githubusercontent.com/assets/10834446/19815545/0b29cccc-9d61-11e6-8f2e-41ad0c38ee2f.png)
## Graph Plots for Accuracy Metrics
### AUC

![](https://cloud.githubusercontent.com/assets/10834446/19798940/7508dcaa-9d11-11e6-8ced-37105389ecdd.jpeg)
### Sensitivity

![](https://cloud.githubusercontent.com/assets/10834446/19815777/077c2754-9d62-11e6-88cb-dcd2dee2bbd5.png)
### Specificity

![](https://cloud.githubusercontent.com/assets/10834446/19815778/077d76ea-9d62-11e6-9b26-6945ccc2e1f9.png)
### Positive Predicted Values
Positive Predictive Value (PPV) is the extent of positively characterized cases that were really positive. It is the ability of the model to predict positive values accurately. The formula for calculating PPV is  PPV = (number of true positives) / ((number of true positives) + (number of false positives)) 

![](https://cloud.githubusercontent.com/assets/10834446/19798726/79e90110-9d10-11e6-9f63-e8460e612053.jpeg)
### Negative Predicted Values
Negative Predictive Value (NPV) is the extent of adversely arranged cases that were really negative. It is the ability of the model to predict negative values accurately. NPV is calculated as NPV = (number of true negatives) / ((number of true negatives) + (number of false negatives))

![](https://cloud.githubusercontent.com/assets/10834446/19798725/79e7644a-9d10-11e6-8129-14983fdc2a92.jpeg)
# Visible methods
### 1) getBestModel(x, y, iter = 100, verboseIter = FALSE){…}
#### file : getBestModel.r

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

# Hidden Methods

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
