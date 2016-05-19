
#' @import caret caTools rJava

library(caret)
library(caTools)
library(rJava)

getAvgAUC <- function(x, y, methodName, iter, verboseIter){

  fold = 25
  if(floor(nrow(x) / 4) < 25)
    fold = floor(nrow(x) / 4)
  # defining train control with 1/4 k-fold cross-validation method
  trControl <- trainControl(method = "cv",
                            number = fold,
                            classProbs=TRUE,
                            verboseIter = verboseIter)

  #Declaring variable for AUC, Spec, Sens, PPV, NPV to calculate their average later
  AUC <- 0
  spec <- 0
  sens <- 0
  ppv <- 0
  npv <- 0
  i <- 1
  while(i <= iter){
    print(paste("Iteration : ",i,sep = ""))

    # Creating stratified samples as 70:30
    # 70% of data set will be used as training data and remaining 30% will be
    # used as testing data from which AUC will be calculated
    repeat{
      inTrain <- createDataPartition(y = y, p = .70, list = FALSE)
      trainData <- x[inTrain,]
      testData <- x[-inTrain,]
      trainLabels <- y[inTrain]
      testLabels <- y[-inTrain]

      #Confirm that we have both of the classes in testDataset

      if(nlevels(factor(testLabels)) == 2){
        break;
      }
    }


    #get Labels used to class
    lab = levels(as.factor(y))

    if(methodName$env != "r"){
      train = cbind(trainLabels, trainData)
      write.csv(train,file='train.csv',row.names=FALSE)

      test = cbind(testLabels,testData)
      write.csv(test,file='test.csv',row.names=FALSE)

      mm <- as.data.frame(matrix(0, nrow(testData), 2))
      result = `names<-`(mm,c(lab[1], lab[2]))
      rm(mm)
      write.csv(result,file='result.csv',row.names=FALSE)

      if(methodName$env == "java"){
        isSuccess = javaCall(as.character(methodName$modelName))
      }else{
        isSuccess = pythonCall(as.character(methodName$modelName))
      }

      if(isSuccess == 1){
        p = getPredFromFile();
      }

    }else{
      # training model for 70% dataset by given method = methodName Ex. 'glm'
      model <- train(trainLabels ~ ., data = trainData, method = as.character(methodName$modelName),
                     trControl = trControl)

      # predicting class probabilitis for 30% dataset
      # less than 0.5 is -ve class
      p = predict(model, newdata = testData, type = 'prob')
    }

    #Creating predicted class label to calculate Spec, Sens, PPV, NPV
    pred = p[,2]
    pred[pred <= 0.5] = 0
    pred[pred > 0.5] = 1

    #converting probabilities to Labels
    pred[pred == 0] = lab[1]
    pred[pred == 1] = lab[2]

    # calculating AUC for predicted class with actual class
    # adding AUC to calculate average later
    plot = FALSE
    if(i == iter)
      plot = TRUE
    AUC = AUC + colAUC(p[2], testLabels, plotROC = plot)[1,1]


    #get confusion matrix
    res = confusionMatrix(pred, testLabels)

    #Calculating Specificity and replacing adding 0 if calculated is NaN
    tempSpec =  res$byClass['Specificity']
    if(is.nan(tempSpec))
      tempSpec = 0
    spec = spec + tempSpec

    #Calculating Sensitivity and replacing adding 0 if calculated is NaN
    tempSens =  res$byClass['Sensitivity']
    if(is.nan(tempSens))
      tempSens = 0
    sens = sens + tempSens

    #Calculating PPV and replacing adding 0 if calculated is NaN
    tempPpv = res$byClass['Pos Pred Value']
    if(is.nan(tempPpv))
      tempPpv = 0
    ppv = ppv + tempPpv


    #Calculating NPV and replacing adding 0 if calculated is NPV
    tempNpv = res$byClass['Neg Pred Value']
    if(is.nan(tempNpv))
      tempNpv = 0
    npv = npv + tempNpv
    i = i + 1
  }

  #Returning list of averaged AUC, Spec, Sens, PPV, NPV
  return (c(AUC/iter,spec/iter,sens/iter,ppv/iter, npv/iter));

}

