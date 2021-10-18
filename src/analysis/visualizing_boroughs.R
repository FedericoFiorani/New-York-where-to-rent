ny_pre_app <- read.csv("ny_pre_app.csv")
View(ny_pre_app)

# Creating subsets
ny_bro <- subset(ny_pre_app, ny_pre_app$neighbourhood_group_cleansed=='Brooklyn')
ny_man <- subset(ny_pre_app, ny_pre_app$neighbourhood_group_cleansed=='Manhattan')    
ny_que <- subset(ny_pre_app, ny_pre_app$neighbourhood_group_cleansed=='Queens')
ny_bron <- subset(ny_pre_app, ny_pre_app$neighbourhood_group_cleansed=='Bronx')
ny_sta <- subset(ny_pre_app, ny_pre_app$neighbourhood_group_cleansed=='Staten Island')
View(ny_bro)

#review_scores_accuracy
brooklyn_accuracy_avg_rating <- mean(ny_bro$review_scores_accuracy)
manhattan_accuracy_avg_rating <- mean(ny_man$review_scores_accuracy)
queens_accuracy_avg_rating <- mean(ny_que$review_scores_accuracy)
bronx_accuracy_avg_rating <- mean(ny_bron$review_scores_accuracy)
statenisland_accuracy_avg_rating <- mean(ny_sta$review_scores_accuracy)

#review_scores_cleanliness
brooklyn_cleanliness_avg_rating <- mean(ny_bro$review_scores_cleanliness)
manhattan_cleanliness_avg_rating <- mean(ny_man$review_scores_cleanliness)
queens_cleanliness_avg_rating <- mean(ny_que$review_scores_cleanliness)
bronx_cleanliness_avg_rating <- mean(ny_bron$review_scores_cleanliness)
statenisland_cleanliness_avg_rating <- mean(ny_sta$review_scores_cleanliness)

#review_scores_checkin
brooklyn_checkin_avg_rating <- mean(ny_bro$review_scores_checkin)
manhattan_checkin_avg_rating <- mean(ny_man$review_scores_checkin)
queens_checkin_avg_rating <- mean(ny_que$review_scores_checkin)
bronx_checkin_avg_rating <- mean(ny_bron$review_scores_checkin)
statenisland_checkin_avg_rating <- mean(ny_sta$review_scores_checkin)

#review_scores_communication
brooklyn_communication_avg_rating <- mean(ny_bro$review_scores_communication)
manhattan_communication_avg_rating <- mean(ny_man$review_scores_communication)
queens_communication_avg_rating <- mean(ny_que$review_scores_communication)
bronx_communication_avg_rating <- mean(ny_bron$review_scores_communication)
statenisland_communication_avg_rating <- mean(ny_sta$review_scores_communication)

#review_scores_location
brooklyn_location_avg_rating <- mean(ny_bro$review_scores_location)
manhattan_location_avg_rating <- mean(ny_man$review_scores_location)
queens_location_avg_rating <- mean(ny_que$review_scores_location)
bronx_location_avg_rating <- mean(ny_bron$review_scores_location)
statenisland_location_avg_rating <- mean(ny_sta$review_scores_location)

#host_is_superhost
(table(ny_bro$host_is_superhost == 1)/length(ny_bro$host_is_superhost))*100
brooklyn_superhost <- 32.97829

(table(ny_man$host_is_superhost == 1)/length(ny_man$host_is_superhost))*100
manhattan_superhost <- 26.25747

(table(ny_que$host_is_superhost == 1)/length(ny_que$host_is_superhost))*100
queens_superhost <- 35.04307

(table(ny_bron$host_is_superhost == 1)/length(ny_bron$host_is_superhost))*100
bronx_superhost <- 39.1015

(table(ny_sta$host_is_superhost == 1)/length(ny_sta$host_is_superhost))*100
statenisland_superhost <- 52.29358


#accommodates
brooklyn_accommodates <- mean(ny_bro$accommodates)
manhattan_accommodates <- mean(ny_man$accommodates)
queens_accommodates <- mean(ny_que$accommodates)
bronx_accommodates <- mean(ny_bron$accommodates)
statenisland_accommodates <- mean(ny_sta$accommodates)

#availability_365
brooklyn_availability_365 <- mean(ny_bro$availability_365)
manhattan_availability_365 <- mean(ny_man$availability_365)
queens_availability_365 <- mean(ny_que$availability_365)
bronx_availability_365 <- mean(ny_bron$availability_365)
statenisland_availability_365 <- mean(ny_sta$availability_365)

#availability_60
brooklyn_availability_60 <- mean(ny_bro$availability_60)
manhattan_availability_60 <- mean(ny_man$availability_60)
queens_availability_60 <- mean(ny_que$availability_60)
bronx_availability_60 <- mean(ny_bron$availability_60)
statenisland_availability_60 <- mean(ny_sta$availability_60)

#host_response_rate
brooklyn_host_response_rate <- mean(ny_bro$host_response_rate)
manhattan_host_response_rate <- mean(ny_man$host_response_rate)
queens_host_response_rate <- mean(ny_que$host_response_rate)
bronx_host_response_rate <- mean(ny_bron$host_response_rate)
statenisland_host_response_rate <- mean(ny_sta$host_response_rate)

#n_amenities
brooklyn_n_amenities <- mean(ny_bro$n_amenities)
manhattan_n_amenities <- mean(ny_man$n_amenities)
queens_n_amenities <- mean(ny_que$n_amenities)
bronx_n_amenities <- mean(ny_bron$n_amenities)
statenisland_n_amenities <- mean(ny_sta$n_amenities)

