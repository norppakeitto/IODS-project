library(readr)
hd <- read_csv("https://raw.githubusercontent.com/KimmoVehkalahti/Helsinki-Open-Data-Science/master/datasets/human_development.csv")
gii <- read_csv("https://raw.githubusercontent.com/KimmoVehkalahti/Helsinki-Open-Data-Science/master/datasets/gender_inequality.csv", na = "..")

# structure, dimensions, summaries
str(gii)
dim(gii)

str(hd)
dim(hd)

gii %>% summary()

hd %>% summary()

# Changing variable names according to instructions, also adding to more variables to "gii"

colnames(hd)[3]<- "HDI"
colnames(hd)[4] <- "Life.Exp"
colnames(hd)[5] <- "Edu.Exp"
colnames(hd)[6] <- "Edu.Mean"
colnames(hd)[7] <- "GNI"
colnames(hd)[8] <- "GNIrank-HDIrank"

colnames(gii)[3] <- "GII"
colnames(gii)[4] <- "Mat.Mor"
colnames(gii)[5] <- "Ado.Birth"
colnames(gii)[6] <- "Parli.F"
colnames(gii)[7] <-"Edu2.F"
colnames(gii)[8] <-"Edu2.M"
colnames(gii)[9] <-"Labo.F"
colnames(gii)[10] <-"Labo.M"

library(tidyverse)

Gii <- gii %>% mutate(Edu2.FM = Edu2.F/Edu2.M) %>% 
  mutate(Labo.FM = Labo.F/Labo.M)

# Join together the two datasets using the variable Country as the identifier. Saving the data.

human <- inner_join(Gii, hd, by = "Country")

dim(human)

# 195 obs and 19 variables, as should be.

setwd("M:/Tutkimus/Tohtorinkoulutus/R/Aineistot/IODS-project/data")
write_csv(x = human, "human.csv")

# DATA WRALGLING PART II #

# Original data: https://hdr.undp.org/data-center/human-development-index#/indicies/HDI
# Metadata: https://hdr.undp.org/system/files/documents/technical-notes-calculating-human-development-indices.pdf

library(readr)
human <- read_csv("human.csv")

str(human)
dim(human)

# The "human" dataset is derived from the United Nations Development Programme. Along with measurements of economic growth, the data contains metrics that describe human well-being
# in UN countries and other geographic areas.


# The dataset "human" consists of 19 variables and 195 observations. The observations present individual countries or regions (such as East Asia and the Pacific; World).

# The "Country" is a character, all other variables are numeric.

# Mat.Mor = Maternal mortality ratio
# Ado.Birth = Adolescent birth rate
# Parli.F = Percentange of female representatives in parliament
# Edu2.F = Proportion of females with at least secondary education
# Edu2.M = Proportion of males with at least secondary education       
# Labo.F = Proportion of females in the labour force        
# Labo.M = Proportion of males in the labour force       
# Edu2.FM = Female to male ratio with at least secondary education (Edu2.F/Edu2.M)      
# Labo.FM = Female to male ratio in the labour force (Labo.F/Labo.M) 
# Life.Exp = Life expectancy at birth    
# Edu.Exp = Expected years of schooling   
# Edu.Mean = Mean years of schooling
# GNI = Gross National Income per capita          


# Some of the numeric variables describe the geometric mean of normalized indices for certain dimensions. 

# GII = The Gender inequality index, that is a summary measure of the dimensions "Health", "Empowerment" and "Labour market".

# The dimension "Health" indicators are Maternal mortality ratio are Adolescent birth rate.
# The dimension "Empowerment" indicators are Proportion of females and males with at least secondary education and Female and male shares of parliamentary seats.
# The dimension "Labour market" indicators are Female and male labour force participation rates.



# HDI  = Human developmental index, that is a summary measure of the dimensions "Long and healthy life", "Access to knowledge" and "A decent standard of living". 

# The dimension "Long and healthy life" indicator is Life expectancy at birth.
# The dimension "Access to knowledge" indicators are Expected years of schooling and Mean years of schooling
# The dimension "A decent standard of living" indicator is GNI per capita. 


# Minimum and maximum values are set in order to transform the indicators expressed in different units into indices between 0 and 1. 
# The minimum values act as “the natural zeros” and maximum values as “aspirational targets”, from which component indicators are standardized using the formula:
# DIMENSION INDEX = (observation value – minimum value)/(maximum value – minimum value)



# Finally, there are three rank variables retrieved from the former indices:

# GII Rank = Gender inequality index rank
# HDI Rank  = Human developmental index rank
# GNIrank-HDIrank = Gross National Income per capita rank - Human developmental index rank

#########################################

# Exclude unneeded variables: 
library(tidyverse)
human_cleaned <- human %>% select ("Country", "Edu2.FM", "Labo.FM", "Edu.Exp", "Life.Exp", "GNI", "Mat.Mor", "Ado.Birth", "Parli.F")

#Remove all rows with missing values:
human_cleaned2 <- human_cleaned %>% drop_na()

#Remove the observations which relate to regions instead of countries.
# These are rows 156-162.
human_cleaned3 <- human_cleaned2 %>% slice(-c(156:162))

#The data now has 155 observations and 9 variables (including the "Country" variable). We'll overwrite this data to previous human.csv.


setwd("M:/Tutkimus/Tohtorinkoulutus/R/Aineistot/IODS-project/data")
write_csv(x = human_cleaned3, "human.csv")