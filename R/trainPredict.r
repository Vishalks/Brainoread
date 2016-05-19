library(caret)
#' @title Get trained model for given binary class method name
#' @description This funtion performs the hyper-tuning for given model.
#' Trains model on full train dataset, and returns trained model
#' @param x Matrix or dataframe with numeric values (features of train data)
#' @param y Vector (class of given train data)
#' @param methodName Dataframe row returned from getBestModel(Ex. method_list[1,], here method_list is a dataframe returned from getBestModel and giving 1st method as input to train model)
#' @param verboseIter Boolean value (print progress)
#' @return Vector that contains environment and algorithm name
#' @export
getTrainModel <- function(x, y, methodName, verboseIter = FALSE, tuneLength = 10){

  #Convert dataset to dataframe if it is not already a dataset
  x = as.data.frame(x)


  #Convert labels to vector
  y = as.vector(y)

  #Check for binary class, if not then stop processing
  if(nlevels(factor(y)) != 2)
    stop('Number of classes is not equals to 2');

  #check whether class is in numeric
  #if yes then convert it to character as 'neg' and 'pos'
  if(is.numeric(y[1])){
    y = factor(y,labels=c('neg','pos'))
  }

  f = levels(factor(y))
  #write(f, file = "labels.tbl")

  # preprocessing dataset
  # removing NA and NaN values ... setting it to 0
  x = removeNaN(x)
  x[is.na(x)] = 0

  if(methodName$env == 'r'){
    #decide folds for k-fold cross validation
    fold = 25
    if(floor(nrow(x) / 4) < 25)
      fold = floor(nrow(x) / 4)

    # defining train control k-fold cross-validation method
    trControl <- trainControl(method = "cv",
                              number = fold,
                              classProbs=TRUE,
                              verboseIter = verboseIter)

    #train model for given train dataset
    model = train(y ~ ., data = x, method = methodName$modelName,
                  trControl = trControl, tuneLength = tuneLength)

    #return trained model
    saveRDS(model, 'currentModel.rds')
    #print(methodName$modelName)
    f = data.frame(model = c('r',as.character(methodName$modelName)), labels = levels(factor(y)))
    write.csv(f,file='info.csv',row.names=FALSE)

    return (c('r',as.character(methodName$modelName)))
  }else{
    train = cbind(y, x)
    write.csv(train,file='train.csv',row.names=FALSE)
    isSuccess = javaCall(as.character(methodName$modelName), train = TRUE)
    file.remove('train.csv')

    f = data.frame(model = c('java',as.character(methodName$modelName)), labels = levels(factor(y)))
    write.csv(f,file='info.csv',row.names=FALSE)

    return (c('java',as.character(methodName$modelName)))
  }
}




#' @title Get prediction in probabilty
#' @description This funtion predict class of given test data in terms of probability
#' @param model trained model with getTrainModel function
#' @param testData Test dataset having same number of columns as test dataset used to trained model
#' @return Dataframe with probabilities for both classes
#' @export
getPredictProb <- function(model, testData){

  #Convert dataset to dataframe if it is not already a dataset
  testData = as.data.frame(testData)

  #preprocess dataset remove NAs and NaNs
  testData = removeNaN(testData)
  testData[is.na(testData)] = 0

  if(model[1] == 'r'){
    #predict class for given test dataset
    m = readRDS('currentModel.rds')
    p = predict(m, newdata = testData, type = 'prob')


    #return probabilities of test dataset
    return (p)
  }else{
    temp = data.frame(class = c(testData[1]))
    temp  = `names<-`(temp,'class')
    test = cbind(temp, testData)
    write.csv(test,file='test.csv',row.names=FALSE)

    mm <- as.data.frame(matrix(0, nrow(testData), 2))
    f = read.csv('info.csv')
    result = `names<-`(mm,f$labels)
    rm(mm)
    write.csv(result,file='result.csv',row.names=FALSE)

    isSuccess = javaCall(as.character(model[2]), test = TRUE)
    #file.remove('test.csv')
    p = getPredFromFile()

    return (p)
  }

}

#' @title Get last trained model using getTrainModel()
#' @description This funtion returns the info of last recent trained model
#' i.e. environment and algorithm name
#' @return Vector that contains environment and algorithm name
#' @export
getLastModel <- function(){

  #read file which has last trained model info
  f = read.csv('info.csv')
  return (as.vector(f$model))
}
