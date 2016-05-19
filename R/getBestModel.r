#' @title Get Best possible model for your binary class dataset
#' @description Gives the best possible binary classification model suit for given dataset.
#' Takes binary class train dataset and it's labels, perform stratified sampling,
#' performs train and test, gives average AUC for 'iter' iterations
#' @param x Matrix or dataframe with numeric values (features of train data)
#' @param y Vector (class of given train data)
#' @param iter Numeric value (These many number of time each model will be evaluated for AUC)
#' @param verboseIter Boolean value (print progress)
#' @return dataframe with fields for Average AUC, Model Name, Platform (Ex. r)
#' @export
getBestModel <- function(x, y, iter = 100, verboseIter = FALSE){

  #Convert dataset to dataframe if it is not already a dataset
  x = as.data.frame(x)

  #Convert labels to vector
  y = as.vector(y)

  #Check for binary class, if not then stop processing
  if(nlevels(factor(y)) != 2)
    stop('Number of classes is not equals to 2');

  if(is.numeric(y[1])){
    y = factor(y,labels=c('neg','pos'))
  }

  # preprocessing dataset
  # removing NA and NaN values ... setting it to 0
  x = removeNaN(x)
  x[is.na(x)] = 0


  modelList = getModelList()
  i = 1
  while(i <= nrow(modelList)){
    print(paste("getting results for (",i," of ",nrow(modelList),") model", sep = ""))

    #Getting values like AUC, PPV, etc of given model for given iteration
    val = getAvgAUC(x,y,modelList[i,],iter, verboseIter)

    #Assigning Values
    modelList$avgAUC[i] = val[1]
    modelList$avgSecificity[i] = val[2]
    modelList$avgSensitivity[i] = val[3]
    modelList$avgPPV[i] = val[4]
    modelList$avgNPV[i] = val[5]
    i = i + 1
  }
  #print(modelList)
  #Sorting Model-list by Average AUC
  modelList = modelList[order(-modelList$avgAUC),]

  #Plotting average AUC
  barplot(modelList$avgAUC, horiz = TRUE, names.arg = modelList$modelName, las = 1, space = 5, xlim = c(0,1), cex.names = 0.55, main = "Average AUC")

  #Plotting average Specificity
  barplot(modelList$avgSecificity, horiz = TRUE, names.arg = modelList$modelName, las = 1, space = 5, xlim = c(0,1), cex.names = 0.55, main = "Average Specificity")

  #Plotting average Sensitivity
  barplot(modelList$avgSensitivity, horiz = TRUE, names.arg = modelList$modelName, las = 1, space = 5, xlim = c(0,1), cex.names = 0.55, main = "Average Sensitivity")

  #Plotting average PPV
  barplot(modelList$avgPPV, horiz = TRUE, names.arg = modelList$modelName, las = 1, space = 5, xlim = c(0,1), cex.names = 0.55, main = "Average Positive Predicted Values(PPV)")

  #Plotting average NPV
  barplot(modelList$avgNPV, horiz = TRUE, names.arg = modelList$modelName, las = 1, space = 5, xlim = c(0,1), cex.names = 0.55, main = "Average Negative Predicted Values(NPV)")

  #returning Model-list
  return (modelList)

}
