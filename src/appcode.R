##################
### SHINY APP ####
##################

# -- Installing shiny libraries
# install.packages('shinyWidgets')
# install.packages('shiny')

#setwd()

# -- Loading required libraries
library(shiny) 
library(shinyWidgets)
library(dplyr)
library(readr)

# -- Loading data
ny_app <- read.csv("data/ny_app.csv")

# -- You have to delete the first column before you run the app as well as recoding the neighborhood variable
# -- Removing the first column
# ny_app <- ny_app[c(-1)]

# -- Recoding neighborhood variable to a factor variable
ny_app$neighbourhood_group_cleansed <- as.factor(ny_app$neighbourhood_group_cleansed)

# -- Code for the app
ui <- fluidPage(
  sidebarLayout(
    sidebarPanel(
      h2("Where to rent in New York City?"),
      selectInput(inputId = "neighbourhood", 
                  label = "Neighbourhood", 
                  choices = levels(ny_app$neighbourhood_group_cleansed), 
                  multiple = TRUE, 
                  selected = ("Manhattan")),
      h4("Amenities"), 
      sliderTextInput(
        inputId = "wifi",
        label = "Wifi", 
        choices = c("No", "Yes"),
        selected = "Yes",
        grid = TRUE,
        width = NULL
      ),
      sliderTextInput(
        inputId = "backyard",
        label = "Backyard", 
        choices = c("No", "Yes"),
        grid = TRUE,
        width = NULL
      ),
      sliderTextInput(
        inputId = "tv",
        label = "TV", 
        choices = c("No", "Yes"),
        selected = "Yes",
        grid = TRUE,
        width = NULL
      ),
      sliderTextInput(
        inputId = "washer",
        label = "Washer", 
        choices = c("No", "Yes"),
        grid = TRUE,
        width = NULL
      ),
      sliderTextInput(
        inputId = "dishwasher",
        label = "Dishwasher", 
        choices = c("No", "Yes"),
        grid = TRUE,
        width = NULL
      ),
      sliderTextInput(
        inputId = "ac",
        label = "AC", 
        choices = c("No", "Yes"),
        selected = "Yes",
        grid = TRUE,
        width = NULL
      ),
      sliderTextInput(
        inputId = "breakfast",
        label = "Breakfast", 
        choices = c("No", "Yes"),
        grid = TRUE,
        width = NULL
      ),
      selectInput(inputId = "accommodates", 
                  label = "Number of accommodates", 
                  choices = order(unique(ny_app$accommodates)), 
                  selected = ("1")),
      sliderInput(inputId = "pricerange", 
                  label = "Price per night per accomate (in $)", 
                  min = min(ny_app$price_per_accomate), 
                  max = max(ny_app$price_per_accomate), 
                  value = c(150, 5000)),
      submitButton(text = "Search Options", icon = NULL),
      h6(""),
      downloadButton(outputId = "download_data", label = "Download"),
    ),
    mainPanel(
      DT::dataTableOutput(outputId = "table"))
  )
)
server <- function(input, output) {
  filtered_data <- reactive({
    subset(ny_app,
      neighbourhood_group_cleansed %in% input$neighbourhood &
      (price_per_accomate >= input$pricerange[1] & price_per_accomate <= input$pricerange[2]) &
        accommodates == input$accommodates &
        Wifi == input$wifi &
        Backyard == input$backyard &
        TV == input$tv &
        Washer == input$washer &
        Dishwasher == input$dishwasher &
        AC == input$ac &
        Breakfast == input$breakfast
      )})
  output$table <- DT::renderDataTable({
    filtered_data() %>% arrange(desc(lasso_rating)) 
  })
  
  output$download_data <- downloadHandler(
    filename = "download_data.csv",
    content = function(file) {
      data <- filtered_data()
      write.csv(data, file, row.names = FALSE)
    }
  )
}

shinyApp(ui = ui, server = server) 
