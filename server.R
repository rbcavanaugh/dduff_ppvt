#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {

    list_values <- reactiveValues()
    
        observe({
            
        list_values$subtest1 <- input$subtest1
        list_values$subtest2 <- input$subtest2
        list_values$predictions <- get_vocab_estimate(values = list_values)
        
        })
    
    output$text <- renderText({
        
        tmp = paste0("The estimated vocabulary score is ",
                     round(list_values$predictions$fit,2),
                     "; 95% Confidence Interval: [",
                     round(list_values$predictions$lwr,2),
                     ", ",
                     round(list_values$predictions$upr,2),
                     "]."
                     )
    })
    
    output$distPlot <- renderPlot({
        
        get_vocab_plot(preds = list_values$predictions)
        
    })


})
