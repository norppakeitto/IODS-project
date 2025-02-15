#Create a folder named ‘data’ in your IODS-project folder. Then create a new R script with RStudio. Write your name, date and a one sentence file description as a comment on the top of the script file. 
#Save the script for example as 'create_learning2014.R' in the ‘data’ folder. Complete the rest of the steps in that script.

#Read the full learning2014 data from http://www.helsinki.fi/~kvehkala/JYTmooc/JYTOPKYS3-data.txt into R (the separator is a tab ("\t") and the file includes a header) 
#and explore the structure and dimensions of the data. Write short code comments describing the output of these explorations. (1 point)

#Create an analysis dataset with the variables gender, age, attitude, deep, stra, surf and points by combining questions in the learning2014 data, 
#as defined in the Exercise Set and also on the bottom part of the following page (only the top part of the page is in Finnish).
#http://www.helsinki.fi/~kvehkala/JYTmooc/JYTOPKYS2-meta.txt. Scale all combination variables to the original scales (by taking the mean). 
#Exclude observations where the exam points variable is zero. (The data should then have 166 observations and 7 variables) (1 point)

#Set the working directory of your R session to the IODS Project folder (study how to do this with RStudio). 
#Save the analysis dataset to the ‘data’ folder, using for example write_csv() function (readr package, part of tidyverse). 
#You can name the data set for example as learning2014.csv. See ?write_csv for help or search the web for pointers and examples. 
#Demonstrate that you can also read the data again by using read_csv().  (Use `str()` and `head()` to make sure that the structure of the data is correct).  (3 points)

# Paula Vauhkonen
# date()
# Exercise 2 

library(tidyverse)
library(GGally)

lrn14 <- read.table("http://www.helsinki.fi/~kvehkala/JYTmooc/JYTOPKYS3-data.txt", sep="\t", header=TRUE)
