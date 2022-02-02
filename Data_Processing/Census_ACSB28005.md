U.S. Census ACS 2019 Table B28005
================
Cary K. Jim
2022-02-01

``` r
## Data Source: U.S. Census Data <https://data.census.gov/cedsci/> 
# Initial data processing for Census ACS Table B28005
# B28005 Table contains number of household, household with under 18, PC ownership
# and subscription type information

# Initial data cleaning was done in Excel where margin of errors are removed
# Column headings have been shorten for ease of reading
library(tidyverse)
```

    ## -- Attaching packages --------------------------------------- tidyverse 1.3.1 --

    ## v ggplot2 3.3.5     v purrr   0.3.4
    ## v tibble  3.1.6     v dplyr   1.0.7
    ## v tidyr   1.1.4     v stringr 1.4.0
    ## v readr   2.1.1     v forcats 0.5.1

    ## -- Conflicts ------------------------------------------ tidyverse_conflicts() --
    ## x dplyr::filter() masks stats::filter()
    ## x dplyr::lag()    masks stats::lag()

``` r
setwd("D://Documents//R//Dissertation")

# This data file has been exported from Census Data Portal at ZIP-code level

b28005_ZIP <- read.csv('./Datasets/Census/ACS_5Y2019.B28005_data_ZIP_code.csv',
                       header = T, stringsAsFactors = T)
head(b28005_ZIP)
```

    ##           GEO_ID Geographic_Area ZIP Total_Household_byZIP Home_Stu
    ## 1 8600000US00601           ZCTA5 601                 17038     3540
    ## 2 8600000US00602           ZCTA5 602                 37668     6878
    ## 3 8600000US00603           ZCTA5 603                 45586     8961
    ## 4 8600000US00606           ZCTA5 606                  6373     1183
    ## 5 8600000US00610           ZCTA5 610                 26556     5001
    ## 6 8600000US00612           ZCTA5 612                 58764    11819
    ##   Stu_Has_computer Stu_Has_computer_With_dial.up
    ## 1             2797                             0
    ## 2             5693                          1071
    ## 3             8103                            55
    ## 4              712                             0
    ## 5             4388                          1079
    ## 6            10491                            10
    ##   Stu_Has_computer_With_broadband Stu_Has_computer_No_Internet Stu_No.computer
    ## 1                            2247                          550             743
    ## 2                            4052                          570            1185
    ## 3                            7172                          876             858
    ## 4                             517                          195             471
    ## 5                            2825                          484             613
    ## 6                            9331                         1150            1328

``` r
str(b28005_ZIP)
```

    ## 'data.frame':    33120 obs. of  10 variables:
    ##  $ GEO_ID                         : Factor w/ 33120 levels "8600000US00601",..: 1 2 3 4 5 6 7 8 9 10 ...
    ##  $ Geographic_Area                : Factor w/ 1 level "ZCTA5": 1 1 1 1 1 1 1 1 1 1 ...
    ##  $ ZIP                            : int  601 602 603 606 610 612 616 617 622 623 ...
    ##  $ Total_Household_byZIP          : int  17038 37668 45586 6373 26556 58764 9981 23735 6678 41664 ...
    ##  $ Home_Stu                       : int  3540 6878 8961 1183 5001 11819 1357 4895 735 8221 ...
    ##  $ Stu_Has_computer               : int  2797 5693 8103 712 4388 10491 1170 4405 295 3435 ...
    ##  $ Stu_Has_computer_With_dial.up  : int  0 1071 55 0 1079 10 0 94 28 0 ...
    ##  $ Stu_Has_computer_With_broadband: int  2247 4052 7172 517 2825 9331 1018 3475 228 3178 ...
    ##  $ Stu_Has_computer_No_Internet   : int  550 570 876 195 484 1150 152 836 39 257 ...
    ##  $ Stu_No.computer                : int  743 1185 858 471 613 1328 187 490 440 4786 ...

