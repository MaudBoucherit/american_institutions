# 
# American Institutions App
# Maud Boucherit, Jan 2018
#
# This app displays visualizations about Amercian institutions.
# You can interact with the plots, select features, institutions.
# 
# url: 

library(shiny)
library(tidyverse)

# Define UI for application that draws a histogram
ui <- fluidPage(
   
   # Application title
   titlePanel("American Institutions App"),
   
   # Sidebar with a slider input for number of bins 
   sidebarLayout(
      sidebarPanel(
         
      ),
      
      # Show a plot of the generated distribution
      mainPanel(
         
      )
   )
)

# Define server logic required to draw a histogram
server <- function(input, output) {
   
   
}

# Run the application 
shinyApp(ui = ui, server = server)

