NECS ELSI K-12 Public School Data
================
Cary K. Jim

Data Source: NCES <https://nces.ed.gov/ccd/elsi/>

Libraries

``` r
# Import libraries 
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
library(stringr)
library(janitor)
```

    ## 
    ## Attaching package: 'janitor'

    ## The following objects are masked from 'package:stats':
    ## 
    ##     chisq.test, fisher.test

# NECS ESLI K-12 Public School Data

## 2019-2020 School Level Data

``` r
#The first 6 line of the file is description and not headings

school <- read.csv("./Datasets/NCES/ELSI_school_2019to20.csv", skip = 6, header = T, sep = ",", strip.white = TRUE, fileEncoding="UTF-8-BOM")
```

Note. One way to open the file without file path, df \<-
read_excel(file.choose())

### View Dataframe

``` r
# A common issue with the NCES ELSI exported file is the notes at the end of the file where comments of the data source and how missing values are marked in the dataset. 
print(tail(school))
```

    ##                                                                                                                                                                                                                                                                 School.Name
    ## 99337                                                                                                                                                                                                                                              ZWOLLE ELEMENTARY SCHOOL
    ## 99338                                                                                                                                                                                                                                                    ZWOLLE HIGH SCHOOL
    ## 99339 Data Source: U.S. Department of Education National Center for Education Statistics Common Core of Data (CCD) Public Elementary/Secondary School Universe Survey 2019-20 v.1a; Public Elementary/Secondary School Universe Survey Geographic Data (EDGE) 2019-20 v.1a.
    ## 99340                                                                                                                                                                                                                         † indicates that the data are not applicable.
    ## 99341                                                                                                                                                                                                                                – indicates that the data are missing.
    ## 99342                                                                                                                                                                                                    ‡ indicates that the data do not meet NCES data quality standards.
    ##       State.Name..Public.School..Latest.available.year
    ## 99337                                        Louisiana
    ## 99338                                        Louisiana
    ## 99339                                                 
    ## 99340                                                 
    ## 99341                                                 
    ## 99342                                                 
    ##       State.Abbr..Public.School..Latest.available.year
    ## 99337                                               LA
    ## 99338                                               LA
    ## 99339                                                 
    ## 99340                                                 
    ## 99341                                                 
    ## 99342                                                 
    ##       School.ID...NCES.Assigned..Public.School..Latest.available.year
    ## 99337                                                    220138001117
    ## 99338                                                    220138001118
    ## 99339                                                                
    ## 99340                                                                
    ## 99341                                                                
    ## 99342                                                                
    ##       Agency.ID...NCES.Assigned..Public.School..Latest.available.year
    ## 99337                                                         2201380
    ## 99338                                                         2201380
    ## 99339                                                                
    ## 99340                                                                
    ## 99341                                                                
    ## 99342                                                                
    ##       County.Name..Public.School..2019.20 County.Number..Public.School..2019.20
    ## 99337                       Sabine Parish                                 22085
    ## 99338                       Sabine Parish                                 22085
    ## 99339                                                                          
    ## 99340                                                                          
    ## 99341                                                                          
    ## 99342                                                                          
    ##       ANSI.FIPS.State.Code..Public.School..Latest.available.year
    ## 99337                                                         22
    ## 99338                                                         22
    ## 99339                                                           
    ## 99340                                                           
    ## 99341                                                           
    ## 99342                                                           
    ##       Location.ZIP..Public.School..2019.20
    ## 99337                                71486
    ## 99338                                71486
    ## 99339                                     
    ## 99340                                     
    ## 99341                                     
    ## 99342                                     
    ##       Out.of.State.Flag..Public.School..2019.20
    ## 99337                                      2-No
    ## 99338                                      2-No
    ## 99339                                          
    ## 99340                                          
    ## 99341                                          
    ## 99342                                          
    ##       Charter.School..Public.School..2019.20
    ## 99337                                   2-No
    ## 99338                                   2-No
    ## 99339                                       
    ## 99340                                       
    ## 99341                                       
    ## 99342                                       
    ##       Urban.centric.Locale..Public.School..2019.20
    ## 99337                            42-Rural: Distant
    ## 99338                             43-Rural: Remote
    ## 99339                                             
    ## 99340                                             
    ## 99341                                             
    ## 99342                                             
    ##       School.wide.Title.I..Public.School..2019.20
    ## 99337                                       1-Yes
    ## 99338                                       1-Yes
    ## 99339                                            
    ## 99340                                            
    ## 99341                                            
    ## 99342                                            
    ##       Title.I.Eligible.School..Public.School..2019.20
    ## 99337                                           1-Yes
    ## 99338                                           1-Yes
    ## 99339                                                
    ## 99340                                                
    ## 99341                                                
    ## 99342                                                
    ##       Title.I.School.Status..Public.School..2019.20
    ## 99337                   5-Title I schoolwide school
    ## 99338                   5-Title I schoolwide school
    ## 99339                                              
    ## 99340                                              
    ## 99341                                              
    ## 99342                                              
    ##       Latitude..Public.School..2019.20 Longitude..Public.School..2019.20
    ## 99337                          31.6346                          -93.6454
    ## 99338                          31.6343                          -93.6461
    ## 99339                               NA                                NA
    ## 99340                               NA                                NA
    ## 99341                               NA                                NA
    ## 99342                               NA                                NA
    ##       Congressional.Code..Public.School..2019.20
    ## 99337                                       2204
    ## 99338                                       2204
    ## 99339                                           
    ## 99340                                           
    ## 99341                                           
    ## 99342                                           
    ##       Virtual.School.Status..SY.2016.17.onward...Public.School..2019.20
    ## 99337                                                        NOTVIRTUAL
    ## 99338                                                        NOTVIRTUAL
    ## 99339                                                                  
    ## 99340                                                                  
    ## 99341                                                                  
    ## 99342                                                                  
    ##       National.School.Lunch.Program..Public.School..2019.20
    ## 99337          Yes under Community Eligibility Option (CEO)
    ## 99338          Yes under Community Eligibility Option (CEO)
    ## 99339                                                      
    ## 99340                                                      
    ## 99341                                                      
    ## 99342                                                      
    ##       Total.Students.All.Grades..Excludes.AE...Public.School..2019.20
    ## 99337                                                             482
    ## 99338                                                             309
    ## 99339                                                                
    ## 99340                                                                
    ## 99341                                                                
    ## 99342                                                                
    ##       Free.Lunch.Eligible..Public.School..2019.20
    ## 99337                                         326
    ## 99338                                         227
    ## 99339                                            
    ## 99340                                            
    ## 99341                                            
    ## 99342                                            
    ##       Direct.Certification..Public.School..2019.20
    ## 99337                                            –
    ## 99338                                            –
    ## 99339                                             
    ## 99340                                             
    ## 99341                                             
    ## 99342                                             
    ##       Reduced.price.Lunch.Eligible.Students..Public.School..2019.20
    ## 99337                                                             4
    ## 99338                                                             7
    ## 99339                                                              
    ## 99340                                                              
    ## 99341                                                              
    ## 99342                                                              
    ##       Free.and.Reduced.Lunch.Students..Public.School..2019.20
    ## 99337                                                     330
    ## 99338                                                     234
    ## 99339                                                        
    ## 99340                                                        
    ## 99341                                                        
    ## 99342                                                        
    ##       Male.Students..Public.School..2019.20
    ## 99337                                   227
    ## 99338                                   161
    ## 99339                                      
    ## 99340                                      
    ## 99341                                      
    ## 99342                                      
    ##       Female.Students..Public.School..2019.20
    ## 99337                                     255
    ## 99338                                     148
    ## 99339                                        
    ## 99340                                        
    ## 99341                                        
    ## 99342                                        
    ##       American.Indian.Alaska.Native.Students..Public.School..2019.20
    ## 99337                                                            152
    ## 99338                                                            108
    ## 99339                                                               
    ## 99340                                                               
    ## 99341                                                               
    ## 99342                                                               
    ##       Asian.or.Asian.Pacific.Islander.Students..Public.School..2019.20
    ## 99337                                                                1
    ## 99338                                                               =0
    ## 99339                                                                 
    ## 99340                                                                 
    ## 99341                                                                 
    ## 99342                                                                 
    ##       Hispanic.Students..Public.School..2019.20
    ## 99337                                        23
    ## 99338                                        11
    ## 99339                                          
    ## 99340                                          
    ## 99341                                          
    ## 99342                                          
    ##       Black.or.African.American.Students..Public.School..2019.20
    ## 99337                                                        118
    ## 99338                                                         86
    ## 99339                                                           
    ## 99340                                                           
    ## 99341                                                           
    ## 99342                                                           
    ##       White.Students..Public.School..2019.20
    ## 99337                                    118
    ## 99338                                     44
    ## 99339                                       
    ## 99340                                       
    ## 99341                                       
    ## 99342                                       
    ##       Nat..Hawaiian.or.Other.Pacific.Isl..Students..Public.School..2019.20
    ## 99337                                                                   =0
    ## 99338                                                                   =0
    ## 99339                                                                     
    ## 99340                                                                     
    ## 99341                                                                     
    ## 99342                                                                     
    ##       Two.or.More.Races.Students..Public.School..2019.20
    ## 99337                                                 70
    ## 99338                                                 60
    ## 99339                                                   
    ## 99340                                                   
    ## 99341                                                   
    ## 99342                                                   
    ##       Total.Race.Ethnicity..Public.School..2019.20
    ## 99337                                          482
    ## 99338                                          309
    ## 99339                                             
    ## 99340                                             
    ## 99341                                             
    ## 99342                                             
    ##       Full.Time.Equivalent..FTE..Teachers..Public.School..2019.20
    ## 99337                                                       28.00
    ## 99338                                                       20.00
    ## 99339                                                            
    ## 99340                                                            
    ## 99341                                                            
    ## 99342                                                            
    ##       Pupil.Teacher.Ratio..Public.School..2019.20
    ## 99337                                       17.21
    ## 99338                                       15.45
    ## 99339                                            
    ## 99340                                            
    ## 99341                                            
    ## 99342

