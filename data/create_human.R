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
colnames(hd)[8] <- "GNI-HDIrank"

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

# 195 obs and 19 variables, as should be

setwd("M:/Tutkimus/Tohtorinkoulutus/R/Aineistot/IODS-project/data")
write_csv(x = human, "human.csv")