``` r
b28005_County <- read.csv('./Datasets/Census/ACSDT5Y2019.B28005.csv',
                          header = T, stringsAsFactors = T)
head(b28005_County)
```

    ##           GEO_ID COUNTY.ID    COUNTY.NAME    STATE Total_Household
    ## 1 0500000US01001      1001 Autauga County  Alabama           54815
    ## 2 0500000US01003      1003 Baldwin County  Alabama          209822
    ## 3 0500000US01005      1005 Barbour County  Alabama           22475
    ## 4 0500000US01007      1007    Bibb County  Alabama           20600
    ## 5 0500000US01009      1009  Blount County  Alabama           57130
    ## 6 0500000US01011      1011 Bullock County  Alabama            9811
    ##   Total_household_w_children Home_hasPC Home_hasPC_andBroadband
    ## 1                      13205      12917                   11878
    ## 2                      46133      45591                   42506
    ## 3                       5307       4622                    3586
    ## 4                       4586       4272                    4108
    ## 5                      13389      12730                   11487
    ## 6                       2128       1854                    1162
    ##   Home_withNoInternet Home_with_NoPC Percent_Home_w_Stu Percent_Stu_home_w_PC
    ## 1                1039            288               0.24                  0.98
    ## 2                3074            542               0.22                  0.99
    ## 3                1029            685               0.24                  0.87
    ## 4                 164            314               0.22                  0.93
    ## 5                1144            659               0.23                  0.95
    ## 6                 692            274               0.22                  0.87
    ##   Percent_Stu_PC_and_Broadband
    ## 1                          0.9
    ## 2                         0.92
    ## 3                         0.68
    ## 4                          0.9
    ## 5                         0.86
    ## 6                         0.55

``` r
str(b28005_County)
```

    ## 'data.frame':    3142 obs. of  13 variables:
    ##  $ GEO_ID                      : Factor w/ 3142 levels "0500000US01001",..: 1 2 3 4 5 6 7 8 9 10 ...
    ##  $ COUNTY.ID                   : int  1001 1003 1005 1007 1009 1011 1013 1015 1017 1019 ...
    ##  $ COUNTY.NAME                 : Factor w/ 1877 levels "Abbeville County",..: 83 90 101 150 165 226 236 249 297 319 ...
    ##  $ STATE                       : Factor w/ 51 levels " Alabama"," Alaska",..: 1 1 1 1 1 1 1 1 1 1 ...
    ##  $ Total_Household             : int  54815 209822 22475 20600 57130 9811 19505 111484 33128 25628 ...
    ##  $ Total_household_w_children  : int  13205 46133 5307 4586 13389 2128 4455 24817 7065 5245 ...
    ##  $ Home_hasPC                  : int  12917 45591 4622 4272 12730 1854 3684 24327 6477 5166 ...
    ##  $ Home_hasPC_andBroadband     : int  11878 42506 3586 4108 11487 1162 2969 21806 5846 4730 ...
    ##  $ Home_withNoInternet         : int  1039 3074 1029 164 1144 692 629 2432 544 433 ...
    ##  $ Home_with_NoPC              : int  288 542 685 314 659 274 771 490 588 79 ...
    ##  $ Percent_Home_w_Stu          : num  0.24 0.22 0.24 0.22 0.23 0.22 0.23 0.22 0.21 0.2 ...
    ##  $ Percent_Stu_home_w_PC       : Factor w/ 45 levels "#DIV/0!","0.46",..: 43 44 32 38 40 32 28 43 37 44 ...
    ##  $ Percent_Stu_PC_and_Broadband: Factor w/ 64 levels "#DIV/0!","0.25",..: 54 56 32 54 50 19 31 52 47 54 ...

``` r
# Append general population count to this table by zip level
## First, I had to retrieve a population data file at ZIP level from Census
pop_acs <- read.csv("./Datasets/Census/ACS_population.csv", header = T, stringsAsFactors = T)

head(pop_acs)
```

    ##           GEO_ID Geographic_AREA Total_Pop_Est
    ## 1 8600000US00601     ZCTA5 00601         17113
    ## 2 8600000US00602     ZCTA5 00602         37751
    ## 3 8600000US00603     ZCTA5 00603         47081
    ## 4 8600000US00606     ZCTA5 00606          6392
    ## 5 8600000US00610     ZCTA5 00610         26686
    ## 6 8600000US00612     ZCTA5 00612         59369

``` r
str(pop_acs)
```

    ## 'data.frame':    33120 obs. of  3 variables:
    ##  $ GEO_ID         : Factor w/ 33120 levels "8600000US00601",..: 1 2 3 4 5 6 7 8 9 10 ...
    ##  $ Geographic_AREA: Factor w/ 33120 levels "ZCTA5 00601",..: 1 2 3 4 5 6 7 8 9 10 ...
    ##  $ Total_Pop_Est  : int  17113 37751 47081 6392 26686 59369 10022 23750 6741 41746 ...

