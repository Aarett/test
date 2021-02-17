library(data.table)
library(dplyr)

mod_props<-fread("./project/volume/data/interim/modified_proportions.csv")
train_test<-fread("./project/volume/data/raw/train_file.csv") %>% select(id,result)

sigmoid<-function(x){1/(1+exp(-x))}

logLoss = function(pred, actual){ #source: https://stackoverflow.com/questions/38282377/how-to-compute-log-loss-in-machine-learning
  -1*mean(log(pred[model.matrix(~ actual + 0) - pred > 0]))
}

submission<-mod_props %>% mutate(result=sigmoid(modified_proportions)) %>% select(id, result)

test<-submission %>% left_join(train_test, by="id")
#logLoss(submission$result,train_test$result)

fwrite(submission,"./project/volume/data/processed/optimized_submission.csv")
