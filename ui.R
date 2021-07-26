#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

# Define UI for application that draws a histogram
shinyUI(fluidPage(
    use_waiter(),
    waiter_preloader(html = spin_flowers(), color = "white"),

    # Application title
    titlePanel("Application title"),

    # Sidebar with a slider input for number of bins
    sidebarLayout(
        sidebarPanel(
            p(
                "There are currently two inputs in this example application. Each input might reflect a scaled subtest score, with a general normal distribution with mean = 0 and sd = 1. Both inputs are fed into a linear model object and used to predict a new value of y, or an estimated vocabulary score (here, mean = 50, sd = 10). For this example. I've just simulated some fake data where there are moderate correlations between each subtest and the outcome, and small correlations between the subtests.The form choice, doesn't do anything right now. "
            ),
           br(),
           
            sliderInput("subtest1", "Subtest 1", value = 0, min = -4, max = 4),
            sliderInput("subtest2", "Subtest 2", value = 0, min = -4, max = 4),
            radioButtons("form", "Choose form",
                         choices = c("Form A" = "A",
                                     "Form B" = "B"),
                         selected = "A",
                         inline = T)
        ),
        # Show a plot of the generated distribution
        mainPanel(
            
            tabsetPanel(
                tabPanel(title = "Results",
                    br(),
                    textOutput("text"),
                    br(),
                    column(align = "center", width = 10, offset = 1,
                        plotOutput("distPlot", height = "300")
                        ),
                    br(),
                    h4("Interpreting This score"),
                    p(shinipsum::random_text(nwords = 100))
                ),
                tabPanel(title = "About this App",
                    fluidRow(
                        h4("About TITLE OF APP"),
                        p(shinipsum::random_text(nwords = 100)),
                        br(),
                        p(shinipsum::random_text(nwords = 100))
                    ),
                    br(),
                    fluidRow(
                        column(width = 3,
                              tags$img(src = "pittcsd.jpeg")
                        ),
                        column(width = 8, offset = 1,
                               h5("Bio Summary. (Note, random image is generated to the left...)"),
                               shinipsum::random_text(nwords = 70)
                               
                       )
                    )
                )
            )
            
        )
    )
))
