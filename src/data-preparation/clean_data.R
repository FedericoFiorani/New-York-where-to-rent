######################
### CLEANING DATA ####
######################

# Libraries used

library(dplyr)
library(stringr)



#### Filtering out the variables not considered relevant for our purpose ####

# Filtering out the units that have less than 3 reviews. The average rating is going to be our dependent variable so we need it to be accurate for all the units.
ny_df <- subset(ny_df, ny_df$number_of_reviews >3)
View(ny_df)

# Filtering out inactive profiles: by canceling airbnbs that haven't been reviewed since 2016-09-29 (last 5 percentiles)
startdate <- as.Date('2021-10-04')
ny_df$last_review <- as.Date(ny_df$last_review,"%Y-%m/-%d")
ny_df$n_days_last_review <- as.numeric((-1)*(difftime(ny_df$last_review,startdate)))
hist(ny_df$n_days_last_review)
deciles_last_review_days <- quantile(ny_df$n_days_last_review, probs = seq(.05, .95, by = .05))
deciles_last_review_days
ny_df <- subset(ny_df, ny_df$n_days_last_review <1824)

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
ny_df$n_character_in_desription <- nchar(ny_df$description, type = "chars", allowNA = TRUE, keepNA = TRUE)
ny_df$n_character_in_desription[is.na(ny_df$n_character_in_desription)] <- 0

# Create the variable: number of days since host
ny_df$host_since <- as.Date(ny_df$host_since,"%Y-%m/-%d")
startdate <- as.Date('2021-10-04')
ny_df$n_days_host_since  <- (-1)*(difftime(ny_df$host_since,startdate))
ny_df$n_days_host_since  <- as.numeric(ny_df$n_days_host_since)

# Creating a new variable: number of characters used by the host to describe himself on his Airbnb profile (in the variable 'host_about')
ny_df$n_characters_in_host_about <- nchar(ny_df$host_about, type = "chars", allowNA = TRUE, keepNA = TRUE)
ny_df$n_characters_in_host_about[is.na(ny_df$n_characters_in_host_about)] <- 0

# Creating a new variable: number of verifications of the host (from the variable 'host_verifications')
ny_df$host_verifications[1]
ny_df$n_host_verifications <- lengths(regmatches(ny_df$host_verifications, gregexpr(",", ny_df$host_verifications)))+1

# Create a new variable: class of property type. As there are 55 different property in from (shared room, boats, entire bungalov etc..)

# We here create 3 groups of accommodation type: 
# 1. if the room is  shared with other people  
# 2. if the accommodation (might be a house as a bungalov or a boat) is shared
# 3. if the accommodation in entirely for the host and no one else is supposed to be in the living area

categories <- unique(ny_df$property_type)
numberOfCategories <- length(categories)
categories;numberOfCategories

unit <- 1
while (unit<20000){
  if (grepl('Shared', ny_df$property_type[unit], fixed = FALSE)==TRUE){
    ny_df$classes_property_type[unit]=1
  }
  else if (grepl('Floor', ny_df$property_type[unit], fixed = FALSE)==TRUE){
    ny_df$classes_property_type[unit]=1
  }
  else if (grepl('Private', ny_df$property_type[unit], fixed = FALSE)==TRUE){
    ny_df$classes_property_type[unit]=2
  }
  else if (grepl('Room', ny_df$property_type[unit], fixed = FALSE)==TRUE){
    ny_df$classes_property_type[unit]=2
  }
  else if (grepl('Entire', ny_df$property_type[unit], fixed = FALSE)==TRUE){
    ny_df$classes_property_type[unit]=3
  }
  else {
    ny_df$classes_property_type[unit]=3
  }
  unit <- unit + 1
}


# Create new variables regarding bathrooms: bathroom type and number of bathrooms

#--bathroom_type (1=shared or 2=not shared) 
is.na(ny_df$bathrooms_text[unit_b])

ny_df$bathrooms_type <- 0

unit_b <- 1

while (unit_b<20000){
  if (grepl('Shared', ny_df$bathrooms_text[unit_b], fixed = FALSE)==TRUE){
    ny_df$bathrooms_type[unit_b]=1
  }
  else if (grepl('shared', ny_df$bathrooms_text[unit_b], fixed = FALSE)==TRUE){
    ny_df$bathrooms_type[unit_b]=1
  }
  else {
    ny_df$bathrooms_type[unit_b]=2
  }
  unit_b <- unit_b + 1
}

#--number of bathrooms
ny_df$bathroom_number <- 0

unit_b <- 1

