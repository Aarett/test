library(data.table)
library(dplyr)

train<-fread("./project/volume/data/raw/test_file.csv") #./project/volume/data/raw/test_file.csv

mean(t(train[1,2:(length(train)-1)]))

feature<-train %>% mutate(modified_proportions=((V1+V2+V3+V4+V5+V6+V7+V8+V9+V10)-5)) %>% select(id,modified_proportions) #*.4109



sigmoid<-function(x){1/(1+exp(-x))}

LogLoss=function(actual, predicted)
{
  result=-1/length(actual)*(sum((actual*log(predicted)+(1-actual)*log(1-predicted))))
  return(result)
}


feature.5<-feature %>% filter(modified_proportions==-5)
feature.4<-feature %>% filter(modified_proportions==-4)
feature.3<-feature %>% filter(modified_proportions==-3)
feature.2<-feature %>% filter(modified_proportions==-2)
feature.1<-feature %>% filter(modified_proportions==-1)
feature0<-feature %>% filter(modified_proportions==0)
feature1<-feature %>% filter(modified_proportions==1)
feature2<-feature %>% filter(modified_proportions==2)
feature3<-feature %>% filter(modified_proportions==3)
feature4<-feature %>% filter(modified_proportions==4)
feature5<-feature %>% filter(modified_proportions==5)

fwrite(feature,"./project/volume/data/interim/modified_proportions.csv")

best<-1000

#for (i in 0:10){

  w.5=0.475
  w.4=0.404
  w.3=0.357
  w.2=0.339
  w.1=0.333
  w0=1
  w1=0.304
  w2=0.347
  w3=0.368
  w4=0.413
  w5=0.481
  
  
  
submission.5<-feature.5 %>% mutate(pred=sigmoid(modified_proportions*w.5)) %>% select(id, pred)
submission.4<-feature.4 %>% mutate(pred=sigmoid(modified_proportions*w.4)) %>% select(id, pred)
submission.3<-feature.3 %>% mutate(pred=sigmoid(modified_proportions*w.3)) %>% select(id, pred)
submission.2<-feature.2 %>% mutate(pred=sigmoid(modified_proportions*w.2)) %>% select(id, pred)
submission.1<-feature.1 %>% mutate(pred=sigmoid(modified_proportions*w.1)) %>% select(id, pred)
submission0<-feature0 %>% mutate(pred=sigmoid(modified_proportions*w0)) %>% select(id, pred)
submission1<-feature1 %>% mutate(pred=sigmoid(modified_proportions*w1)) %>% select(id, pred)
submission2<-feature2 %>% mutate(pred=sigmoid(modified_proportions*w2)) %>% select(id, pred)
submission3<-feature3 %>% mutate(pred=sigmoid(modified_proportions*w3)) %>% select(id, pred)
submission4<-feature4 %>% mutate(pred=sigmoid(modified_proportions*w4)) %>% select(id, pred)
submission5<-feature5 %>% mutate(pred=sigmoid(modified_proportions*w5)) %>% select(id, pred)

#5<-3
#4<-4
#3<-5
#2<-7
#1<-16
#0<-1
#-1<--16


mod_props<-fread("./project/volume/data/interim/modified_proportions.csv")
#train_test<-fread("./project/volume/data/raw/test_file.csv") %>% select(id,result)

submission<-rbind(submission.5,submission.4,submission.3,submission.2,submission.1,submission0,submission1,submission2,submission3,
                  submission4,submission5) %>% arrange(id)
#print(i)
#cur<-LogLoss(submission$result,submission$pred)
#if(best>cur){
#  print(cur)
#  best_num<-i
#  best<-cur
#}
#print('---------')

#View(submission)

#test<-submission %>% left_join(train_test, by="id")

#}
#print(best_num)
#print(best)
#}
submission<-submission%>%rename(result=pred)
fwrite(submission,"./project/volume/data/processed/optimized_submission.csv", row.names=FALSE)
#View(submission)
