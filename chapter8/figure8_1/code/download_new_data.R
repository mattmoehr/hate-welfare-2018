## Matt Moehr
## 2018-02-11

## download American National Election Study data
## most recent version available

require(lodown)


## see website for details of lodown
## http://asdfree.com/american-national-election-study-anes.html#simplified-download-and-importation-4

# examine all available ANES microdata files
catalog <- get_catalog("anes",
                       output_dir = "./chapter8/figure8_1/new/data/anes", 
                       your_email = "mattmoehr@hotmail.com"
                       )

View(catalog)

anes2016_list <- subset(catalog, 
                        directory == "2016 Time Series Study"
                        )

# download the microdata to your local computer
lodown("anes", 
       anes2016_list, 
       your_email = "mattmoehr@hotmail.com"
       )

