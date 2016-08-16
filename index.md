---
title       : The Rock-Paper-Scissors game with R and Shiny
subtitle    : Course Project "Developing Data Products"
author      : D.Dakhno
job         : The Data Science Specialization by Johns Hopkins University
framework   : landslide     # {io2012, html5slides, shower, dzslides, landslide, Slidy}
highlighter : highlight.js  # {highlight.js, prettify, highlight}
hitheme     : tomorrow      # 
widgets     : []            # {mathjax, quiz, bootstrap}
mode        : selfcontained # {standalone, draft}
knit        : slidify::knit2slides

---



  
## The Rock-Paper-Scissors game 
# with R and Shiny  
   
## ..........................
## Author D.Dakhno
## Course Project "Developing Data Products"
## Data Science Specialization by Johns Hopkins University
## Date Tue Aug 16 15:20:13 2016

---

## Introduction and main concepts

The course project is all about building and deploying the Shiny application, accessible 
over Web, dynamic and reactive toward user input. I use the well known simple game to 
build a sample application with a touch of statistics.  
The main features are:
- self-explanatory, responsive user interface ([ui.R] (https://github.com/DDakhno/RockPaperScissors/blob/master/ui.R))
* reactive elements, triggered by user submit
* internal separation of site rendering (shiny) and application logic ([server.R] (https://github.com/DDakhno/RockPaperScissors/blob/master/server.R))
* "session persistence" over iterations

![](fig/img1.png)

---

## Reactivity and rendering

Following elements are used as user input:
```
checkboxInput(inputId = 'userReset', label = "Start again (reset all counters to zero)",value = FALSE ),
radioButtons(inputId = 'userChoice1', label = "", choices = arms,selected = character(0)),
submitButton('Fire away!')
```
Reaction is asynchron and triggered with user submit (button "Fire away!"), so user has a an option 
to change his choice or to start the next iteration with a blanked history.  
Taking into account the non-conventional behavior of the rendering in shiny, I separate strictly 
the rendering itself and application logic
```
shinyServer(function(input, output, session) {
    renderSite <- function(x) {
        dynout <- wonOrLost(x) 
        output$oid1 <- renderPrint({dynout[[1]]})
        output$oid2 <- renderPrint({dynout[[2]]})
        ...
```

---

## Reactivity and rendering

The function *renderSite* is triggered by observer event
```
#reacting at user triggered reset
    observe({
        if (input$userReset == TRUE) {
            renderSite(NULL)
        }
    })
#reacting at user choice
    observe({
        if (!is.null(input$userChoice1)) {
            renderSite(input$userChoice1)
        }
    })
```
It is not the user input itself, rendered to the output, but the return list of 
the function *wonOrLost()*

---

## Logical layer and session persistance

Function *wonOrLost()* takes the actual user choice as a single argument, generates the random 
choice of application player, compares and returns a list of values (actual result as text, overall number 
of attempts, number of user wins, plays won by user in percent, the same in series, number of ties, 
all user choices) 



```r
for (ch in c("Rock","Scissors")) wonOrLost(ch)
```

```r
paste(wonOrLost("Paper"))
[1] "Paper of You against  Paper of mine ... Tie! Try Your luck one more time..."
[2] "3"                                                                          
[3] "0"                                                                          
[4] "0"                                                                          
[5] "c(0, 0, 0)"                                                                 
[6] "3"                                                                          
[7] "Paper, Scissors, Rock, "                                                    
```

## Good luck playing online!





