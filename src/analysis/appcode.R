############
### APP ####
############

# Loading required libraries
library(shiny) 
library(dplyr)
library(readr)

# Loading data
ny <- read.csv("../../data/ny_pre_app.csv")

# Recoding amenities and neighborhood variables to a factor variable
ny$neighbourhood_group_cleansed <- as.factor(ny$neighbourhood_group_cleansed)
ny$Wifi <- as.factor(ny$amenities_Wifi)
ny$Backyard <- as.factor(ny$amenities_Backyard)
ny$TV <- as.factor(ny$amenities_TV)
ny$Washer <- as.factor(ny$amenities_Washer)
ny$Dishwasher <- as.factor(ny$amenities_Dishwasher)
ny$AC <- as.factor(ny$amenities_AC)
ny$Breakfast <- as.factor(ny$amenities_Breakfast)

ny <- ny %>% arrange(ny$accommodates)

# Code for the app
ui <- fluidPage(
  sidebarLayout(
    sidebarPanel(
      h2("Where to rent in New York City?"),
      selectInput(inputId = "neighbourhood", 
                  label = "Neighbourhood", 
                  choices = levels(ny$neighbourhood_group_cleansed), 
                  multiple = TRUE, 
                  selected = ("Manhattan")),
      checkboxGroupInput(inputId = "options", 
                         label = "Amenities"), 
      checkboxInput("checkbox1", "Wifi", value = TRUE),
      checkboxInput("checkbox2", "Backyard", value = FALSE),
      checkboxInput("checkbox3", "TV", value = TRUE),
      checkboxInput("checkbox4", "Washer", value = FALSE),
      checkboxInput("checkbox5", "Dishwasher", value = FALSE),
      checkboxInput("checkbox6", "AC", value = FALSE),
      checkboxInput("checkbox7", "Breakfast", value = FALSE),
      selectInput(inputId = "accommodates", 
                  label = "Number of accommodates", 
                  choices = order(unique(ny$accommodates)), 
                  selected = ("3")),
      sliderInput(inputId = "pricerange", 
                  label = "Price per night per accomate (in $)", 
                  min = min(ny$price_per_accomate), 
                  max = max(ny$price_per_accomate), 
                  value = c(250, 9750)),
      submitButton(text = "Search Options", icon = NULL),
    ),
    mainPanel(
      DT::dataTableOutput(outputId = "table"))
  )
)
server <- function(input, output) {
  filtered_data <- reactive({
    subset(ny,
      neighbourhood_group_cleansed %in% input$neighbourhood &
      (price_per_accomate >= input$pricerange[1] & price_per_accomate <= input$pricerange[2]) &
        accommodates == input$accommodates )})
  output$table <- DT::renderDataTable({
    filtered_data() %>% arrange(desc(lasso_rating)) 
  })
}

shinyApp(ui = ui, server = server) 
