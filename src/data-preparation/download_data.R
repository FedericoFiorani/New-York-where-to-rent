######################
### DOWNLOAD DATA ####
######################

# Installing packages (maybe optional)
install.packages('googledrive')
install.packages('readr')

# Libraries
library(googledrive)
library(readr)

# Data download from Google Drive
files = list("https://drive.google.com/file/d/1yUQ0m5VH6IR-2EGAGWvmKLqnpVmhnNXH/view?usp=sharing",
             "https://drive.google.com/file/d/1kPUe5l67rsq2VkyHKj8_urST52lnteag/view?usp=sharing")

for (f in files) {
  cat(paste0('Downloading file: ', f, '...\n'))
  
  drive_download(
    file = f,
    overwrite = TRUE)
}

# Opening data in R
ny_df <- read_csv("listings.csv")
View(listings)

calendar <- read_csv("calendar.csv")
View(calendar)
