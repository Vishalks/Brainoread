#load package
library(BrainRead)

#read train dataset
demen = read.csv('~/demen.csv')

#get list of models with their AUC accuracy
model_list = getBestModel(demen[1:80,2:11],demen[1:80,1], iter = 3)

head(model_list)

#train model with small tune length 'kernalpls'
model = getTrainModel(demen[1:80,2:11],demen[1:80,1], methodName = model_list[1,],
                      tuneLength = 3)

#Get predictions
p1 = getPredictProb(model, demen[81:336, 2:11])

#converting Probalities to labels
pred1 = p1$Demented
pred1[pred1 <= 0.5] = 0
pred1[pred1 > 0.5] = 1

pred1[pred1 == 0] = 'Nondemented'
pred1[pred1 == 1] = 'Demented'


#train model with high tune length
model = getTrainModel(demen[1:80,2:11],demen[1:80,1], methodName = model_list[23,],
                      tuneLength = 10)

p2 = getPredictProb(model, demen[81:336, 2:11])

pred2 = p2$Demented
pred2[pred2 < 0.5] = 0
pred2[pred2 >= 0.5] = 1

pred2[pred2 == 0] = 'Nondemented'
pred2[pred2 == 1] = 'Demented'


#get AUC for both probabilities
caTools::colAUC(p1$Demented, demen[81:336,1])
caTools::colAUC(p2$Demented, demen[81:336,1])

#get confusion matrix for both probabilities
conf1 = confusionMatrix(pred1, demen[81:336,1])
conf2 = confusionMatrix(pred2, demen[81:336,1])
conf1$table
conf2$table

#Total false predictions
res1 = demen[81:336,1] == pred1
res2 = demen[81:336,1] == pred2

table(res1)
table(res2)


#         |          Predicted
# --------|--------------------------------
#         |   TRUE +VE    |   FALSE -VE   |     Actual +ve
# Actual  |--------------------------------
#         |   FALSE +VE   |   TRUE -VE    |     Actual -ve
# --------|--------------------------------
#           predicted +ve   Predicted -ve
