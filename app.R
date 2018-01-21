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
        
        checkboxGroupInput("area", "Select a neighbourhood:", c('City', 'Suburb', 'Town', 'Rural'), 
                           selected = c("City"), inline = TRUE),
        
        sliderInput("fees", "Annual cost of attendance:",
                    min = 0, max = 100000,
                    value = c(min(data$Cost_att, na.rm = TRUE), 30000), pre = "$"),
        
        checkboxGroupInput("control", "Select school status:", unique(data$Control), 
                           selected = c("Public"), inline = TRUE),
        
        # Selection of cities inside selected states
        uiOutput("cityControls"),
        
        # The go button to filter everything at once
        actionButton("go", "Apply")
      ),
      
      # Show a plot of the generated distribution
      mainPanel(
        tabsetPanel(
          tabPanel("General", 
            # Display the bar plot
            radioButtons("bar_var", "", c("by ethnic group" = "ethnic", "by family income" = "income"), inline = TRUE),
            
            conditionalPanel(condition = "input.bar_var == 'ethnic'",
                             h3("Proportion of students by ethnic group")),
            conditionalPanel(condition = "input.var_var == 'income'",
                             h3("Proportion of students by family income")),
           
            plotOutput("barPlot"),
            
            "____________________________________________________________________________",
            br(),
            
            # Display the proportion plot
            checkboxGroupInput("prop_var", "", c("Federal student loan" = "Federal_loan", "Pell Grant" = "Pell_Grant", "Women", "Married", "Dependent"), 
                               selected = c("Women", "Federal_loan", "Pell_Grant", "Married", "Dependent"), inline = TRUE),
            
            h3("Proportion of students for each school"),
            plotOutput("distPlot")
          ),
          tabPanel("Zoom",
                   # Selection of cities inside selected states
                   uiOutput("schoolControl"),
                   
                   h3("Average earnings of former students by year after entry"),
                   plotOutput("progPlot")
          ),
          tabPanel("Table",
                   dataTableOutput("table"))
        )
      )
   )
)

# Define server logic required to draw a histogram
server <- function(input, output) {
  
  ## Build an interactive city widget
  output$cityControls <- renderUI({
    cities <- data %>% 
      filter(State %in% input$states,
             Locale %in% input$area,
             Cost_att > input$fees[1], Cost_att < input$fees[2],
             Control %in% input$control) %>%  
      pull(City) %>% 
      unique() %>% 
      sort()
    
    
    selectizeInput("cities", label="Select cities:", choices=cities,
                   selected=cities[1:2], multiple = TRUE)
  })
  
  ## Filter the data for all the graphs
  data_filt <- eventReactive(input$go, { 
    data %>% 
      filter(State %in% input$states,
             City %in% input$cities, 
             Locale %in% input$area,
             Cost_att > input$fees[1], Cost_att < input$fees[2],
             Control %in% input$control)
  })
  
  
  ### General Panel ###
  
  ## Display the Bar plots
  output$barPlot <- renderPlot({
    # Bar plot for the ethnic group
    if (input$bar_var == "ethnic") {
      data_filt <- gather(data_filt(), "color", "pct", pct_white, pct_black, pct_hispanic, pct_asian)
      
      ggplot(data_filt, aes(x = Name, y = pct, fill = color, order = color)) +
        geom_bar(position = "fill", stat = "identity", color="black") +
        scale_x_discrete("") +
        scale_y_continuous("Proportion") +
        scale_fill_manual("Ethnic group   ", labels = c("Asian", "Black", "Hispanic", "White"),
                          values = c("sienna4", "darkorange3", "orange2", "gold1")) +
        theme_light() + 
        theme(axis.text.x = element_text(angle = 90, hjust = 1))
    } 
    # Bar plot for the family income
    else {
      data_filt <- gather(data_filt(), "income", "prop", Low_income, Mid1_income, Mid2_income, High1_income, High2_income)
      
      ggplot(data_filt, aes(x = Name, y = prop, fill = income, order = income)) +
        geom_bar(position = "fill", stat = "identity", color="black") +
        scale_x_discrete("") +
        scale_y_continuous("Proportion") +
        scale_fill_manual("Income (USD)", labels = c("110k and +", "75k to 110k", "48k to 75k", "30k to 48k", "0k to 30k"),
                          values = c("black", "sienna4", "darkorange3", "orange2", "gold1")) +
        theme_light() + 
        theme(axis.text.x = element_text(angle = 90, hjust = 1))
    }
  })
  
  ## Display the distribution plot
  output$distPlot <- renderPlot({
    # Variables colours
    varColors <- c("dodgerblue2", "darkorchid4", "firebrick3", "darkorange2", "goldenrod2")
    names(varColors) <- c("Federal_loan", "Pell_Grant", "Women", "Married", "Dependent")
    
    # Distribution plot for selected variables
    p <- ggplot(data_filt()) 
    
    for (var in input$prop_var) {
      p <- p + geom_point(aes_string(x = var, y = 'Name', colour = shQuote(var)), 
                          size = 3) 
    }
    
    p + facet_grid(State ~ ., scales = "free", space = "free") +
      scale_x_continuous("Proportion", limits = c(0,1)) +
      scale_y_discrete("") +
      scale_colour_manual(name = "", values = varColors) +
      theme_bw()
  })
  
  
  ### Zoom Panel ###
  
  ## Build an interactive city widget
  output$schoolControl <- renderUI({
    schools <- data_filt() %>% 
      pull(Name) %>% 
      unique() %>% 
      sort()
    
    selectInput("school", label="Select a school:", choices=schools)
  })
  
  ## Progression plot
  output$progPlot <- renderPlot({
    data_filt <- data_filt() %>% 
      filter(Name == input$school) %>% 
      gather("year", "earnings", Mean_earning_6, Mean_earning_7, 
             Mean_earning_8, Mean_earning_9, Mean_earning_10) %>% 
      mutate(year = str_replace(year, "Mean_earning_6", "6"),
             year = str_replace(year, "Mean_earning_7", "7"),
             year = str_replace(year, "Mean_earning_8", "8"),
             year = str_replace(year, "Mean_earning_9", "9"),
             year = str_replace(year, "Mean_earning_10", "10"),
             year = as.numeric(year)) 
    
    ggplot(data_filt, aes(x = year, y = earnings)) + 
      geom_point(size = 3) +
      geom_line() +
      scale_x_continuous("Number of years after entry") +
      scale_y_continuous("Average earnings (USD)") +
      theme_light()
  })
  
  ## Render the table
  output$table <- renderDataTable(data_filt())
}

# Run the application 
shinyApp(ui = ui, server = server)

