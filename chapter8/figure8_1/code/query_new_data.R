## Matt Moehr
## 2018-02-11

require(tidyverse)

anes <- readRDS("./chapter8/figure8_1/new/data/anes/2016 Time Series Study/anes_timeseries_2016_.rds")

ls(anes)

## welfare: V161209
  ## 0 = increase (1)
  ## 50 = maintain (3)
  ## 100 = decrease (2)
  ## NaN = dk/refused (-8, -9)

## unemploymen increased/decreased: 
  ## doesn't seem available in 2016 data

## respondents race: V161310x
## white, non-Hispanic (1) respondents only

## blacks just need to try harder: V162214
## 0 = disagree stongly (5)
## .25 = disagree somewhat (4) 
## .50 = Neither agree or disagree (3) 
## .75 = agree somewhat (2)
## 1 = strongly agree (1)