† indicates that the data are not applicable.  
– indicates that the data are missing.  
‡ indicates that the data do not meet NCES data quality standards.

``` r
#customize the number of rows to import by skipping the top and bottom
# I can measure the length of the file first 
f <-nrow(school)
print(f) #there are 99342 rows with 6 rows removed already 
```

    ## [1] 99342

``` r
#The math is 99342 - 6 to skip the description on top, and then 4 to skip the bottom ones for the original input. Here the file is re-read with the number of rows 
school <- read.csv("./Datasets/NCES/ELSI_school_2019to20.csv", skip = 6, nrows=99338, header = T, sep = ",", strip.white = TRUE, fileEncoding="UTF-8-BOM")
```

### Dataframe and Data Types

The long column headings in the csv file can be problematic. It will be
modify at a later time.

``` r
str(school)
```

    ## 'data.frame':    99338 obs. of  37 variables:
    ##  $ School.Name                                                         : chr  "1 LT CHARLES W. WHITCOMB SCHOOL" "10TH STREET SCHOOL" "112 ALC INDEPENDENT STUDY" "112 ALC MIDDLE SCHOOL" ...
    ##  $ State.Name..Public.School..Latest.available.year                    : chr  "Massachusetts" "Washington" "Minnesota" "Minnesota" ...
    ##  $ State.Abbr..Public.School..Latest.available.year                    : chr  "MA" "WA" "MN" "MN" ...
    ##  $ School.ID...NCES.Assigned..Public.School..Latest.available.year     : chr  "250732002639" "530486002475" "270819004415" "270819004622" ...
    ##  $ Agency.ID...NCES.Assigned..Public.School..Latest.available.year     : chr  "2507320" "5304860" "2708190" "2708190" ...
    ##  $ County.Name..Public.School..2019.20                                 : chr  "Middlesex County" "Snohomish County" "Carver County" "Carver County" ...
    ##  $ County.Number..Public.School..2019.20                               : chr  "25017" "53061" "27019" "27019" ...
    ##  $ ANSI.FIPS.State.Code..Public.School..Latest.available.year          : chr  "25" "53" "27" "27" ...
    ##  $ Location.ZIP..Public.School..2019.20                                : chr  "=01752" "98271" "55317" "55318" ...
    ##  $ Out.of.State.Flag..Public.School..2019.20                           : chr  "2-No" "2-No" "2-No" "2-No" ...
    ##  $ Charter.School..Public.School..2019.20                              : chr  "2-No" "2-No" "2-No" "2-No" ...
    ##  $ Urban.centric.Locale..Public.School..2019.20                        : chr  "21-Suburb: Large" "22-Suburb: Mid-size" "21-Suburb: Large" "21-Suburb: Large" ...
    ##  $ School.wide.Title.I..Public.School..2019.20                         : chr  "1-Yes" "†" "2-No" "2-No" ...
    ##  $ Title.I.Eligible.School..Public.School..2019.20                     : chr  "1-Yes" "2-No" "1-Yes" "1-Yes" ...
    ##  $ Title.I.School.Status..Public.School..2019.20                       : chr  "5-Title I schoolwide school" "6-Not a Title I school" "2-Title I targeted assistance school" "2-Title I targeted assistance school" ...
    ##  $ Latitude..Public.School..2019.20                                    : num  42.4 48.1 44.8 44.8 44.8 ...
    ##  $ Longitude..Public.School..2019.20                                   : num  -71.5 -122.2 -93.6 -93.6 -93.6 ...
    ##  $ Congressional.Code..Public.School..2019.20                          : chr  "2503" "5302" "2703" "2703" ...
    ##  $ Virtual.School.Status..SY.2016.17.onward...Public.School..2019.20   : chr  "NOTVIRTUAL" "NOTVIRTUAL" "NOTVIRTUAL" "NOTVIRTUAL" ...
    ##  $ National.School.Lunch.Program..Public.School..2019.20               : chr  "Yes participating without using any Provision or the CEO" "Yes participating without using any Provision or the CEO" "No" "No" ...
    ##  $ Total.Students.All.Grades..Excludes.AE...Public.School..2019.20     : chr  "1478" "178" "39" "404" ...
    ##  $ Free.Lunch.Eligible..Public.School..2019.20                         : chr  "–" "49" "8" "113" ...
    ##  $ Direct.Certification..Public.School..2019.20                        : chr  "623" "11" "–" "–" ...
    ##  $ Reduced.price.Lunch.Eligible.Students..Public.School..2019.20       : chr  "–" "12" "=0" "61" ...
    ##  $ Free.and.Reduced.Lunch.Students..Public.School..2019.20             : chr  "–" "61" "8" "174" ...
    ##  $ Male.Students..Public.School..2019.20                               : chr  "748" "78" "21" "211" ...
    ##  $ Female.Students..Public.School..2019.20                             : chr  "730" "100" "18" "193" ...
    ##  $ American.Indian.Alaska.Native.Students..Public.School..2019.20      : chr  "1" "18" "=0" "2" ...
    ##  $ Asian.or.Asian.Pacific.Islander.Students..Public.School..2019.20    : chr  "33" "8" "1" "19" ...
    ##  $ Hispanic.Students..Public.School..2019.20                           : chr  "807" "32" "15" "88" ...
    ##  $ Black.or.African.American.Students..Public.School..2019.20          : chr  "44" "3" "3" "34" ...
    ##  $ White.Students..Public.School..2019.20                              : chr  "543" "99" "19" "233" ...
    ##  $ Nat..Hawaiian.or.Other.Pacific.Isl..Students..Public.School..2019.20: chr  "=0" "=0" "=0" "=0" ...
    ##  $ Two.or.More.Races.Students..Public.School..2019.20                  : chr  "50" "18" "1" "28" ...
    ##  $ Total.Race.Ethnicity..Public.School..2019.20                        : chr  "1478" "178" "39" "404" ...
    ##  $ Full.Time.Equivalent..FTE..Teachers..Public.School..2019.20         : chr  "121.18" "7.50" "=0.00" "4.70" ...
    ##  $ Pupil.Teacher.Ratio..Public.School..2019.20                         : chr  "12.20" "23.73" "†" "85.96" ...

