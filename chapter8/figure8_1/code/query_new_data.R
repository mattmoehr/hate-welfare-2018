## Matt Moehr
## 2018-02-11

require(tidyverse)

anes <- readRDS("./chapter8/figure8_1/new/data/anes/2016 Time Series Study/anes_timeseries_2016_.rds")

ls(anes)

## welfare: v161209
  ## 0 = increase (1)
  ## 50 = maintain (3)
  ## 100 = decrease (2)
  ## NaN = dk/refused (-8, -9)

## unemploymen increased/decreased: 
  ## doesn't seem available in 2016 data

## social security: v161205
  ## 0 = increase (1)
  ## 50 = maintain (3)
  ## 100 = decrease (2)
  ## NaN = dk/refused (-8, -9)

## respondents race: v161310x
## white, non-Hispanic (1) respondents only

## blacks just need to try harder: v162214
## 0 = disagree stongly (5)
## .25 = disagree somewhat (4) 
## .50 = Neither agree or disagree (3) 
## .75 = agree somewhat (2)
## 1 = strongly agree (1)
## NaN = -6 through -9 are missing data



vars <- c('v161209',
          'v161205',
          'v161310x',
          'v162214'
          )

sapply(anes[,vars], table)

anes_whites <- dplyr::filter(anes, v161310x == 1)

sapply(anes_whites[, vars], table)

anes_whites <-
  mutate(
    anes_whites,
    welfare = case_when(
      v161209 == 1 ~ 0,
      v161209 == 3 ~ 50,
      v161209 == 2 ~ 100,
      v161209 == -8 ~ NaN,
      v161209 == -9 ~ NaN
    )
  )

table(anes_whites$welfare, useNA = "always")


anes_whites <-
  mutate(
    anes_whites,
    social_security = case_when(
      v161205 == 1 ~ 0,
      v161205 == 3 ~ 50,
      v161205 == 2 ~ 100,
      v161205 == -8 ~ NaN,
      v161205 == -9 ~ NaN
    )
  )

table(anes_whites$social_security, useNA = "always")


anes_whites <-
  mutate(
    anes_whites,
    try_harder = case_when(
      v162214 == 1 ~ 0,
      v162214 == 2 ~ .25,
      v162214 == 3 ~ .5,
      v162214 == 4 ~ .75,
      v162214 == 5 ~ 1,
      v162214 <= -6 ~ NaN
    )
  )

table(anes_whites$try_harder, useNA = "always")

## run the models

m_welfare <- lm(data = anes_whites,
                formula = welfare ~  try_harder
                )

summary(m_welfare)

## here is an additional model for social security

m_social_security <- lm(data = anes_whites,
                        formula = social_security ~ try_harder
                        )

summary(m_social_security)

## in the 2016 data, try_harder no longer has a sig coef 

anes_whites <-
  mutate(
    anes_whites,
    cut_welfare = case_when(
      welfare == 100 ~ 1,
      welfare == NaN ~ NaN,
      TRUE ~ 0
    )
  )


t_welfare <- aggregate(cut_welfare ~ try_harder,
                       anes_whites,
                       mean
                       )

plot(t_welfare$try_harder, 
     t_welfare$cut_welfare,
     ylim = c(0, .75),
     type = "o"
     )


## so very few people wanted to cut soc sec so move the cut
## point up to maintain or cut
anes_whites <-
  mutate(
    anes_whites,
    main_or_cut_social_security = case_when(
      social_security >= 50 ~ 1,
      social_security == NaN ~ NaN,
      TRUE ~ 0
    )
  )

t_social_security <- aggregate(main_or_cut_social_security ~ try_harder,
                               anes_whites,
                               mean
                               )

t_social_security

plot(t_social_security$try_harder,
     t_social_security$main_or_cut_social_security,
     ylim = c(0, .65),
     type = "o"
     )