while (unit_b<20000){
  if (grepl('1.5', ny_df$bathrooms_text[unit_b], fixed = FALSE)==TRUE){
    ny_df$bathroom_number[unit_b]=1.5
  }
  else if (grepl('2.5', ny_df$bathrooms_text[unit_b], fixed = FALSE)==TRUE){
    ny_df$bathroom_number[unit_b]=2.5
  }
  else if (grepl('3.5', ny_df$bathrooms_text[unit_b], fixed = FALSE)==TRUE){
    ny_df$bathroom_number[unit_b]=3.5
  }
  else if (grepl('2', ny_df$bathrooms_text[unit_b], fixed = FALSE)==TRUE){
    ny_df$bathroom_number[unit_b]=2
  }
  else if (grepl('1', ny_df$bathrooms_text[unit_b], fixed = FALSE)==TRUE){
    ny_df$bathroom_number[unit_b]=1
  }
  else if (grepl('3', ny_df$bathrooms_text[unit_b], fixed = FALSE)==TRUE){
    ny_df$bathroom_number[unit_b]=3
  }
  else if (grepl('4', ny_df$bathrooms_text[unit_b], fixed = FALSE)==TRUE){
    ny_df$bathroom_number[unit_b]=4
  }
  else if (grepl('0.5', ny_df$bathrooms_text[unit_b], fixed = FALSE)==TRUE){
    ny_df$bathroom_number[unit_b]=0.5
  }
  else if (grepl('half', ny_df$bathrooms_text[unit_b], fixed = FALSE)==TRUE){
    ny_df$bathroom_number[unit_b]=0.5
  }
  else if (grepl('Half', ny_df$bathrooms_text[unit_b], fixed = FALSE)==TRUE){
    ny_df$bathroom_number[unit_b]=0.5
  }
  else if (grepl('5', ny_df$bathrooms_text[unit_b], fixed = FALSE)==TRUE){
    ny_df$bathroom_number[unit_b]=5
  }
  else if (grepl('6', ny_df$bathrooms_text[unit_b], fixed = FALSE)==TRUE){
    ny_df$bathroom_number[unit_b]=6
  }
  else {
    ny_df$bathroom_number[unit_b]=1
  }
  unit_b <- unit_b + 1
}


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




#### Data fitting for Lasso regression ####


# Selecting relevant variables (we need neighbourhood_group_cleansed instead of neighbourhood, because there are no N/A-s in that variable)
ny_lasso_raw <- ny_df[,c('id','host_response_rate','host_acceptance_rate','host_is_superhost','host_total_listings_count','host_has_profile_pic','host_identity_verified','neighbourhood_group_cleansed'
                         ,'accommodates','bedrooms','beds','minimum_nights_avg_ntm','maximum_nights_avg_ntm','has_availability','availability_60','availability_365','number_of_reviews',
                         'review_scores_accuracy','review_scores_cleanliness','review_scores_checkin','review_scores_communication','review_scores_location','review_scores_value','calculated_host_listings_count'
                         ,'reviews_per_month','n_days_last_review','n_character_in_desription','n_days_host_since','n_characters_in_host_about','n_host_verifications','classes_property_type',
                         'bathrooms_type','bathroom_number','n_amenities','amenities_Wifi','amenities_Backyard','amenities_TV','amenities_Washer','amenities_Dishwasher','amenities_AC','amenities_Breakfast','price_new','price_per_accomate')]
View(ny_lasso_raw)

# Converting TRUE/FALSE into 1/0 (TRUE=1, FALSE=0), because Lasso regression can't process TRUE/FALSE format
ny_lasso_raw$host_is_superhost [ny_lasso_raw$host_is_superhost == "true"] <- 1
ny_lasso_raw$host_is_superhost [ny_lasso_raw$host_is_superhost == "false"] <- 0

ny_lasso_raw$host_has_profile_pic [ny_lasso_raw$host_has_profile_pic == "true"] <- 1
ny_lasso_raw$host_has_profile_pic [ny_lasso_raw$host_has_profile_pic == "false"] <- 0

ny_lasso_raw$host_identity_verified [ny_lasso_raw$host_identity_verified == "true"] <- 1
ny_lasso_raw$host_identity_verified [ny_lasso_raw$host_identity_verified == "false"] <- 0

ny_lasso_raw$has_availability [ny_lasso_raw$has_availability == "true"] <- 1
ny_lasso_raw$has_availability [ny_lasso_raw$has_availability == "false"] <- 0

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
View(ny_lasso_clean)
summary(ny_lasso_clean)