## 2019-2020 School by County Level Data

``` r
#Import school by county list that is generated from NCES
school_at_county <-read.csv('./Datasets/NCES/ELSI_county_2019to20.csv', skip = 6, nrows = 3146, header = T, strip.white = T, fileEncoding="UTF-8-BOM")
#The original import has the similar issue where I have to skip the first 6 lines and truncate the tail. R will skip over blank rows on the original csv file. 
```

``` r
tail(school_at_county)
```

    ##                       County.Name County.Name..Public.School..2019.20
    ## 3141 Yukon-Koyukuk Census Area AK           Yukon-Koyukuk Census Area
    ## 3142               Yuma County AZ                         Yuma County
    ## 3143               Yuma County CO                         Yuma County
    ## 3144             Zapata County TX                       Zapata County
    ## 3145             Zavala County TX                       Zavala County
    ## 3146            Ziebach County SD                      Ziebach County
    ##      County.Number..Public.School..2019.20
    ## 3141                                =02290
    ## 3142                                =04027
    ## 3143                                =08125
    ## 3144                                 48505
    ## 3145                                 48507
    ## 3146                                 46137
    ##      Total.Number.of.Public.Schools..Public.School..2019.20
    ## 3141                                                     30
    ## 3142                                                     82
    ## 3143                                                     10
    ## 3144                                                      6
    ## 3145                                                      8
    ## 3146                                                      4
    ##      Total.Students.All.Grades..Excludes.AE...Public.School..2019.20
    ## 3141                                                            2469
    ## 3142                                                           38878
    ## 3143                                                            1930
    ## 3144                                                            3549
    ## 3145                                                            2524
    ## 3146                                                             623
    ##      Full.Time.Equivalent..FTE..Teachers..Public.School..2019.20
    ## 3141                                                      124.24
    ## 3142                                                           ‡
    ## 3143                                                      143.43
    ## 3144                                                      224.50
    ## 3145                                                      175.39
    ## 3146                                                       58.82
    ##      Pupil.Teacher.Ratio..Public.School..2019.20
    ## 3141                                       19.87
    ## 3142                                       26.14
    ## 3143                                       13.46
    ## 3144                                       15.81
    ## 3145                                       14.39
    ## 3146                                       10.59

