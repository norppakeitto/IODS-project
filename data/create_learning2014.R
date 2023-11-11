#Paula Vauhkonen
#11.11.2023
#Macilla tehty harjoitus 2
#data source: http://www.helsinki.fi/~kvehkala/JYTmooc/JYTOPKYS3-data.txt
library(tidyverse)
library(GGally)
install.packages("utf8")
lrn14 <- read.table("http://www.helsinki.fi/~kvehkala/JYTmooc/JYTOPKYS3-data.txt", sep="\t", header=TRUE)

dim(lrn14)

# The dataframe has 183 rows and 60 columns.

str(lrn14)

# This command shows the data structure as variable names and values rowvise.


