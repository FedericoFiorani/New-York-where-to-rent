
#installing required packages only if not already installed
packages <- c("googledrive"
              ,"readr",
              "dplyr",
              "here")
not_installed <- !packages %in% installed.packages()
if (any(not_installed)) install.packages(packages[not_installed])
lapply(packages,require,character.only=TRUE)

library(googledrive)
library(readr)

#download data sets
files = list("https://drive.google.com/file/d/1yUQ0m5VH6IR-2EGAGWvmKLqnpVmhnNXH/view?usp=sharing",
             "https://drive.google.com/file/d/1kPUe5l67rsq2VkyHKj8_urST52lnteag/view?usp=sharing")

for (f in files) {
  cat(paste0('Downloading file: ', f, '...\n'))
  
  drive_download(
    file = f,
    overwrite = TRUE)
}