### Dataframe and Data Types

``` r
colnames(school_at_county)
```

    ## [1] "County.Name"                                                    
    ## [2] "County.Name..Public.School..2019.20"                            
    ## [3] "County.Number..Public.School..2019.20"                          
    ## [4] "Total.Number.of.Public.Schools..Public.School..2019.20"         
    ## [5] "Total.Students.All.Grades..Excludes.AE...Public.School..2019.20"
    ## [6] "Full.Time.Equivalent..FTE..Teachers..Public.School..2019.20"    
    ## [7] "Pupil.Teacher.Ratio..Public.School..2019.20"

``` r
str(school_at_county)
```

    ## 'data.frame':    3146 obs. of  7 variables:
    ##  $ County.Name                                                    : chr  "Abbeville County SC" "Acadia Parish LA" "Accomack County VA" "Ada County ID" ...
    ##  $ County.Name..Public.School..2019.20                            : chr  "Abbeville County" "Acadia Parish" "Accomack County" "Ada County" ...
    ##  $ County.Number..Public.School..2019.20                          : chr  "45001" "22001" "51001" "16001" ...
    ##  $ Total.Number.of.Public.Schools..Public.School..2019.20         : chr  "10" "27" "13" "141" ...
    ##  $ Total.Students.All.Grades..Excludes.AE...Public.School..2019.20: chr  "3110" "9739" "5161" "80674" ...
    ##  $ Full.Time.Equivalent..FTE..Teachers..Public.School..2019.20    : chr  "242.20" "510.30" "319.99" "4224.74" ...
    ##  $ Pupil.Teacher.Ratio..Public.School..2019.20                    : chr  "12.84" "19.08" "16.13" "19.10" ...

## 2019-2020 School District List

``` r
sch_district <-read.csv('./Datasets/NCES/ELSI_sch_district_2019to20.csv', skip = 6, nrows = 19390, header = T, strip.white = T, fileEncoding="UTF-8-BOM") #there are 19364 districts in the original import with skip, remove the last 4 to 19390
```

Check tail

