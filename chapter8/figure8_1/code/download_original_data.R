## Matt Moehr
## 2018-01-31

## download American National Election Study data

require(RCurl)



temp <- tempfile()

curl_download("http://www.electionstudies.org/studypages/data/1992prepost/anes1992dta.zip",
              temp
              )

unzip(temp,
      exdir = "../original/data/anes1992"
      )

unlink(temp)

