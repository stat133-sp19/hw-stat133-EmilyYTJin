#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(ggplot2)

# Define UI for application
ui <- fluidPage(
   
   #App Title
   titlePanel("Investment Simulations"),
   
   #Layout
   fluidRow(column(4, 
                   sliderInput("amount","Initial Amount:", 
                               min = 0, max = 100000, 
                               value = 1000, step = 500, 
                               pre = "$", sep = ",")), 
            column(4, 
                   sliderInput("rate", "Return Rate (in %):", 
                               min = 0, max = 20, 
                               value = 5, step = 0.1)), 
            column(4, 
                   sliderInput("years", "Years:", 
                               min = 0, max = 50, 
                               value = 20, step = 1))),
   fluidRow(column(4, 
                   sliderInput("contrib", "Annual Contribution:", 
                               min = 0, max = 50000,
                               value = 2000, step = 500,
                               pre = "$", sep = ",")), 
            column(4, 
                   sliderInput("growth", "Growth Rate (in %):", 
                               min = 0, max = 20, 
                               value = 2, step = 0.1)), 
            column(4, 
                   selectInput("facet", "Facet?",
                               choices = c("No", "Yes")))),
   
      
    #Layout of outputs
   tags$h2("Timelines"),
   
   fluidRow(
           plotOutput("plot")),
   
   tags$h2("Balances"), 
   
   fluidRow(verbatimTextOutput("table"))
     
     
)


# Define server logic required 
server <- function(input, output) {
  
  future_value <- function(amount, rate, years){
    amount * (1 + 0.01 * rate)^years
  }
  
  annuity <- function(contrib, rate, years){
    contrib * (((1 + 0.01 * rate)^years - 1) / (0.01 * rate))
  } 
  
  growing_annuity <- function(contrib, rate, growth, years){
    contrib * (((1 + 0.01 * rate)^years - (1 + 0.01 * growth)^years) / (0.01 * (rate - growth)))
  }
  
  investing_mode <- function(amount, rate, years, contrib, growth){
    lst_mode1 <- c(NA)
    lst_mode2 <- c(NA)
    lst_mode3 <- c(NA)
    for (n in 0:years) {
      lst_mode1[n + 1] <- future_value(amount = amount, rate = rate, years = n)
    }
    for (n in 0:years) {
      lst_mode2[n + 1] <- future_value(amount = amount, rate = rate, years = n) + 
        annuity(contrib = contrib, rate = rate, years = n)
    }
    for (n in 0:years) {
      lst_mode3[n + 1] <- future_value(amount = amount, rate = rate, years = n) + 
        growing_annuity(contrib = contrib, rate = rate, growth = growth, years = n)
    }
    modalities <- data.frame(year = 0:years, no_contrib = lst_mode1, fixed_contrib = lst_mode2, growing_contrib = lst_mode3)
    return(modalities)
  }
  
  investing_mode2 <- function(amount, rate, years, contrib, growth){
    year <- c(NA)
    values <- c(NA)
    type <- c(NA)
    for (n in 0:years){
      year[3 * n + 1] <- n
      year[3 * n + 2] <- n
      year[3 * n + 3] <- n
      values[3 * n + 1] <- future_value(amount = amount, rate = rate, years = n)
      values[3 * n + 2] <- future_value(amount = amount, rate = rate, years = n) + 
        annuity(contrib = contrib, rate = rate, years = n)
      values[3 * n + 3] <- future_value(amount = amount, rate = rate, years = n) + 
        growing_annuity(contrib = contrib, rate = rate, growth = growth, years = n)
      type[3 * n + 1] <- "no_contrib"
      type[3 * n + 2] <- "fixed_contrib"
      type[3 * n + 3] <- "growing_contrib"
    }
    modalities <- data.frame(year = year, values = values, type = factor(type, levels = c("no_contrib", "fixed_contrib", "growing_contrib")))
    return(modalities)
  }
 
  investments <- reactive({investing_mode(input$amount, input$rate, input$years, input$contrib, input$growth)})
  investments_facet <- reactive({investing_mode2(input$amount, input$rate, input$years, input$contrib, input$growth)})
  
    
  output$plot <- renderPlot({
    if(input$facet == "No"){
      ggplot(investments(), aes(x = year)) + 
        geom_point(aes(y = no_contrib, colour = "no_contrib")) + geom_line(aes(y = no_contrib, colour = "no_contrib")) +
        geom_point(aes(y = fixed_contrib, colour = "fixed_contrib")) + geom_line(aes(y = fixed_contrib, colour = "fixed_contrib")) +
        geom_point(aes(y = growing_contrib, colour = "growing_contrib")) + geom_line(aes(y = growing_contrib, colour = "growing_contrib")) +
        labs(x = "Year", y = "Annual balance in dollars", title = "Three modes of investing") +
        scale_color_manual(name = "variable", values = c("no_contrib" = "red", "fixed_contrib" = "green", "growing_contrib" = "blue")) +
        theme(legend.position = "right")
    }
    else if(input$facet == "Yes") {
      ggplot(investments_facet(), aes(x = year)) + 
        geom_point(aes(y = values, color = type)) + 
        geom_line(aes(y = values, color = type)) + 
        geom_area(aes(y = values, fill = type, alpha = 0.3)) +
        labs(x = "Year", y = "Annual balance in dollars", title = "Three modes of investing") +
        scale_color_manual(name = "variable", labels = c("no_contrib", "fixed_contrib", "growing_contrib"), values = c("red", "green", "blue")) +
        scale_fill_manual(name = "variable", labels = c("no_contrib", "fixed_contrib", "growing_contrib"), values = c("red", "green", "blue")) + 
        facet_grid(.~type)
    }
  })
  
  output$table <- renderPrint({
    investments()
     })
   
   }

# Run the application 
shinyApp(ui = ui, server = server)