``` r
tail(sch_district)
```

    ##                            Agency.Name
    ## 19385          ZION-BENTON TWP HSD 126
    ## 19386     ZIONSVILLE COMMUNITY SCHOOLS
    ## 19387        ZUMBRO EDUCATION DISTRICT
    ## 19388 ZUMBROTA-MAZEPPA SCHOOL DISTRICT
    ## 19389              ZUNI PUBLIC SCHOOLS
    ## 19390                      ZURICH ELEM
    ##       State.Name..District..Latest.available.year
    ## 19385                                    Illinois
    ## 19386                                     Indiana
    ## 19387                                   Minnesota
    ## 19388                                   Minnesota
    ## 19389                                  New Mexico
    ## 19390                                     Montana
    ##       State.Abbr..District..Latest.available.year
    ## 19385                                          IL
    ## 19386                                          IN
    ## 19387                                          MN
    ## 19388                                          MN
    ## 19389                                          NM
    ## 19390                                          MT
    ##       Agency.ID...NCES.Assigned..District..Latest.available.year
    ## 19385                                                    1743890
    ## 19386                                                    1802830
    ## 19387                                                    2700054
    ## 19388                                                    2745735
    ## 19389                                                    3502800
    ## 19390                                                    3028910
    ##       Supervisory.Union..ID..Number..District..2019.20
    ## 19385                                                 
    ## 19386                                                 
    ## 19387                                                 
    ## 19388                                                 
    ## 19389                                                 
    ## 19390                                                 
    ##       Total.Number.Operational.Schools..Public.School..2019.20
    ## 19385                                                        2
    ## 19386                                                        8
    ## 19387                                                        4
    ## 19388                                                        4
    ## 19389                                                        4
    ## 19390                                                        1
    ##       Total.Number.of.Public.Schools..Public.School..2019.20
    ## 19385                                                      2
    ## 19386                                                      8
    ## 19387                                                      4
    ## 19388                                                      4
    ## 19389                                                      4
    ## 19390                                                      1
    ##       County.Name..District..2019.20
    ## 19385                    Lake County
    ## 19386                   Boone County
    ## 19387                 Olmsted County
    ## 19388                 Wabasha County
    ## 19389                McKinley County
    ## 19390                  Blaine County
    ##                                                       Agency.Type..District..2019.20
    ## 19385 1-Regular local school district that is NOT a component of a supervisory union
    ## 19386 1-Regular local school district that is NOT a component of a supervisory union
    ## 19387                                           9-Specialized public school district
    ## 19388 1-Regular local school district that is NOT a component of a supervisory union
    ## 19389 1-Regular local school district that is NOT a component of a supervisory union
    ## 19390 1-Regular local school district that is NOT a component of a supervisory union
    ##       Urban.centric.Locale..District..2019.20
    ## 19385                        21-Suburb: Large
    ## 19386                        21-Suburb: Large
    ## 19387                         31-Town: Fringe
    ## 19388                        32-Town: Distant
    ## 19389                         33-Town: Remote
    ## 19390                        43-Rural: Remote
    ##       Lowest.Grade.Offered..District..2019.20
    ## 19385                               9th Grade
    ## 19386                         Prekindergarten
    ## 19387                         Prekindergarten
    ## 19388                         Prekindergarten
    ## 19389                         Prekindergarten
    ## 19390                         Prekindergarten
    ##       Highest.Grade.Offered..District..2019.20
    ## 19385                               12th Grade
    ## 19386                               12th Grade
    ## 19387                               12th Grade
    ## 19388                               12th Grade
    ## 19389                               12th Grade
    ## 19390                                8th Grade
    ##       Total.Students.All.Grades..Excludes.AE...District..2019.20
    ## 19385                                                       2489
    ## 19386                                                       7435
    ## 19387                                                        176
    ## 19388                                                       1248
    ## 19389                                                       1234
    ## 19390                                                         20
    ##       Full.Time.Equivalent..FTE..Teachers..District..2019.20
    ## 19385                                                 169.91
    ## 19386                                                 426.16
    ## 19387                                                  23.82
    ## 19388                                                  79.81
    ## 19389                                                  96.97
    ## 19390                                                   3.00
    ##       Pupil.Teacher.Ratio..District..2019.20
    ## 19385                                  14.65
    ## 19386                                  17.45
    ## 19387                                   7.39
    ## 19388                                  15.64
    ## 19389                                  12.73
    ## 19390                                   6.67

### Dataframe and Data Types

``` r
colnames(sch_district)
```

    ##  [1] "Agency.Name"                                               
    ##  [2] "State.Name..District..Latest.available.year"               
    ##  [3] "State.Abbr..District..Latest.available.year"               
    ##  [4] "Agency.ID...NCES.Assigned..District..Latest.available.year"
    ##  [5] "Supervisory.Union..ID..Number..District..2019.20"          
    ##  [6] "Total.Number.Operational.Schools..Public.School..2019.20"  
    ##  [7] "Total.Number.of.Public.Schools..Public.School..2019.20"    
    ##  [8] "County.Name..District..2019.20"                            
    ##  [9] "Agency.Type..District..2019.20"                            
    ## [10] "Urban.centric.Locale..District..2019.20"                   
    ## [11] "Lowest.Grade.Offered..District..2019.20"                   
    ## [12] "Highest.Grade.Offered..District..2019.20"                  
    ## [13] "Total.Students.All.Grades..Excludes.AE...District..2019.20"
    ## [14] "Full.Time.Equivalent..FTE..Teachers..District..2019.20"    
    ## [15] "Pupil.Teacher.Ratio..District..2019.20"

Data Type

``` r
str(sch_district)
```

    ## 'data.frame':    19390 obs. of  15 variables:
    ##  $ Agency.Name                                               : chr  "21ST CENTURY CHARTER SCH OF GARY" "21ST CENTURY CYBER CS" "21ST CENTURY PREPARATORY SCHOOL AGENCY" "A CENTER FOR CREATIVE EDUCATION (79457)" ...
    ##  $ State.Name..District..Latest.available.year               : chr  "Indiana" "Pennsylvania" "Wisconsin" "Arizona" ...
    ##  $ State.Abbr..District..Latest.available.year               : chr  "IN" "PA" "WI" "AZ" ...
    ##  $ Agency.ID...NCES.Assigned..District..Latest.available.year: chr  "1800046" "4200091" "5500045" "=0400328" ...
    ##  $ Supervisory.Union..ID..Number..District..2019.20          : chr  "" "" "" "" ...
    ##  $ Total.Number.Operational.Schools..Public.School..2019.20  : chr  "1" "1" "1" "1" ...
    ##  $ Total.Number.of.Public.Schools..Public.School..2019.20    : chr  "1" "1" "1" "1" ...
    ##  $ County.Name..District..2019.20                            : chr  "Marion County" "Chester County" "Racine County" "Yavapai County" ...
    ##  $ Agency.Type..District..2019.20                            : chr  "7-Independent Charter District" "7-Independent Charter District" "7-Independent Charter District" "7-Independent Charter District" ...
    ##  $ Urban.centric.Locale..District..2019.20                   : chr  "13-City: Small" "21-Suburb: Large" "13-City: Small" "32-Town: Distant" ...
    ##  $ Lowest.Grade.Offered..District..2019.20                   : chr  "Kindergarten" "6th Grade" "Prekindergarten" "Kindergarten" ...
    ##  $ Highest.Grade.Offered..District..2019.20                  : chr  "12th Grade" "12th Grade" "8th Grade" "8th Grade" ...
    ##  $ Total.Students.All.Grades..Excludes.AE...District..2019.20: chr  "1190" "1270" "551" "67" ...
    ##  $ Full.Time.Equivalent..FTE..Teachers..District..2019.20    : chr  "47.01" "64.99" "29.07" "=0.00" ...
    ##  $ Pupil.Teacher.Ratio..District..2019.20                    : chr  "25.31" "19.54" "18.95" "†" ...

