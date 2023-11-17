#Paula Vauhkonen
#17.11.2023
#Harjoitus 3
#data source: http://www.archive.ics.uci.edu/dataset/320/student+performance

# Read both student-mat.csv and student-por.csv into R (from the data folder) and explore the structure and dimensions of the data. (1 point)

library(tidyverse)
library(boot)
library(readr)
library(dplyr)
library(ggplot2)
library(tidyr)

studentmat <- read_delim("student-mat.csv", ";")
studentpor <- read_delim("student-por.csv", ";")


str(studentmat)
dim(studentmat)

# student-mat csv contains 395 observations, 33 variables of different types.

str(studentpor)
dim(studentpor)

# student-por csv contains 649 observations, 33 variables of different types.

#Join the two data sets using all other variables than "failures", "paid", "absences", "G1", "G2", "G3" as (student) identifiers. 
#Keep only the students present in both data sets. Explore the structure and dimensions of the joined data. (1 point)

# columns that vary in the two data sets
free_cols <- c("failures", "paid", "absences", "G1", "G2", "G3")

# the rest of the columns are common identifiers used for joining the data sets
join_cols <- setdiff(colnames(studentpor), free_cols)

# join the two data sets by the selected identifiers
math_por <- inner_join(studentmat, studentpor, by = join_cols, suffix = c(".math", ".por"))

str(math_por)
dim(math_por)

# The joined data has 370 observations and 39 columns.

#Get rid of the duplicate records in the joined data set. Either a) copy the solution from the exercise "3.3 The if-else structure" to combine the 'duplicated' answers in the joined data, 
# or b) write your own solution to achieve this task. (1 point)

# print out the column names of 'math_por'
colnames(math_por)

# create a new data frame with only the joined columns
alc <- select(math_por, all_of(join_cols))

# print out the columns not used for joining (those that varied in the two data sets)
free_cols

alc <- select(math_por, all_of(join_cols))

for(col_name in free_cols) {
  two_cols <- select(math_por, starts_with(col_name))
  first_col <- select(two_cols, 1)[[1]]
  if(is.numeric(first_col)) {
    alc[col_name] <- round(rowMeans(two_cols))
  } else {
    alc[col_name] <- first_col
  }
}

# glimpse at the new combined data
alc 

#Take the average of the answers related to weekday and weekend alcohol consumption to create a new column 'alc_use' to the joined data. 
#Then use 'alc_use' to create a new logical column 'high_use' which is TRUE for students for which 'alc_use' is greater than 2 (and FALSE otherwise). (1 point)

alc <- mutate(alc, alc_use = (Dalc + Walc) / 2)
alc <- mutate(alc, high_use = alc_use>2)

#Glimpse at the joined and modified data to make sure everything is in order. The joined data should now have 370 observations. 
#Save the joined and modified data set to the ‘data’ folder, using for example write_csv() function (readr package, part of tidyverse). (1 point)

glimpse(alc)
# 370 rows, 35 columns
setwd("~/IODS-project/data")
write_csv(x = alc, "alc.csv")
