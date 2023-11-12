#Paula Vauhkonen
#11.11.2023
#Harjoitus 2
#data source: http://www.helsinki.fi/~kvehkala/JYTmooc/JYTOPKYS3-data.txt
#metadata:http://www.helsinki.fi/~kvehkala/JYTmooc/JYTOPKYS2-meta.txt

library(tidyverse)
library(GGally)
library(ddplyr)
install.packages("utf8")
lrn14 <- read.table("http://www.helsinki.fi/~kvehkala/JYTmooc/JYTOPKYS3-data.txt", sep="\t", header=TRUE)

# exploring the structure and dimensions of the data. 

dim(lrn14)

# The dataframe has 183 rows and 60 columns.

str(lrn14)

# This command returns the variables, their type (character, numeral, integral etc.) and character values rowvise.

# First we create an analysis dataset with the variables gender, age, attitude, deep, stra, surf and points by combining questions in the learning2014 data.
# All combination variables are scaled to the original scales (by taking the mean). 
# Observations where the exam points variable is zero are excluded. (The data should then have 166 observations and 7 variables)

# the variable "attidude" is formed (and a new column is created) from the variable "Attitude" by scaling it back according to the metadata.
lrn14$Attitude / 10

lrn14$attitude <- lrn14$Attitude / 10

# questions related to deep, surface and strategic learning are then combined
deep_questions <- c("D03", "D11", "D19", "D27", "D07", "D14", "D22", "D30","D06",  "D15", "D23", "D31")
surface_questions <- c("SU02","SU10","SU18","SU26", "SU05","SU13","SU21","SU29","SU08","SU16","SU24","SU32")
strategic_questions <- c("ST01","ST09","ST17","ST25","ST04","ST12","ST20","ST28")

# columns related to deep learning 
deep_columns <- select(lrn14, one_of(deep_questions))
# column 'deep' is created by averaging
lrn14$deep <- rowMeans(deep_columns)

# working similarly with the surface and strategic questions
surface_columns <- select(lrn14, one_of(surface_questions))
lrn14$surf <- rowMeans(surface_columns)


strategic_columns <- select(lrn14, one_of(strategic_questions))
lrn14$stra <- rowMeans(strategic_columns)

# Choosing the columns to keep in the analysis

keep_columns <- c("gender","Age","attitude", "deep", "stra", "surf", "Points")

# 'keep_columns' to create a new dataset
learning2014 <- select(lrn14, one_of(keep_columns))

# print out the column names of the data
colnames(learning2014)

# Notice the variables "Age" and "Point" have an upper case letter. We better change those according to the instructions.

# change the name of the second column
colnames(learning2014)[2] <- "age"

# change the name of "Points" to "points"
colnames(learning2014)[7] <- "points"

# print out the new column names of the data
colnames(learning2014)

# Last, exclude cases with zero points
learning2014 <- filter(learning2014, points > "0")
learning2014

# Now create a .csv file

install.packages('readr')
library(readr)

setwd("~/IODS-project")
write_csv(x = learning2014, "learning2014.csv")

# Then read the data and check for correct structure
learning2014 <- read_csv("learning2014.csv")

head(learning2014)
str(learning2014)
