#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(tidyverse)
library(shiny)
library(shinythemes)
library(ggplot2)
library(dplyr)

final_data <- read_rds("data.rds")

# Define UI for application that draws a histogram
ui <- fluidPage(theme = shinytheme("slate"),
                navbarPage(strong("ConJunctus.com", style = "color:gold"),
                           tabPanel("Home",
                                    fluidPage(
                                        titlePanel(h1(strong("Welcome To ConJunctus.com") , align ="center", style = "color:gold")),
                                        hr(),
                                        img(src = "Screen Shot 2020-12-16 at 1.24.52 PM.png", height = 400, width = 400),
                                        br(),
                                        h3(strong("What is ConJunctus?"), align = "center", style = "color:gold"),
                                        h5("Conjunctus is an online platform that aims to connect Classical Latin texts to contemporary culture. Scholars of all levels are invited to interact with one another, and use cutural references and modern language to better understand Roman culture and literature.", align = "center"),
                                        br(),
                                       h5(" Conjunctus is available to scholars of all levels. All you need to get started is a school affiliated email.", align = "center"),
                                        br(),
                                        h3(strong("Why ConJunctus?"), align = "center", style = "color:gold"),
                                        h5("This platform utilizes what you already know! By connecting Latin with English and modern culture, ConJunctus allows scholars to put the Latin in context. Classical Latin language and themes are connected to pop culture, music, phrases, politics, speeches, viral videos and so much more!", align = "center"),
                                        br(),
                                        br(),
                                        h3(strong("Important Notes and Cites Sources"), align = "center", style = "color:gold"),
                                        h5("Conjunctus.com is a uniqe tool intended for academic use. However, the Domain `Conjunctus.com is not registered to the creator of the website. This is only a proposal, and it is intented to be used as a model for a potential learning tool. In creation, thelatinlibrary.com provided the source for the texts. The annotation feature is similiar to genius.com annotation, and the forum is modeled after a reddit webpage. The idea for the tool, however, is unique.", align = "center"),
                                        br(),
                                        h5("There is currently no directory to store annotations, or to comment on forum posts. The library of Latin texts included is not an exhaustive list, and there is certainly a capacity to add more literature and better format the webpage", align = "center"),
                                        br(),
                                        br(),
                                        br()
                                        )),
                           tabPanel("Login/Sign Up",
                                    titlePanel(h1("Login to Keep Track of Your Annotations's Status  and Earn Points Towards Rewards", style  = "color:gold", align = "center")),
                                    tabsetPanel(type = "tabs",
                                                tabPanel("Login",
                                                  textInput(inputId = "usernanme",
                                                            h3("Username", style = "color:gold")),
                                                  br(),
                                                  textInput(inputId = "password",
                                                            h3("Password", style = "color:gold")),
                                                  br(),
                                                  submitButton("Login"),
                                                  helpText(h6(a("Forgot Password?"), style = "color:white"))),
                                                tabPanel("Sign Up",
                                                         textInput(inputId = "usernanme",
                                                                   h3("Username", style = "color:gold")),
                                                         br(),
                                                         textInput(inputId = "passwordsign",
                                                                   h3("Password", style = "color:gold")),
                                                         br(),
                                                         textInput(inputId = "retype",
                                                                   h3("Confirm Password", style = "color:gold")),
                                                         br(),
                                                         textInput(inputId = "email",
                                                                   h3("Email Address", style = "color:gold")),
                                                         helpText("*Note: Conjunctus.com is an academic resource. You must use a school email address (.edu , .gov, etc.) to register", style = "color:white"),
                                                         br(),
                                                         submitButton("Sign Up")
                                                         
                                                         
                                                         )),
                                    
                                             
                           ),
                                    
                                    
                                    
                           
                           
                           
                           
                           tabPanel("Annotation",
                                    fluidPage(
                                      titlePanel(h1(strong("Connect Your World to the Roman World"), align = "center", style = "color:gold")),
                                      hr(),
                                      br(),
                                    h3(strong("Here, on the Annotation Page, you can select words and phrases to annotate with cultural references and English derivatives"), align = "center"),
                                    br(),
                                    br(),
                                    h3(strong("How it Works"), align = "center", style = "color:gold"),
                                    tags$ol(
                                      tags$li("The entire text itself can be annotated, where the overall themes or context can be connected cross-culturally"), 
                                      tags$li("Up to three lines of text can be annotated in order to point out literary devices that have substantial contemporary references"), 
                                      tags$li("In most cases, individual words will be glossed and English derivates will be sources")),
                                    helpText("*All suggested annotations will be reviewed and either confirmed or rejected. Annotations go live daily at noon EST*", align = "right"),
                                    br(),
                                    br(),
                                    hr(),
                                    br(),
                                    h3(strong("Select an Author and a Text to Get Started"), align = "center", style = "color:gold"),
                                    br(),
                                    br(),
                                    sidebarPanel(
                                      sidebarLayout(
                                        selectInput(inputId = "chosen_work",
                                                    "Text",
                                                    final_data$Selections,
                                                    selected = NULL),
                                        varSelectInput(inputId = "chosen_author",
                                                    "Author",
                                                    final_data %>% 
                                                      select(-Selections),
                                                    selected = NULL))),
                                    br(),
                                    br(), 
                                    mainPanel(
                                      textOutput("the_text"),
                                    br(),
                                    br(),
                                    br(),
                                    fluidRow(
                                      column(3, 
                                             textInput("annotate_entire",
                                                       "Annotate the Entire Text",
                                                       value = "Enter text...")),
                                      column(3, 
                                             textInput("annotate_lines",
                                                       "Annotate Up to Three Lines",
                                                       value = "Enter text...")),
                                      column(4, 
                                             textInput("annotate_words",
                                                       "Annotate Words for Derivatives",
                                                       value = "Enter text..."))
                                    ),
                                    submitButton("Submit")),
                                    )
                           ),
                          tabPanel("Forum",
                                   titlePanel(h1(strong("See How Other Scholars are Connecting Cross-Culturally!"), align = "center", style = "color:gold")),
                                   hr(),
                                   br(),
                                   fluidPage(
                                     dashboardPage(skin = "yellow",
                                       dashboardHeader(title = "Community Forum"),
                                       dashboardSidebar(),
                                       dashboardBody(
                                           box(width = 25, column(12, align = "center"),
                                               dateInput(inputId = "date",
                                                         h3("Date", style = "color:black"),
                                                         value = "2020-12-18")),
                                           textAreaInput(inputId = "forum",
                                                         h3("Add a Message", style = "color:black"),
                                                         "Type Message Here!"),
                                           submitButton("Submit"))
                                     )))
                )
)

                               


# Define server logic required to draw a histogram
server <- function(input, output) {
  output$the_text <- renderText({
   paste(
     final_data %>% 
      select(input$chosen_author, Selections) %>% 
      filter(Selections == input$chosen_work))
      
  })
  
output$colleseum <- renderImage({
  img(src("Screen Shot 2020-12-16 at 1.24.52 PM.png"),
      deleteFile = FALSE)
  
})
    
    
    }
    

# Run the application 
runApp(list(ui = ui, server = server), launch.browser = TRUE)