## Matt Moehr
## 2018-01-31

## While googling syntax for unzipping files and loading the ANES data, I
## discovered the Analyze Survey Data for Free website: http://asdfree.com/
## Looks like this person has a book of a bunch of survey data and made a 
## package called lodown for dowloading survey data.


install.packages( "devtools" , repos = "http://cran.rstudio.com/" )
library(devtools)

install_github( "jimhester/archive", dependencies = TRUE )
install_github( "ajdamico/lodown" , dependencies = FALSE )
library(lodown)
