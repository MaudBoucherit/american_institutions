# 
# American Institutions App
# Maud Boucherit, Jan 2018
#
# This app displays visualizations about Amercian institutions.
# You can interact with the plots, select features, institutions.
# 
# url: 

# Packages
library(shiny)
library(tidyverse)
library(scales)

# Load data
data <- read_csv("data/scorecard.csv")
states <- read_csv("data/states.csv")
named_states <- states$id
names(named_states) <- states$names


# Define UI for application that draws a histogram
ui <- fluidPage(
   
   # Application title
   titlePanel("American Institutions App"),
   
   # Sidebar with a slider input for number of bins 
   sidebarLayout(
      sidebarPanel(
        h3("Filter institutions:"),
        
        selectizeInput("states", label="Select states:", choices=named_states,
                    selected = c('IN', 'IL'), multiple = TRUE),
        
        # Selection of cities inside selected states
        uiOutput("cityControls"),
        
        checkboxGroupInput("area", "Select a neighbourhood:", c('City', 'Suburb', 'Town', 'Rural'), 
                           selected = c("City"), inline = TRUE),
        
        sliderInput("fees", "Annual cost of attendance:",
                    min = 0, max = 100000,
                    value = c(min(data$COSTT4_A, na.rm = TRUE), 30000), pre = "$"),
        
        checkboxGroupInput("control", "Select school status:", unique(data$CONTROL), 
                           selected = c("Public"), inline = TRUE)
        
      ),
      
      # Show a plot of the generated distribution
      mainPanel(
        
      )
   )
)

# Define server logic required to draw a histogram
server <- function(input, output) {
  
  output$cityControls <- renderUI({
    cities <- data %>% 
      filter(STABBR %in% input$states,
             LOCALE %in% input$area,
             COSTT4_A > input$fees[1], COSTT4_A < input$fees[2],
             CONTROL %in% input$control) %>%  
      pull(CITY) %>% 
      unique()
    
    
    selectizeInput("cities", label="Select cities:", choices=cities,
                   selected=cities[1:2], multiple = TRUE)
  })
  
  
}

# Run the application 
shinyApp(ui = ui, server = server)