# Data Processing

## School Level File

The ‘school’ dataframe has the largest amount of information because it
is a list of all schools in 2019-2020 reported in the NCES ELSI
database. (29MB) There are some useful information to process at this
point.

### Remove demographic counts

``` r
#The SEDA dataset with demographic information will be used, so we can drop that in the school dataset 
school <- school[1:25]
```

### Data conversion

``` r
#Column 1 to 20 are categorical data where column 21 to 37 should be numerical data 
school[21:37] <- lapply(school[21:25], as.numeric)
```

    ## Warning in lapply(school[21:25], as.numeric): NAs introduced by coercion

    ## Warning in lapply(school[21:25], as.numeric): NAs introduced by coercion

    ## Warning in lapply(school[21:25], as.numeric): NAs introduced by coercion

    ## Warning in lapply(school[21:25], as.numeric): NAs introduced by coercion

    ## Warning in lapply(school[21:25], as.numeric): NAs introduced by coercion

While the NCES notes indicated the following coding mechanism:

-   † indicates that the data are not applicable.
-   – indicates that the data are missing.  
-   ‡ indicates that the data do not meet NCES data quality standards.
    We will cover these into na when the numeric() function is applied.

``` r
str(school)
```

    ## 'data.frame':    99338 obs. of  37 variables:
    ##  $ School.Name                                                      : chr  "1 LT CHARLES W. WHITCOMB SCHOOL" "10TH STREET SCHOOL" "112 ALC INDEPENDENT STUDY" "112 ALC MIDDLE SCHOOL" ...
    ##  $ State.Name..Public.School..Latest.available.year                 : chr  "Massachusetts" "Washington" "Minnesota" "Minnesota" ...
    ##  $ State.Abbr..Public.School..Latest.available.year                 : chr  "MA" "WA" "MN" "MN" ...
    ##  $ School.ID...NCES.Assigned..Public.School..Latest.available.year  : chr  "250732002639" "530486002475" "270819004415" "270819004622" ...
    ##  $ Agency.ID...NCES.Assigned..Public.School..Latest.available.year  : chr  "2507320" "5304860" "2708190" "2708190" ...
    ##  $ County.Name..Public.School..2019.20                              : chr  "Middlesex County" "Snohomish County" "Carver County" "Carver County" ...
    ##  $ County.Number..Public.School..2019.20                            : chr  "25017" "53061" "27019" "27019" ...
    ##  $ ANSI.FIPS.State.Code..Public.School..Latest.available.year       : chr  "25" "53" "27" "27" ...
    ##  $ Location.ZIP..Public.School..2019.20                             : chr  "=01752" "98271" "55317" "55318" ...
    ##  $ Out.of.State.Flag..Public.School..2019.20                        : chr  "2-No" "2-No" "2-No" "2-No" ...
    ##  $ Charter.School..Public.School..2019.20                           : chr  "2-No" "2-No" "2-No" "2-No" ...
    ##  $ Urban.centric.Locale..Public.School..2019.20                     : chr  "21-Suburb: Large" "22-Suburb: Mid-size" "21-Suburb: Large" "21-Suburb: Large" ...
    ##  $ School.wide.Title.I..Public.School..2019.20                      : chr  "1-Yes" "†" "2-No" "2-No" ...
    ##  $ Title.I.Eligible.School..Public.School..2019.20                  : chr  "1-Yes" "2-No" "1-Yes" "1-Yes" ...
    ##  $ Title.I.School.Status..Public.School..2019.20                    : chr  "5-Title I schoolwide school" "6-Not a Title I school" "2-Title I targeted assistance school" "2-Title I targeted assistance school" ...
    ##  $ Latitude..Public.School..2019.20                                 : num  42.4 48.1 44.8 44.8 44.8 ...
    ##  $ Longitude..Public.School..2019.20                                : num  -71.5 -122.2 -93.6 -93.6 -93.6 ...
    ##  $ Congressional.Code..Public.School..2019.20                       : chr  "2503" "5302" "2703" "2703" ...
    ##  $ Virtual.School.Status..SY.2016.17.onward...Public.School..2019.20: chr  "NOTVIRTUAL" "NOTVIRTUAL" "NOTVIRTUAL" "NOTVIRTUAL" ...
    ##  $ National.School.Lunch.Program..Public.School..2019.20            : chr  "Yes participating without using any Provision or the CEO" "Yes participating without using any Provision or the CEO" "No" "No" ...
    ##  $ Total.Students.All.Grades..Excludes.AE...Public.School..2019.20  : num  1478 178 39 404 NA ...
    ##  $ Free.Lunch.Eligible..Public.School..2019.20                      : num  NA 49 8 113 NA NA 103 NA 51 2 ...
    ##  $ Direct.Certification..Public.School..2019.20                     : num  623 11 NA NA NA NA NA NA NA NA ...
    ##  $ Reduced.price.Lunch.Eligible.Students..Public.School..2019.20    : num  NA 12 NA 61 NA NA 25 NA NA 1 ...
    ##  $ Free.and.Reduced.Lunch.Students..Public.School..2019.20          : num  NA 61 8 174 NA NA 128 NA 51 3 ...
    ##  $ Total.Students.All.Grades..Excludes.AE...Public.School..2019.20.1: num  1478 178 39 404 NA ...
    ##  $ Free.Lunch.Eligible..Public.School..2019.20.1                    : num  NA 49 8 113 NA NA 103 NA 51 2 ...
    ##  $ Direct.Certification..Public.School..2019.20.1                   : num  623 11 NA NA NA NA NA NA NA NA ...
    ##  $ Reduced.price.Lunch.Eligible.Students..Public.School..2019.20.1  : num  NA 12 NA 61 NA NA 25 NA NA 1 ...
    ##  $ Free.and.Reduced.Lunch.Students..Public.School..2019.20.1        : num  NA 61 8 174 NA NA 128 NA 51 3 ...
    ##  $ Total.Students.All.Grades..Excludes.AE...Public.School..2019.20.2: num  1478 178 39 404 NA ...
    ##  $ Free.Lunch.Eligible..Public.School..2019.20.2                    : num  NA 49 8 113 NA NA 103 NA 51 2 ...
    ##  $ Direct.Certification..Public.School..2019.20.2                   : num  623 11 NA NA NA NA NA NA NA NA ...
    ##  $ Reduced.price.Lunch.Eligible.Students..Public.School..2019.20.2  : num  NA 12 NA 61 NA NA 25 NA NA 1 ...
    ##  $ Free.and.Reduced.Lunch.Students..Public.School..2019.20.2        : num  NA 61 8 174 NA NA 128 NA 51 3 ...
    ##  $ Total.Students.All.Grades..Excludes.AE...Public.School..2019.20.3: num  1478 178 39 404 NA ...
    ##  $ Free.Lunch.Eligible..Public.School..2019.20.3                    : num  NA 49 8 113 NA NA 103 NA 51 2 ...

