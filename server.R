library(shiny)
library(shinyjs)
library(ggplot2)

nrall <- nrwon <- lp <- ties <- 0
aa <- c()
userChoices <- ""
startt <- TRUE

wonOrLost <- function(y) {
    if (!is.null(y)) {
        nrall <<- nrall + 1
        userChoices <<- paste(y,userChoices, sep = ", ")
        xind <- sample(1:300, 1, replace = F) %% 3 + 1
        yind <- which(arms == y, arr.ind = T)
        os <-
            paste(y, "of You against ", arms[xind], "of mine")
        if (yind == xind) {
            os <- paste(os,
                        "... Tie! Try Your luck one more time...")
            ties <<- ties + 1
        }
        else {
            if (yind - xind == 1 || yind - xind == -2)  {
                os <- paste(os, ":). You've won!")
                nrwon <<- nrwon + 1
            }
            else {
                os <- paste(os, ":(( You, sore looser!")
            }
            lp <<-
                ifelse(nrall > ties, round(nrwon / (nrall - ties) * 100), 0)
        }
        aa <<- c(aa, lp)
    }
    else { #optional reset with x = NULL
        os <- paste("First input yet to be done!")
        nrall <<- 0
        nrwon <<- 0
        lp <<- 0
        aa <<- c()
        userChoices <<- ""
        ties <<- 0
    }
    list(os, nrall, nrwon, lp, aa, ties, userChoices)
}

shinyServer(function(input, output, session) {
    renderSite <- function(x) {
        dynout <- wonOrLost(x) 
        output$oid1 <- renderPrint({dynout[[1]]})
        output$oid2 <- renderPrint({dynout[[2]]})
        output$oid3 <- renderPrint({dynout[[3]]})
        output$oid4 <- renderPrint({dynout[[4]]})
        output$oid5 <- renderPrint({dynout[[6]]})
        if (!is.null(x)) {
            output$oid6 <- renderPlot({ggplot(ylim = c(0, 100),xlab = "Dies",
                                            ylab = "Percentage won by You") + 
                                        geom_hline(yintercept = 50,size = 5,
                                            col = "grey85") + 
                                        geom_line(aes(x = seq_along(dynout[[5]] - 1), 
                                                      y = dynout[[5]]),colour = "red",
                                                      size = 2) +
                                        ylim(c(0, 100)) + xlab("Dice") + 
                                        ylab("Percentage won by You")
        })
        }
        else
            #empty plot for the first time
            output$oid6 = renderPlot({qplot(ylim = c(0, 100),
                                            xlab = "Dies",ylab = "Percentage won by You"
            ) + geom_hline(yintercept = 50,size = 5,col = "grey85")
            })
        
        #output$oid7 <- renderPrint({paste(dynout[[7]])})
        output$oid7 <- renderPrint({dynout[[7]]})
        updateCheckboxInput(session,
                            inputId = 'userReset',
                            value = FALSE)
        
        updateRadioButtons(session,'userChoice1',
                           choices = arms,
                           selected = character(0))
        
        reset(id = 'sidebarPanel')
        
    }
    
    if (startt) {
        renderSite(NULL)
        startt <- FALSE
    }
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
})