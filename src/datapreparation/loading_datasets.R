
library(readr)
library(here)

# Load downloaded listings data
listings_ny <- read_csv(here("data", "listings_ny.csv"))

# Load downloaded reviews data
#reviews_ny <- read_csv("data/reviews_ny.csv")

# Load downloaded neighborhood data
#neighborhoods_ny <- read_csv("data/neighborhoods_ny.csv")

# Load detailed reviews data (not in the drive(?))
#reviews_ny_detailed <- read_csv("data/reviews_ny_detailed.csv")