# Assignment 6 data wrangling
  
## 1. Load the data sets (BPRS and RATS) into R using as the source the GitHub repository of MABS, where they are given in the wide form:

library(readr)
library(tidyverse)
BPRS <- read.table("https://raw.githubusercontent.com/KimmoVehkalahti/MABS/master/Examples/data/BPRS.txt", sep="", header=TRUE)  
rats <- read.table("https://raw.githubusercontent.com/KimmoVehkalahti/MABS/master/Examples/data/rats.txt", sep="\t",header=TRUE)  

## take a look at the data sets: check their variable names, view the data contents and structures, and create some brief summaries of the variables 

str(BPRS)
dim(BPRS)
BPRS%>% summary()

# The BPRS data has 40 observations and 11 variables. The variables are "treatment" (this is a factor variable with two levels), "subject" (20 subjects in each level, total number of individuals is 40),
# and weekly psychiatric evaluation points ("week 0" - "week 8"). The weekly measurements are numeric, but "treatment" and "subject" should be factors.
# looking at the numerical summaries, the mean is always a bit greater than median, so the distributions are positively skewed.
# In the wide form, each subjects' weekly measurements are presented in one row.

str(rats)
dim(rats)
rats%>% summary()

# The rats data has 16 observations and 13 variables. The variables are "ID" (= 16 observations, individual rats), "Group" (levels 1,2,3) and "WD" that is the rats' measured weight at
# certain days. The WD values are numeric, also positively skewed. "ID" and "Group" should be factors.
# Eight rats belong to group 1, four to group 2 and four to group 3.
# In the wide form, each rat's consecutive weight measurements are presented in one row.

## 2. Convert the categorical variables of both data sets to factors.

BPRS <- BPRS %>% mutate(treatment = as.factor(treatment), subject = as.factor(subject))

rats <- rats %>% mutate(ID = as.factor(ID), Group = as.factor(Group))

## 3. Convert the data sets to long form. Add a week variable to BPRS and a Time variable to RATS. 

BPRSL <-  pivot_longer(BPRS, cols = -c(treatment, subject),
                    names_to = "weeks", values_to = "bprs") %>% mutate(week = as.integer(substr(weeks, 5,5))) %>% arrange(week) 
  
RATSL <- pivot_longer(rats, cols=-c(ID,Group), names_to = "WD",values_to = "Weight")  %>%  mutate(Time = as.integer(substr(WD,3,4))) %>% arrange(Time)


## 4. Now, take a serious look at the new data sets and compare them with their wide form versions: Check the variable names, view the data contents and structures, and create some brief summaries of the variables. 
# Make sure that you understand the point of the long form data and the crucial difference between the wide and the long forms before proceeding the to Analysis exercise.

str(BPRSL)
dim(BPRSL)
BPRSL%>% summary()

# In the BPRS long form, we have 360 "individual" observations of five variables (treatment, subject, weeks, bprs and week).

str(RATSL)
dim(RATSL)
RATSL%>% summary()

# In the rats long form, we have 176 "individual" observations of five variables (ID, Group, WD, Weight and Time). 


## write the wrangled data sets to files in your IODS-project data-folder.

write_csv(x = BPRSL, "BPRSL.csv")

write_csv(x = RATSL, "RATSL.csv")
