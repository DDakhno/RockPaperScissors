library(shiny)

arms <<- c("Rock","Paper","Scissors")
shinyUI(
        
        pageWithSidebar(
            
        headerPanel("The Rock-Paper-Scissors Game"),
        sidebarPanel(
                useShinyjs(),
                h5('This is a well known rock-paper-scissors game ([]https://en.wikipedia.org/wiki/Rock-paper-scissors), 
enhanced through the power of R and delivered to You with the help of Shiny, another product by RStudio defined by RStudio as “A web application framework for R”.'),
                h4('But this time You are playing against the cold-blooded, merciless Artifical Intelligence, making unpredictable choices with the power of random number generator. No doubt, no jokes, no sympathy.'),
                h3('Your only real survival chance was to avoid playing, but the tip comes obviously to late for You...'),
                h2('So, brace yourself and make a choice of arms now!'),
                h3(''),
                checkboxInput(inputId = 'userReset', label = "Restart session",value = FALSE ),
                p("Iterating, You should select another button, than one from the last time."),
                p("Otherwise Your browser could probably ignore submitting \"the same thing\" twice :(("),
                radioButtons(inputId = "userChoice1", label = "", choices = arms,selected = character(0)),
                submitButton('Fire away!')
        ),
        mainPanel(
                h3('Current result:'),
                h2(textOutput("oid1")),
                h3('Attempts overall:'),
                verbatimTextOutput("oid2"),
                h3('Won by You:'),
                verbatimTextOutput("oid3"),
                h3('Ties:'),
                verbatimTextOutput("oid5"),
               h3('Plotted percentage attempts won by You (ties ignored):'),
               plotOutput("oid6")
        )
))