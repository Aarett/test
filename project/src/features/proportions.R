library(data.table)
library(dplyr)

train<-fread("./project/volume/data/raw/test_file.csv") #./project/volume/data/raw/test_file.csv

mean(t(train[1,2:(length(train)-1)]))

feature<-train %>% mutate(modified_proportions=((V1+V2+V3+V4+V5+V6+V7+V8+V9+V10)-5)) %>% select(id,modified_proportions) #*.4109

feature<-feature %>% filter(modified_proportions==5)

fwrite(feature,"./project/volume/data/interim/modified_proportions.csv")
