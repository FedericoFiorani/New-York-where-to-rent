#creating a new variable number of characters in the 'description'
ny_df$n_characters_in_desription <- nchar(ny_df$description, type = "chars", allowNA = TRUE, keepNA = TRUE)
ny_df$n_characters_in_desription[is.na(ny_df$n_characters_in_desription)] <- 0

#create the variable number of days since host
ny_df$host_since <- as.Date(ny_df$host_since,"%Y-%m/-%d")
startdate <- as.Date('2021-09-27')
ny_df$n_days_host_since  <- (-1)*(difftime(ny_df$host_since,startdate))
ny_df$n_days_host_since  <- as.numeric(ny_df$n_days_host_since)


#create a new variable: number of characters used by the host to describe himself on his airbnb profile (the variable 'host_about')
ny_df$n_characters_in_host_about <- nchar(ny_df$host_about, type = "chars", allowNA = TRUE, keepNA = TRUE)
ny_df$n_characters_in_host_about[is.na(ny_df$n_characters_in_host_about)] <- 0

#create a new variable: number of verifications of the host (from the variable'host_verifications')
ny_df$host_verifications[1]
ny_df$n_host_verifications <- lengths(regmatches(ny_df$host_verifications, gregexpr(",", ny_df$host_verifications)))+1

#create a new variable class of property type. As there are 55 different property in from (shared room, boats , entire bungalov etc..) 
#We here create 3 groups of accomodation type: 1. if the room is  shared with other people  2.if the accomodation (might be a house as a bungalov or a boat)is shared
#3. if the accomodation in entirly for the host and no ine else is supposed to be in the living area
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
