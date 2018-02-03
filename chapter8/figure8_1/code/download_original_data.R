## Matt Moehr
## 2018-01-31

## download American National Election Study data

require(lodown)


## see website for details of lodown
## http://asdfree.com/american-national-election-study-anes.html#simplified-download-and-importation-4

# examine all available ANES microdata files
catalog <- get_catalog("anes",
                        output_dir = "./chapter8/figure8_1/original/data/anes", 
                        your_email = "mattmoehr@hotmail.com"
                        )

View(catalog)

anes1992_list <- subset(catalog, 
                        directory == "1992 Time Series Study"
                        )

# download the microdata to your local computer
lodown("anes", 
       anes1992_list, 
       your_email = "mattmoehr@hotmail.com"
       )

anes <- readRDS("../data/anes/1992 Time Series Study/anes1992.rds")

names(anes)
