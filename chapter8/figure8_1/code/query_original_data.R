## Matt Moehr
## 2018-01-31

require(tidyverse)

anes <- readRDS("./chapter8/figure8_1/original/data/anes/1992 Time Series Study/anes1992.rds")


ls(anes)


## all criteria described in appendix A.12:

## welfare increased/decreased: v923726
  ## 0 = increase
  ## 50 = maintain
  ## 100 = decrease
  ## ?? cut entirely
  ## ?? dk/refused

## unemploymen increased/decreased: v923816
  ## 0 = increase
  ## 50 = maintain
  ## 100 = decrease
  ## ?? cut entirely
  ## ?? dk/refused

## it turns out that ANES dropped the unemploymet question
## so i am going to swap in the social security question
## it has a few advantages:
  ## a) it is in the federal spedinding section like welfare and unemployment
  ## b) it is presumbably not linked to racism (this was Gilens original
  ##    modtivation for using the unemployment variable, i think.)
  ## c) it's available in 1992 and 2016.

## social security increased/decreased: v923811
  ## 0 = increase
  ## 50 = maintain
  ## 100 = decrease
  ## ?? cut entirely
  ## ?? dk/refused

## respondents race: v924202
  ## white (1) respondents only
  
## blacks just need to try harder: v926128
  ## 0 = strongly diagree
  ## .25 = disagree somewhat
  ## .50 = 
  ## .75 = agree somewhat
  ## 1 = strongly agree

vars <- c('v923726',
          'v923816',
          'v924202',
          'v926128',
          'v923811'
          )

sapply(anes[,vars], table)

anes_whites <- dplyr::filter(anes, v924202 == 1)

sapply(anes_whites[, vars], table)

anes_whites <-
  mutate(
    anes_whites,
    welfare = case_when(
      v923726 == 1 ~ 0,
      v923726 == 2 ~ 50,
      v923726 == 3 ~ 100,
      v923726 == 7 ~ 100,
      v923726 == 8 ~ NaN,
      v923726 == 9 ~ NaN
    )
  )

table(anes_whites$welfare, useNA = "always")


anes_whites <-
  mutate(
    anes_whites,
    unemploy = case_when(
      v923816 == 1 ~ 0,
      v923816 == 2 ~ 50,
      v923816 == 3 ~ 100,
      v923816 == 7 ~ 100,
      v923816 == 8 ~ NaN,
      v923816 == 9 ~ NaN
    )
  )

table(anes_whites$unemploy, useNA = "always")

anes_whites <-
  mutate(
    anes_whites,
    social_security = case_when(
      v923811 == 1 ~ 0,
      v923811 == 2 ~ 50,
      v923811 == 3 ~ 100,
      v923811 == 7 ~ 100,
      v923811 == 8 ~ NaN,
      v923811 == 9 ~ NaN
    )
  )

table(anes_whites$social_security, useNA = "always")



anes_whites <-
  mutate(
    anes_whites,
    try_harder = case_when(
      v926128 == 1 ~ 0,
      v926128 == 2 ~ .25,
      v926128 == 3 ~ .5,
      v926128 == 4 ~ .75,
      v926128 == 5 ~ 1,
      v926128 == 8 ~ NaN,
      v926128 == 9 ~ NaN,
      v926128 == 0 ~ NaN
    )
  )

table(anes_whites$try_harder, useNA = "always")

## run the models

m_welfare <- lm(data = anes_whites,
                formula = welfare ~  try_harder
                )

summary(m_welfare)

m_unemploy <- lm(data = anes_whites,
                 formula = unemploy ~ try_harder
                 )

summary(m_unemploy)

## the DF in my data and the N reported by Gilens is off
## a bit but everything else matches up so i consider it
## good enough

## here is an additional model for social security

m_social_security <- lm(data = anes_whites,
                        formula = social_security ~ try_harder
                        )

summary(m_social_security)

## hm, the coef on try_harder is positive and significant
## not sure what to make of that. whites are generous to
## old black people?


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
str(t_welfare)

plot(t_welfare$try_harder, 
     t_welfare$cut_welfare,
     ylim = c(0, 0.6),
     type = "o"
     )

anes_whites <-
  mutate(
    anes_whites,
    cut_unemploy = case_when(
      unemploy == 100 ~ 1,
      unemploy == NaN ~ NaN,
      TRUE ~ 0
    )
  )

t_unemploy <- aggregate(cut_unemploy ~ try_harder,
                        anes_whites,
                        mean
                        )

plot(t_unemploy$try_harder,
     t_unemploy$cut_unemploy,
     ylim = c(0, 0.6),
     type = "o"
     )


anes_whites <-
  mutate(
    anes_whites,
    cut_social_security = case_when(
      social_security == 100 ~ 1,
      social_security == NaN ~ NaN,
      TRUE ~ 0
    )
  )

t_social_security <- aggregate(cut_social_security ~ try_harder,
                               anes_whites,
                               mean
                               )

plot(t_social_security$try_harder,
     t_social_security$cut_social_security,
     type = "o"
     )
