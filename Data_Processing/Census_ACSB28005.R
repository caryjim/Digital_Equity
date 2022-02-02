#' ---
#' title: "U.S. Census ACS 2019 Table B28005"
#' author: "Cary K. Jim"
#' output: github_document 
#' ---
## Data Source: U.S. Census Data <https://data.census.gov/cedsci/> 
# Initial data processing for Census ACS Table B28005
# B28005 Table contains number of household, household with under 18, PC ownership
# and subscription type information

# Initial data cleaning was done in Excel where margin of errors are removed
# Column headings have been shorten for ease of reading
library(tidyverse)
setwd("D://Documents//R//Dissertation")

# This data file has been exported from Census Data Portal at ZIP-code level

b28005_ZIP <- read.csv('./Datasets/Census/ACS_5Y2019.B28005_data_ZIP_code.csv',
                       header = T, stringsAsFactors = T)
head(b28005_ZIP)
str(b28005_ZIP)

b28005_County <- read.csv('./Datasets/Census/ACSDT5Y2019.B28005.csv',
                          header = T, stringsAsFactors = T)
head(b28005_County)
str(b28005_County)

# Append general population count to this table by zip level
## First, I had to retrieve a population data file at ZIP level from Census
pop_acs <- read.csv("./Datasets/Census/ACS_population.csv", header = T, stringsAsFactors = T)

head(pop_acs)
str(pop_acs)

# Similar to other datasets, ZIP has been read as integer
b28005_ZIP[3] <- lapply(b28005_ZIP[3], as.character)
b28005_ZIP[3] <- lapply(b28005_ZIP[3], as.factor)

str(b28005_ZIP) # There are 33120 levels in ZIP

# Check data again
str(b28005_ZIP)

# Check for missing values - incomplete cases (None returned)
b28005_ZIP[!complete.cases(b28005_ZIP),]



# Convert ZIP level data columns to percentages

## How many percent of household with children estimated to have computer?
b28005_ZIP$Percent_with_PC <- b28005_ZIP$Stu_Has_computer/b28005_ZIP$Home_Stu

## How many percent of household with children estimated to not have computer?
b28005_ZIP$Percent_no_PC <- (1 - b28005_ZIP$Percent_with_PC)

## How many percent of children at home with computer and internet (both broadband and dial-up)?
b28005_ZIP$With_Both_PC_internet <- (b28005_ZIP$Stu_Has_computer_With_dial.up + b28005_ZIP$Stu_Has_computer_With_broadband)/b28005_ZIP$Home_Stu

## How many percent of children at home with computer and broadband internet?
b28005_ZIP$With_PC_broadband <- b28005_ZIP$Stu_Has_computer_With_broadband/b28005_ZIP$Home_Stu

## How many percent of children at home with computer and dial-up service?
b28005_ZIP$With_PC_dialup <- b28005_ZIP$Stu_Has_computer_With_dial.up/b28005_ZIP$Home_Stu

## How many percent of children at home have PC but no internet?
b28005_ZIP$With_PC_noInternet <- b28005_ZIP$Stu_Has_computer_No_Internet/b28005_ZIP$Home_Stu

# View Column Names
colnames(b28005_ZIP)

## Drop the columns with raw estimated counts.
b28005_ZIP_c <- b28005_ZIP[, c(1:5, 11:16 )]

# Export this file first
# write.csv(b28005_ZIP_c, "./Export/b28005_zip_percent.csv", row.names = F)

# Join the two dataframes
ACS_internet <- left_join(b28005_ZIP_c, pop_acs, by = "GEO_ID")

#export the census file
#write.csv(ACS_internet, "./Export/b28005_mod.csv", row.names = F)
