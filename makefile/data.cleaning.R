listings <- read.csv("data/listings.csv")

ny_df <- listings

# Libraries used

library(dplyr)
library(stringr)
library(zoo)


#### Filtering out the variables not considered relevant for our purpose ####

# Filtering out the units that have less than 3 reviews. The average rating is going to be our dependent variable so we need it to be accurate for all the units.
ny_df <- subset(ny_df, ny_df$number_of_reviews > 3)

# Filtering out inactive profiles: by canceling airbnbs that haven't been reviewed since 2016-09-29 (last 5 percentiles)
ny_df$last_review <- as.Date(ny_df$last_review, format = "%Y-%m-%d")
startdate <- as.Date('2021-10-04')
ny_df$n_days_last_review <- as.numeric((-1)*(difftime(ny_df$last_review,startdate)))
hist(ny_df$n_days_last_review)
deciles_last_review_days <- quantile(ny_df$n_days_last_review, probs = seq(.05, .95, by = .05))
deciles_last_review_days   ## looking at the quantile
ny_df <- subset(ny_df, ny_df$n_days_last_review < 1824)


# Price variable
ny_df$price_new <-  as.factor(ny_df$price)
ny_df$price_new <- as.numeric(gsub('[$,]', '', ny_df$price))

# Understand the price
ny_df$price_per_accomate <- ny_df$price_new/ny_df$accommodates
sd(as.numeric(ny_df$price_per_accomate))

ny_df$price_per_accomate <-  str_remove(ny_df$price_per_accomate, "^0+")

# Filtering out those units for which price is zero and number of bed is N/A
ny_df <- subset(ny_df, ny_df$price_new!=0)

# The data frame cleaned is called 'ny_df' now


#### Variable respecification - creating new variables  ####

# Creating a new variable: number of characters in the 'description'
ny_df$n_character_in_description <- nchar(ny_df$description, type = "chars", allowNA = TRUE, keepNA = TRUE)
ny_df$n_character_in_description[is.na(ny_df$n_character_in_description)] <- 0

# Create the variable: number of days since host

ny_df$host_since <- as.Date(ny_df$host_since, format =  "%Y-%m-%d")
startdate <- as.Date('2021-10-04')
ny_df$n_days_host_since  <- (-1)*(difftime(ny_df$host_since,startdate))
ny_df$n_days_host_since  <- as.numeric(ny_df$n_days_host_since)

# Creating a new variable: number of characters used by the host to describe himself on his Airbnb profile (in the variable 'host_about')
ny_df$n_characters_in_host_about <- nchar(ny_df$host_about, type = "chars", allowNA = TRUE, keepNA = TRUE)
ny_df$n_characters_in_host_about[is.na(ny_df$n_characters_in_host_about)] <- 0

# Creating a new variable: number of verifications of the host (from the variable 'host_verifications')
ny_df$host_verifications[1]
ny_df$n_host_verifications <- lengths(regmatches(ny_df$host_verifications, gregexpr(",", ny_df$host_verifications)))+1


# Creating new variable: number of amenities
ny_df$n_amenities <- str_count(ny_df$amenities, ',')


# Creating new variables regarding specific amenities:

# WIFI
ny_df$amenities_Wifi <- (grepl('Wifi', ny_df$amenities, fixed = FALSE))

# Backyard
ny_df %>%
  count((grepl('Backyard', ny_df$amenities, fixed = FALSE)))
ny_df$amenities_Backyard <- (grepl('Backyard', ny_df$amenities, fixed = FALSE))

# TV
ny_df %>%
  count((grepl('TV', ny_df$amenities, fixed = FALSE)))
ny_df$amenities_TV <- (grepl('TV', ny_df$amenities, fixed = FALSE))

# Washing machine
ny_df %>%
  count((grepl('Washer', ny_df$amenities, fixed = FALSE)))
ny_df$amenities_Washer <- (grepl('Washer', ny_df$amenities, fixed = FALSE))

# Dishwasher
ny_df %>%
  count((grepl('Dishwasher', ny_df$amenities, fixed = FALSE)))
ny_df$amenities_Dishwasher <- (grepl('Dishwasher', ny_df$amenities, fixed = FALSE))

# Air conditioning
ny_df %>%
  count((grepl('Air conditioning', ny_df$amenities, fixed = FALSE)))
ny_df$amenities_AC <- (grepl('Air conditioning', ny_df$amenities, fixed = FALSE))

# Breakfast
ny_df %>%
  count((grepl('Breakfast', ny_df$amenities, fixed = FALSE)))
ny_df$amenities_Breakfast <- (grepl('Breakfast', ny_df$amenities, fixed = FALSE))

colnames(ny_df)

#### Data fitting for Lasso regression ####

