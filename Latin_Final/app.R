#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(shinythemes)
library(shinydashboard)
library(DT)
library(shinyjs)
library(sodium)
library(glue)

# Define UI for application that draws a histogram
ui <- fluidPage(theme = shinytheme("slate"),
                navbarPage(strong("ConJunctus.com", style = "color:gold"),
                           tabPanel("Home",
                                    fluidPage(
                                        titlePanel(h1(strong("Welcome To ConJunctus.com") , align ="center", style = "color:gold")),
                                        hr(),
                                        br(),
                                        h3(strong("What is ConJunctus?"), align = "center"),
                                        h5("Conjunctus is an online platform that aims to connect Classical Latin texts to contemporary culture. Scholars of all levels are invited to interact with one another, and use cutural references and modern language to better understand Roman culture and literature.", align = "center"),
                                        br(),
                                        br(),h3(strong("Why ConJunctus"), align = "center"),
                                        h5("This Platform utilizes what you already know! By connecting Latin with English and modern culture, ConJunctus allows scholars to put the Latin in context. Classical Latin language and themes are connected to pop culture, music, phrases, politics, speeches, viral videos and so much more!", align = "center")
                                    )),
                           tabPanel("Annotation",
                                    titlePanel("Connect Your World to the Roman World"),
                                    br(),
                                    h5("Select an Author and a Text to Get Started"),
                                    sidebarPanel(
                                      sidebarLayout(
                                        varSelectInput(inputId = "choose_author",
                                                    "Author",
                                                    final_data %>% 
                                                      select(-Selections),
                                                    selected = "Catullus",
                                                    FALSE),
                                        selectInput(inputId = "choose_work",
                                                    "Text",
                                                    final_data$Selections,
                                                    selected = "Selection 1",
                                                    FALSE)),
                                      mainPanel(textOutput("the_text"))
                                    )
                           )
                )
)
                               


# Define server logic required to draw a histogram
server <- function(input, output) {
  output$the_text <- renderText({
    
    final_data %>% 
      select(input$choose_author, Selections) %>% 
      filter(Selections == input$choose_work) %>% 
      paste()
    
  })

    
    
    }
    

# Run the application 
runApp(list(ui = ui, server = server), launch.browser = TRUE)