# Create vectors
review_scores_accuracy <- c(brooklyn_accuracy_avg_rating, manhattan_accuracy_avg_rating, queens_accuracy_avg_rating, bronx_accuracy_avg_rating, statenisland_accuracy_avg_rating)
review_scores_cleanliness <- c(brooklyn_cleanliness_avg_rating, manhattan_cleanliness_avg_rating, queens_cleanliness_avg_rating, bronx_cleanliness_avg_rating, statenisland_cleanliness_avg_rating)
review_scores_checkin <- c(brooklyn_checkin_avg_rating, manhattan_checkin_avg_rating, queens_checkin_avg_rating, bronx_checkin_avg_rating, statenisland_checkin_avg_rating)
review_scores_communication <- c(brooklyn_communication_avg_rating, manhattan_communication_avg_rating, queens_communication_avg_rating, bronx_communication_avg_rating, statenisland_communication_avg_rating)
review_scores_location <- c(brooklyn_location_avg_rating, manhattan_location_avg_rating, queens_location_avg_rating, bronx_location_avg_rating, statenisland_location_avg_rating)
host_is_superhost <- c(brooklyn_superhost, manhattan_superhost, queens_superhost, bronx_superhost, statenisland_superhost)
accommodates <- c(brooklyn_accommodates, manhattan_accommodates, queens_accommodates, bronx_accommodates, statenisland_accommodates)
availability_365 <- c(brooklyn_availability_365, manhattan_availability_365, queens_availability_365, bronx_availability_365, statenisland_availability_365)
availability_60 <- c(brooklyn_availability_60, manhattan_availability_60, queens_availability_60, bronx_availability_60, statenisland_availability_60)
host_response_rate <- c(brooklyn_host_response_rate, manhattan_host_response_rate, queens_host_response_rate, bronx_host_response_rate, statenisland_host_response_rate)
n_amenities <- c(brooklyn_n_amenities, manhattan_n_amenities, queens_n_amenities, bronx_n_amenities, statenisland_n_amenities)

ny_visualization <- matrix(c(review_scores_accuracy, review_scores_cleanliness, review_scores_checkin, review_scores_communication, review_scores_location, host_is_superhost, accommodates, availability_365, availability_60, host_response_rate, n_amenities), ncol=5, byrow=TRUE)

colnames(ny_visualization) <- c('Brooklyn','Manhattan','Queens','Bronx','Staten_Island')
rownames(ny_visualization) <- c('review_scores_accuracy','review_scores_cleanliness','review_scores_checkin','review_scores_communication','review_scores_location','host_is_superhost','accommodates','availability_365','availability_60','host_response_rate','n_amenities')

ny_vis2 <- as.data.frame.matrix(ny_visualization)
ny_vis2 <- t(ny_visualization)
View(ny_vis2)

write.csv(ny_vis2, "ny_vis2.csv")

ny_vis <- read.csv("ny_vis2.csv")

View(ny_vis)

library(tidyverse)
ny_vis <- ny_vis %>% remove_rownames %>% column_to_rownames(var="X")


library(ggplot2)
library(dplyr)
library(reshape2)

colnames(ny_vis) <- c('Borough','review_scores_accuracy','review_scores_cleanliness','review_scores_checkin','review_scores_communication','review_scores_location','host_is_superhost','accommodates','availability_365','availability_60','host_response_rate','n_amenities')

ny_vis %>%
  ggplot(aes(x = Borough, y = review_scores_accuracy)) +
  geom_bar(stat='identity') +
  geom_text(aes(label = signif(review_scores_accuracy, digits = 4)), nudge_y = 0.3)
  
ny_vis %>%
  ggplot(aes(x = Borough, y = review_scores_cleanliness)) +
  geom_bar(stat='identity') +
  geom_text(aes(label = signif(review_scores_cleanliness, digits = 4)), nudge_y = 0.3)

ny_vis %>%
  ggplot(aes(x = Borough, y = review_scores_checkin)) +
  geom_bar(stat='identity') +
  geom_text(aes(label = signif(review_scores_checkin, digits = 4)), nudge_y = 0.3)

ny_vis %>%
  ggplot(aes(x = Borough, y = review_scores_communication)) +
  geom_bar(stat='identity') +
  geom_text(aes(label = signif(review_scores_communication, digits = 4)), nudge_y = 0.3)

ny_vis %>%
  ggplot(aes(x = Borough, y = review_scores_location)) +
  geom_bar(stat='identity') +
  geom_text(aes(label = signif(review_scores_location, digits = 4)), nudge_y = 0.3)

ny_vis %>%
  ggplot(aes(x = Borough, y = host_is_superhost)) +
  geom_bar(stat='identity') +
  geom_text(aes(label = signif(host_is_superhost, digits = 4)), nudge_y = 3)

ny_vis %>%
  ggplot(aes(x = Borough, y = accommodates)) +
  geom_bar(stat='identity') +
  geom_text(aes(label = signif(accommodates, digits = 4)), nudge_y = 0.2)

ny_vis %>%
  ggplot(aes(x = Borough, y = availability_365)) +
  geom_bar(stat='identity') +
  geom_text(aes(label = signif(availability_365, digits = 4)), nudge_y = 10)

ny_vis %>%
  ggplot(aes(x = Borough, y = availability_60)) +
  geom_bar(stat='identity') +
  geom_text(aes(label = signif(availability_60, digits = 4)), nudge_y = 1.5)

ny_vis %>%
  ggplot(aes(x = Borough, y = host_response_rate)) +
  geom_bar(stat='identity') +
  geom_text(aes(label = signif(host_response_rate, digits = 4)), nudge_y = 5)

ny_vis %>%
  ggplot(aes(x = Borough, y = n_amenities)) +
  geom_bar(stat='identity') +
  geom_text(aes(label = signif(n_amenities, digits = 4)), nudge_y = 2)