# Selecting relevant variables (we need neighbourhood_group_cleansed instead of neighbourhood, because there are no N/A-s in that variable)
ny_lasso_raw <- ny_df[,c('id','host_response_rate','host_acceptance_rate','host_is_superhost','host_total_listings_count','host_has_profile_pic','host_identity_verified','neighbourhood_group_cleansed'
                         ,'accommodates','bedrooms','beds','minimum_nights_avg_ntm','maximum_nights_avg_ntm','has_availability','availability_60','availability_365','number_of_reviews',
                         'review_scores_accuracy','review_scores_cleanliness','review_scores_checkin','review_scores_communication','review_scores_location','review_scores_value','calculated_host_listings_count'
                         ,'reviews_per_month','n_days_last_review','n_character_in_description','n_days_host_since','n_characters_in_host_about','n_host_verifications','n_amenities','amenities_Wifi','amenities_Backyard',
                         'amenities_TV','amenities_Washer','amenities_Dishwasher','amenities_AC','amenities_Breakfast',
                         'price_per_accomate','neighbourhood_cleansed','latitude','longitude')]

#View(ny_lasso_raw)

# Converting TRUE/FALSE into 1/0 (TRUE=1, FALSE=0), because Lasso regression can't process TRUE/FALSE format
ny_lasso_raw$host_is_superhost [ny_lasso_raw$host_is_superhost == "t"] <- 1
ny_lasso_raw$host_is_superhost [ny_lasso_raw$host_is_superhost == "f"] <- 0

ny_lasso_raw$host_has_profile_pic [ny_lasso_raw$host_has_profile_pic == "t"] <- 1
ny_lasso_raw$host_has_profile_pic [ny_lasso_raw$host_has_profile_pic == "f"] <- 0

ny_lasso_raw$host_identity_verified [ny_lasso_raw$host_identity_verified == "t"] <- 1
ny_lasso_raw$host_identity_verified [ny_lasso_raw$host_identity_verified == "f"] <- 0

ny_lasso_raw$has_availability [ny_lasso_raw$has_availability == "t"] <- 1
ny_lasso_raw$has_availability [ny_lasso_raw$has_availability == "f"] <- 0

ny_lasso_raw$amenities_Wifi [ny_lasso_raw$amenities_Wifi == "true"] <- 1
ny_lasso_raw$amenities_Wifi [ny_lasso_raw$amenities_Wifi == "false"] <- 0

ny_lasso_raw$amenities_Backyard [ny_lasso_raw$amenities_Backyard == "true"] <- 1
ny_lasso_raw$amenities_Backyard [ny_lasso_raw$amenities_Backyard == "false"] <- 0

ny_lasso_raw$amenities_TV [ny_lasso_raw$amenities_TV == "true"] <- 1
ny_lasso_raw$amenities_TV [ny_lasso_raw$amenities_TV == "false"] <- 0

ny_lasso_raw$amenities_Washer [ny_lasso_raw$amenities_Washer == "true"] <- 1
ny_lasso_raw$amenities_Washer [ny_lasso_raw$amenities_Washer == "false"] <- 0

ny_lasso_raw$amenities_Dishwasher [ny_lasso_raw$amenities_Dishwasher == "true"] <- 1
ny_lasso_raw$amenities_Dishwasher [ny_lasso_raw$amenities_Dishwasher == "false"] <- 0

ny_lasso_raw$amenities_AC [ny_lasso_raw$amenities_AC == "true"] <- 1
ny_lasso_raw$amenities_AC [ny_lasso_raw$amenities_AC == "false"] <- 0

ny_lasso_raw$amenities_Breakfast [ny_lasso_raw$amenities_Breakfast == "true"] <- 1
ny_lasso_raw$amenities_Breakfast [ny_lasso_raw$amenities_Breakfast == "false"] <- 0


# Convert price_per_accomate variable to numeric, because currently it's text (class:character, we need numeric)
ny_lasso_raw$price_per_accomate = as.numeric(as.character(ny_lasso_raw$price_per_accomate))


# Replacing N/A's with the mean of the other values for that variable (so that we don't lose a lot of data)
ny_lasso_raw$host_acceptance_rate <- as.numeric(gsub('[%]', '', ny_lasso_raw$host_acceptance_rate))
ny_lasso_raw$host_response_rate <- as.numeric(gsub('[%]', '', ny_lasso_raw$host_response_rate))

# Replacing N/A's in one column, formula used for this: Column1[is.na(Column1)] <- round(mean(Column1, na.rm = TRUE))
# Using mean (for the % variables)
ny_lasso_raw$host_response_rate [is.na(ny_lasso_raw$host_response_rate)] <- round(mean(ny_lasso_raw$host_response_rate, na.rm = TRUE))
ny_lasso_raw$host_acceptance_rate [is.na(ny_lasso_raw$host_acceptance_rate)] <- round(mean(ny_lasso_raw$host_acceptance_rate, na.rm = TRUE))

# Using median (for the bedrooms variable, where using the mean wouldn't make sense)
ny_lasso_raw$bedrooms [is.na(ny_lasso_raw$bedrooms)] <- round(median(ny_lasso_raw$bedrooms, na.rm = TRUE))

# Deleting entries with N/A's (we lose only a few instances with this)
ny_lasso_clean <- na.omit(ny_lasso_raw)
summary(ny_lasso_clean)


#output created used for the lasso regression in the next step
write.csv(ny_lasso_clean, "data/ny_lasso_clean.csv")