``` r
# Similar to other datasets, ZIP has been read as integer
b28005_ZIP[3] <- lapply(b28005_ZIP[3], as.character)
b28005_ZIP[3] <- lapply(b28005_ZIP[3], as.factor)

str(b28005_ZIP) # There are 33120 levels in ZIP
```

    ## 'data.frame':    33120 obs. of  10 variables:
    ##  $ GEO_ID                         : Factor w/ 33120 levels "8600000US00601",..: 1 2 3 4 5 6 7 8 9 10 ...
    ##  $ Geographic_Area                : Factor w/ 1 level "ZCTA5": 1 1 1 1 1 1 1 1 1 1 ...
    ##  $ ZIP                            : Factor w/ 33120 levels "10001","10002",..: 19476 19553 19565 19719 19865 19956 20179 20193 20411 20486 ...
    ##  $ Total_Household_byZIP          : int  17038 37668 45586 6373 26556 58764 9981 23735 6678 41664 ...
    ##  $ Home_Stu                       : int  3540 6878 8961 1183 5001 11819 1357 4895 735 8221 ...
    ##  $ Stu_Has_computer               : int  2797 5693 8103 712 4388 10491 1170 4405 295 3435 ...
    ##  $ Stu_Has_computer_With_dial.up  : int  0 1071 55 0 1079 10 0 94 28 0 ...
    ##  $ Stu_Has_computer_With_broadband: int  2247 4052 7172 517 2825 9331 1018 3475 228 3178 ...
    ##  $ Stu_Has_computer_No_Internet   : int  550 570 876 195 484 1150 152 836 39 257 ...
    ##  $ Stu_No.computer                : int  743 1185 858 471 613 1328 187 490 440 4786 ...

``` r
# Check data again
str(b28005_ZIP)
```

    ## 'data.frame':    33120 obs. of  10 variables:
    ##  $ GEO_ID                         : Factor w/ 33120 levels "8600000US00601",..: 1 2 3 4 5 6 7 8 9 10 ...
    ##  $ Geographic_Area                : Factor w/ 1 level "ZCTA5": 1 1 1 1 1 1 1 1 1 1 ...
    ##  $ ZIP                            : Factor w/ 33120 levels "10001","10002",..: 19476 19553 19565 19719 19865 19956 20179 20193 20411 20486 ...
    ##  $ Total_Household_byZIP          : int  17038 37668 45586 6373 26556 58764 9981 23735 6678 41664 ...
    ##  $ Home_Stu                       : int  3540 6878 8961 1183 5001 11819 1357 4895 735 8221 ...
    ##  $ Stu_Has_computer               : int  2797 5693 8103 712 4388 10491 1170 4405 295 3435 ...
    ##  $ Stu_Has_computer_With_dial.up  : int  0 1071 55 0 1079 10 0 94 28 0 ...
    ##  $ Stu_Has_computer_With_broadband: int  2247 4052 7172 517 2825 9331 1018 3475 228 3178 ...
    ##  $ Stu_Has_computer_No_Internet   : int  550 570 876 195 484 1150 152 836 39 257 ...
    ##  $ Stu_No.computer                : int  743 1185 858 471 613 1328 187 490 440 4786 ...

``` r
# Check for missing values - incomplete cases (None returned)
b28005_ZIP[!complete.cases(b28005_ZIP),]
```

    ##  [1] GEO_ID                          Geographic_Area                
    ##  [3] ZIP                             Total_Household_byZIP          
    ##  [5] Home_Stu                        Stu_Has_computer               
    ##  [7] Stu_Has_computer_With_dial.up   Stu_Has_computer_With_broadband
    ##  [9] Stu_Has_computer_No_Internet    Stu_No.computer                
    ## <0 rows> (or 0-length row.names)

``` r
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
```

    ##  [1] "GEO_ID"                          "Geographic_Area"                
    ##  [3] "ZIP"                             "Total_Household_byZIP"          
    ##  [5] "Home_Stu"                        "Stu_Has_computer"               
    ##  [7] "Stu_Has_computer_With_dial.up"   "Stu_Has_computer_With_broadband"
    ##  [9] "Stu_Has_computer_No_Internet"    "Stu_No.computer"                
    ## [11] "Percent_with_PC"                 "Percent_no_PC"                  
    ## [13] "With_Both_PC_internet"           "With_PC_broadband"              
    ## [15] "With_PC_dialup"                  "With_PC_noInternet"

``` r
## Drop the columns with raw estimated counts.
b28005_ZIP_c <- b28005_ZIP[, c(1:5, 11:16 )]

# Export this file first
# write.csv(b28005_ZIP_c, "./Export/b28005_zip_percent.csv", row.names = F)

# Join the two dataframes
ACS_internet <- left_join(b28005_ZIP_c, pop_acs, by = "GEO_ID")

#export the census file
#write.csv(ACS_internet, "./Export/b28005_mod.csv", row.names = F)
```
