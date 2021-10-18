########################
### APP PREPARATION ####
########################

# -- Loading required libraries
library(readr)
library(dplyr)

# setwd()

# -- Loading the data
ny <- read.csv("data/ny_pre_app.csv")

# -- Recoding amenities and neighborhood variables to a factor variable
ny$neighbourhood_group_cleansed <- as.factor(ny$neighbourhood_group_cleansed)

ny$Wifi <- as.numeric(ny$amenities_Wifi)
ny$Backyard <- as.numeric(ny$amenities_Backyard)
ny$TV <- as.numeric(ny$amenities_TV)
ny$Washer <- as.numeric(ny$amenities_Washer)
ny$Dishwasher <- as.numeric(ny$amenities_Dishwasher)
ny$AC <- as.numeric(ny$amenities_AC)
ny$Breakfast <- as.numeric(ny$amenities_Breakfast)

# -- Changing the values to Yes/No for the filter options in the App
ny$Wifi[ny$Wifi == 1] <- "Yes"
ny$Wifi[ny$Wifi == 0] <- "No"

ny$Backyard[ny$Backyard == 1] <- "Yes"
ny$Backyard[ny$Backyard == 0] <- "No"

ny$TV[ny$TV == 1] <- "Yes"
ny$TV[ny$TV == 0] <- "No"

ny$Washer[ny$Washer == 1] <- "Yes"
ny$Washer[ny$Washer == 0] <- "No"

ny$Dishwasher[ny$Dishwasher == 1] <- "Yes"
ny$Dishwasher[ny$Dishwasher == 0] <- "No"

ny$AC[ny$AC == 1] <- "Yes"
ny$AC[ny$AC == 0] <- "No"

ny$Breakfast[ny$Breakfast == 1] <- "Yes"
ny$Breakfast[ny$Breakfast == 0] <- "No"

# -- Creating a subset of the data with only the relevant columns for the app
ny <- ny %>% select('id','host_is_superhost','neighbourhood_group_cleansed','accommodates','bedrooms','beds','number_of_reviews', 'review_scores_accuracy','review_scores_cleanliness','review_scores_checkin','review_scores_communication','review_scores_location','review_scores_value',
                    'reviews_per_month','availability_60','availability_365','n_amenities','Wifi','Backyard', 'TV', 'Washer', 'Dishwasher', 'AC', 'Breakfast',
                    'price_per_accomate','lasso_rating')

# -- Arranging the dataframe in ascending order for the accomodates variable
# -- A necessary step to get the number of accomodates in the app in an ascending order
ny_app <- ny %>% arrange(ny$accommodates)

# -- Creating a new .csv file specific for the app
write_csv(ny_app, "data/ny_app.csv")

View(ny_app)


  
