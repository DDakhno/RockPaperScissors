library(shiny)
library(shinyjs)

arms <<- c("Rock","Paper","Scissors")
shinyUI(
        
        pageWithSidebar(
            
        headerPanel("The Rock-Paper-Scissors Game"),
        sidebarPanel(
                useShinyjs(),
                h5('This is a well known rock-paper-scissors game, enhanced through the power of R and delivered to You with the help of Shiny, another product by RStudio defined by RStudio as “A web application framework for R”.'),
                h4('This time You are playing against the cold-blooded, merciless Artifical Intelligence, making unpredictable choices with the power of random number generator. No doubt, no jokes, no sympathy.'),
                h3('Your only real survival chance was to avoid playing, it is obviously to late for You...'),
                h2('So, brace yourself and make a choice of arms now!'),
                h3(''),
                checkboxInput(inputId = 'userReset', label = "Start again (reset all counters to zero)",value = FALSE ),
                p("Sadly, You may not press the same button twice successively."),
                p("You must make another choice, than the last time :(("),
                radioButtons(inputId = 'userChoice1', label = "", choices = arms,selected = character(0)),
                submitButton('Fire away!'),
                h5(a("Dokumentation", href="https://ddakhno.shinyapps.io/RockPaperScissors/readme.html"))

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
               plotOutput("oid6"),
               h3('All choices of You (the latest first):'),
               verbatimTextOutput("oid7")
        )
))