library(readxl)
library(dplyr)
library(tidyr)
library(stringr)

#Name of the file
filename<-"data/YB Friday 2-12-16.xlsx"

#Read data in
data<-read_excel(filename)
data<-as.data.frame(data)

#Filter per year using the pattern ", YB"
#Divide data into two columns
data2<-data %>% separate(`Youth Build Friday Update Report`,into=c("grantee","program_number_parse"),sep=", YB")

#Get number of columns and rename the columns
ncols<-length(colnames(data2))

col.unit<-"col"
new.col.names<-rep(col.unit,ncols-2)
new.col.num<-as.character(3:ncols)
new.col.names<-str_c(new.col.names,new.col.num)

colnames(data2)<-c(colnames(data2)[1:2],new.col.names)

#Add YB again to that colum
data2<-data2 %>% transform(program_number_parse=str_c("YB",program_number_parse))

data2<-data2 %>% mutate(program_number=program_number_parse)

#Divide the program number into five categories based on the dates
data2 %>% separate(program_number, into=c("YB","number","number"))


#YB-26216-14-60-A-40 
#pattern<-"YB-"