### Check incomplete cases

``` r
inc_school <- school[!complete.cases(school),]
head(inc_school)
```

    ##                       School.Name
    ## 1 1 LT CHARLES W. WHITCOMB SCHOOL
    ## 3       112 ALC INDEPENDENT STUDY
    ## 4           112 ALC MIDDLE SCHOOL
    ## 5              112 ALC SEAT-BASED
    ## 6                       113-H-W-4
    ## 7          12TH STREET ELEMENTARY
    ##   State.Name..Public.School..Latest.available.year
    ## 1                                    Massachusetts
    ## 3                                        Minnesota
    ## 4                                        Minnesota
    ## 5                                        MINNESOTA
    ## 6                                          FLORIDA
    ## 7                                         Michigan
    ##   State.Abbr..Public.School..Latest.available.year
    ## 1                                               MA
    ## 3                                               MN
    ## 4                                               MN
    ## 5                                               MN
    ## 6                                               FL
    ## 7                                               MI
    ##   School.ID...NCES.Assigned..Public.School..Latest.available.year
    ## 1                                                    250732002639
    ## 3                                                    270819004415
    ## 4                                                    270819004622
    ## 5                                                    270819005118
    ## 6                                                    120144008827
    ## 7                                                    262895007802
    ##   Agency.ID...NCES.Assigned..Public.School..Latest.available.year
    ## 1                                                         2507320
    ## 3                                                         2708190
    ## 4                                                         2708190
    ## 5                                                         2708190
    ## 6                                                         1201440
    ## 7                                                         2628950
    ##   County.Name..Public.School..2019.20 County.Number..Public.School..2019.20
    ## 1                    Middlesex County                                 25017
    ## 3                       Carver County                                 27019
    ## 4                       Carver County                                 27019
    ## 5                       Carver County                                 27019
    ## 6                       Orange County                                 12095
    ## 7                    Kalamazoo County                                 26077
    ##   ANSI.FIPS.State.Code..Public.School..Latest.available.year
    ## 1                                                         25
    ## 3                                                         27
    ## 4                                                         27
    ## 5                                                         27
    ## 6                                                         12
    ## 7                                                         26
    ##   Location.ZIP..Public.School..2019.20
    ## 1                               =01752
    ## 3                                55317
    ## 4                                55318
    ## 5                                55318
    ## 6                                32801
    ## 7                                49024
    ##   Out.of.State.Flag..Public.School..2019.20
    ## 1                                      2-No
    ## 3                                      2-No
    ## 4                                      2-No
    ## 5                                      2-No
    ## 6                                      2-No
    ## 7                                      2-No
    ##   Charter.School..Public.School..2019.20
    ## 1                                   2-No
    ## 3                                   2-No
    ## 4                                   2-No
    ## 5                                   2-No
    ## 6                                   2-No
    ## 7                                   2-No
    ##   Urban.centric.Locale..Public.School..2019.20
    ## 1                             21-Suburb: Large
    ## 3                             21-Suburb: Large
    ## 4                             21-Suburb: Large
    ## 5                             21-Suburb: Large
    ## 6                               11-City: Large
    ## 7                               13-City: Small
    ##   School.wide.Title.I..Public.School..2019.20
    ## 1                                       1-Yes
    ## 3                                        2-No
    ## 4                                        2-No
    ## 5                                        2-No
    ## 6                                           †
    ## 7                                           †
    ##   Title.I.Eligible.School..Public.School..2019.20
    ## 1                                           1-Yes
    ## 3                                           1-Yes
    ## 4                                           1-Yes
    ## 5                                           1-Yes
    ## 6                                               †
    ## 7                                            2-No
    ##   Title.I.School.Status..Public.School..2019.20
    ## 1                   5-Title I schoolwide school
    ## 3          2-Title I targeted assistance school
    ## 4          2-Title I targeted assistance school
    ## 5          2-Title I targeted assistance school
    ## 6                                             †
    ## 7                        6-Not a Title I school
    ##   Latitude..Public.School..2019.20 Longitude..Public.School..2019.20
    ## 1                         42.35738                         -71.54846
    ## 3                         44.84530                         -93.57480
    ## 4                         44.84160                         -93.59690
    ## 5                         44.84150                         -93.59452
    ## 6                         28.55013                         -81.38502
    ## 7                         42.22040                         -85.64660
    ##   Congressional.Code..Public.School..2019.20
    ## 1                                       2503
    ## 3                                       2703
    ## 4                                       2703
    ## 5                                       2703
    ## 6                                       1210
    ## 7                                       2606
    ##   Virtual.School.Status..SY.2016.17.onward...Public.School..2019.20
    ## 1                                                        NOTVIRTUAL
    ## 3                                                        NOTVIRTUAL
    ## 4                                                        NOTVIRTUAL
    ## 5                                                        NOTVIRTUAL
    ## 6                                                                 †
    ## 7                                                        NOTVIRTUAL
    ##      National.School.Lunch.Program..Public.School..2019.20
    ## 1 Yes participating without using any Provision or the CEO
    ## 3                                                       No
    ## 4                                                       No
    ## 5                                                       No
    ## 6                                                        †
    ## 7 Yes participating without using any Provision or the CEO
    ##   Total.Students.All.Grades..Excludes.AE...Public.School..2019.20
    ## 1                                                            1478
    ## 3                                                              39
    ## 4                                                             404
    ## 5                                                              NA
    ## 6                                                              NA
    ## 7                                                             582
    ##   Free.Lunch.Eligible..Public.School..2019.20
    ## 1                                          NA
    ## 3                                           8
    ## 4                                         113
    ## 5                                          NA
    ## 6                                          NA
    ## 7                                         103
    ##   Direct.Certification..Public.School..2019.20
    ## 1                                          623
    ## 3                                           NA
    ## 4                                           NA
    ## 5                                           NA
    ## 6                                           NA
    ## 7                                           NA
    ##   Reduced.price.Lunch.Eligible.Students..Public.School..2019.20
    ## 1                                                            NA
    ## 3                                                            NA
    ## 4                                                            61
    ## 5                                                            NA
    ## 6                                                            NA
    ## 7                                                            25
    ##   Free.and.Reduced.Lunch.Students..Public.School..2019.20
    ## 1                                                      NA
    ## 3                                                       8
    ## 4                                                     174
    ## 5                                                      NA
    ## 6                                                      NA
    ## 7                                                     128
    ##   Total.Students.All.Grades..Excludes.AE...Public.School..2019.20.1
    ## 1                                                              1478
    ## 3                                                                39
    ## 4                                                               404
    ## 5                                                                NA
    ## 6                                                                NA
    ## 7                                                               582
    ##   Free.Lunch.Eligible..Public.School..2019.20.1
    ## 1                                            NA
    ## 3                                             8
    ## 4                                           113
    ## 5                                            NA
    ## 6                                            NA
    ## 7                                           103
    ##   Direct.Certification..Public.School..2019.20.1
    ## 1                                            623
    ## 3                                             NA
    ## 4                                             NA
    ## 5                                             NA
    ## 6                                             NA
    ## 7                                             NA
    ##   Reduced.price.Lunch.Eligible.Students..Public.School..2019.20.1
    ## 1                                                              NA
    ## 3                                                              NA
    ## 4                                                              61
    ## 5                                                              NA
    ## 6                                                              NA
    ## 7                                                              25
    ##   Free.and.Reduced.Lunch.Students..Public.School..2019.20.1
    ## 1                                                        NA
    ## 3                                                         8
    ## 4                                                       174
    ## 5                                                        NA
    ## 6                                                        NA
    ## 7                                                       128
    ##   Total.Students.All.Grades..Excludes.AE...Public.School..2019.20.2
    ## 1                                                              1478
    ## 3                                                                39
    ## 4                                                               404
    ## 5                                                                NA
    ## 6                                                                NA
    ## 7                                                               582
    ##   Free.Lunch.Eligible..Public.School..2019.20.2
    ## 1                                            NA
    ## 3                                             8
    ## 4                                           113
    ## 5                                            NA
    ## 6                                            NA
    ## 7                                           103
    ##   Direct.Certification..Public.School..2019.20.2
    ## 1                                            623
    ## 3                                             NA
    ## 4                                             NA
    ## 5                                             NA
    ## 6                                             NA
    ## 7                                             NA
    ##   Reduced.price.Lunch.Eligible.Students..Public.School..2019.20.2
    ## 1                                                              NA
    ## 3                                                              NA
    ## 4                                                              61
    ## 5                                                              NA
    ## 6                                                              NA
    ## 7                                                              25
    ##   Free.and.Reduced.Lunch.Students..Public.School..2019.20.2
    ## 1                                                        NA
    ## 3                                                         8
    ## 4                                                       174
    ## 5                                                        NA
    ## 6                                                        NA
    ## 7                                                       128
    ##   Total.Students.All.Grades..Excludes.AE...Public.School..2019.20.3
    ## 1                                                              1478
    ## 3                                                                39
    ## 4                                                               404
    ## 5                                                                NA
    ## 6                                                                NA
    ## 7                                                               582
    ##   Free.Lunch.Eligible..Public.School..2019.20.3
    ## 1                                            NA
    ## 3                                             8
    ## 4                                           113
    ## 5                                            NA
    ## 6                                            NA
    ## 7                                           103

Based on the result, there are 64181 school with at least one or more
missing values.

At this stage, student enrollment is a variable to keep. There are
missing information of student enrollment at certain schools.

``` r
#Determine how many schools do not have total enrollment information 
sum(is.na(school$Total.Students.All.Grades..Excludes.AE...Public.School..2019.20))
```

    ## [1] 3954

3954/99338 indicated there are about 3.98 percent of schools with no
enrollment information.