getModelList <- function(){

  #Creating Dataframe with method name, environment and other values (Ex, AUC, Spec, etc)
  modelMat = matrix(nrow = 0, ncol = 7)
  modelMat = rbind(modelMat, c('glm','r',0,0,0,0,0))
  modelMat = rbind(modelMat, c('lda','r',0,0,0,0,0))
  modelMat = rbind(modelMat, c('gpls','r',0,0,0,0,0))
  modelMat = rbind(modelMat, c('wsrf','r',0,0,0,0,0))
  modelMat = rbind(modelMat, c('nnet','r',0,0,0,0,0))
  modelMat = rbind(modelMat, c('nb','r',0,0,0,0,0))
  modelMat = rbind(modelMat, c('gbm','r',0,0,0,0,0))
  modelMat = rbind(modelMat, c('avNNet','r',0,0,0,0,0))
  modelMat = rbind(modelMat, c('svmPoly','r',0,0,0,0,0))
  modelMat = rbind(modelMat, c('widekernelpls','r',0,0,0,0,0))
  modelMat = rbind(modelMat, c('dwdRadial','r',0,0,0,0,0))
  modelMat = rbind(modelMat, c('ranger','r',0,0,0,0,0))
  modelMat = rbind(modelMat, c('hdda','r',0,0,0,0,0))
  modelMat = rbind(modelMat, c('kernelpls','r',0,0,0,0,0))
  modelMat = rbind(modelMat, c('svmLinear','r',0,0,0,0,0))
  modelMat = rbind(modelMat, c('glmnet','r',0,0,0,0,0))
  modelMat = rbind(modelMat, c('dwdLinear','r',0,0,0,0,0))
  modelMat = rbind(modelMat, c('bayesglm','r',0,0,0,0,0))
  modelMat = rbind(modelMat, c('sda','r',0,0,0,0,0))
  modelMat = rbind(modelMat, c('ADTree','java',0,0,0,0,0))
  modelMat = rbind(modelMat, c('BFTree','java',0,0,0,0,0))
  modelMat = rbind(modelMat, c('DecisionStump','java',0,0,0,0,0))
  modelMat = rbind(modelMat, c('LADTree','java',0,0,0,0,0))
  modelMat = rbind(modelMat, c('SimpleCart','java',0,0,0,0,0))
  modelMat = rbind(modelMat, c('VotedPerceptron','java',0,0,0,0,0))
  modelMat = rbind(modelMat, c('MultilayerPerceptron','java',0,0,0,0,0))


  modelList = data.frame(modelName = as.character(modelMat[,1]), env = as.character(modelMat[,2]), avgAUC = as.numeric(modelMat[,3]),
                         avgSecificity = as.numeric(modelMat[,4]), avgSensitivity = as.numeric(modelMat[,5]),
                         avgPPV = as.numeric(modelMat[,6]), avgNPV = as.numeric(modelMat[,7]))


  return (modelList)
}


#This Function removes NaN values from Dataframe or matrix
#This is used to preprocess data
removeNaN <- function(x){
  i = 1
  while(i <= nrow(x)){
    j = 1
    while(j <= ncol(x)){
      if(is.nan(x[i,j]))
        x[i,j] = 0
      j = j + 1
    }
    i = i + 1
  }
  return (x)
}

getPredFromFile <- function(){
  p = read.csv(file='result_prob.csv',head=TRUE,sep=",")
  if(file.exists('result_prob.csv')){
    file.remove('result_prob.csv')
  }
  if(file.exists('train.csv')){
    file.remove('train.csv')
  }
  if(file.exists('test.csv')){
    file.remove('test.csv')
  }
  if(file.exists('result.csv')){
    file.remove('result.csv')
  }
  p[,1] = 1 - p[,2]
  return(p)
}
