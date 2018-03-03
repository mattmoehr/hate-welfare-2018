## Matt Moehr
## 2018-01-31

## While googling syntax for unzipping files and loading the ANES data, I
## discovered the Analyze Survey Data for Free website: 
## http://asdfree.com/
## Looks like this person has a book of a bunch of survey data and made a 
## package called lodown for dowloading survey data.


install.packages( "devtools" , repos = "http://cran.rstudio.com/" )
library(devtools)

devtools::use_travis()

## archive package is a real hassle
## on windows it failed to compile because it couldn't find my install
## of R Build Tools. on linux (Ubuntu) it is saying that it needs to have
## libarchive-dev installed so back to the command line...
## $ sudo apt-get install libarchive-dev
## and then...
## install_github( "jimhester/archive", dependencies = TRUE )
install_github( "ajdamico/lodown" , dependencies = TRUE )
library(lodown)
