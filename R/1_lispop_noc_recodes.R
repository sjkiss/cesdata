#### Install.packages ####
to.install <- c('haven', 'remotes', 'tidyverse', 'dialogue')
new.packages <- to.install[!(to.install %in% installed.packages()[,"Package"])]
if(length(new.packages)) install.packages(new.packages)

library(haven)
library(tidyverse)
#### load ces2019 ####
#This will bring up a dialogue box that allows the user to choose a stata file of the ces19 phone survey.
ces19phone<-read_dta(file.choose(), encoding="utf-8")

#url
file_url<-'https://github.com/sjkiss/CES_Analysis/raw/master/Data/unique-occupations-updated.csv'
noc<-read.csv(file_url)
#Convert ces19phone occuption answers to all lower
ces19phone$p52<-tolower(ces19phone$p52)
#start with LISPOP noc file
noc %>%
  #select variables p52 and NOC
  select(p52, NOC) %>%
  #merge with ces19phone by variable p52 and store in object out
  full_join(ces19phone, ., by="p52")->out


#Run Dialogue Box
library(svDialogs)
