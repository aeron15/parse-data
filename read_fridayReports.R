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
#YB-26216-14-60-A-40 
data2<-data2 %>% separate(program_number_parse, into=c("YB","number1","year","number3","letter","state_number"),sep="-")

#Eliminate NA na.omit
data2<-na.omit(data2)

#Group data by year
#by_year<-data2 %>%  group_by(year)

#Group data by year
all.years<-data2 %>% select(year) %>% distinct

#Rename first column to extract date 
#Get other columns
ncols<-length(colnames(data))

col.unit<-"col"
new.col.names<-rep(col.unit,ncols-1)
new.col.num<-as.character(2:ncols)
new.col.names<-str_c(new.col.names,new.col.num)
colnames(data)[1]="first"
colnames(data)<-c(colnames(data)[1],new.col.names)

#Get date of the report
date.row<-filter(data,grepl("Report run for:",first))
date.string<-date.row$col2

#Get data for the report
# from Windows Excel:
#origin = "1899-12-30"
# from Mac Excel:
#origin = "1904-01-01"

report.date<-as.Date(as.numeric(date.string),origin = "1899-12-30")

#Add report date to a new colum


# Create column with data for the report
#List of data per year
list.per.year<-list()

