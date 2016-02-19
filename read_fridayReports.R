library(readxl)
library(dplyr)
library(tidyr)
library(stringr)

filename<-"YB Friday 2-12-16.xlsx"

#Read data in
data<-read_excel(filename)
data<-as.data.frame(data)

# Divide data into dates


#Filter per year using the pattern ", YB"
data2<-data %>% separate(`Youth Build Friday Update Report`,into=c("grantee","program_number"),sep=", YB")

#Add YB again to that colum
data2<-data2 %>% transform(program_number=str_c("YB",program_number))

samplesInput<-transform(samplesInput,Peaks = paste("../",Peaks,sep=""))
#data2<-data %>% separate(`Youth Build Friday Update Report`,into=c("grantee","program_number"),sep=",")
tmp2<-separate(tmp,foreground.genes,into=c("gene1","gene2"),sep= "/")


#YB-26216-14-60-A-40 
pattern<-"YB\-\\d+-09\\"
#pattern<-"YB-"
