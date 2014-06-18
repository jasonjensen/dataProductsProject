library(UsingR)
library(ggplot2)
#This is a project for the "Creating Data Products" Coursera course


shinyServer(
  function(input, output) {
    
    #get selected variables for scatterplot
#     selectedData <- reactive({
#       airquality[, c(input$vIn, input$vOut)]
#       # <- 
#     })
    
    myIn <- reactive({
      airquality[, c(input$vIn)]
    })
    
    myOut <- reactive({
      x <- selectedData()
      x[,2]
    })
    
    title <- reactive({
      t <- paste("Scatterplot of", input$vOut, "by", input$vIn, "with linear fit", sep= " ")
    })
    
    
    #run regression on the two variables
    myLM <- reactive({
      lm(as.formula(paste(input$vOut," ~ ",paste(input$vIn,collapse="+"))),data=airquality)
    })
    
   
   #create the scatterplot and add the linear regression line
#     output$myPlot <- renderPlot({
#       plot(selectedData())
#       abline(myLM(), lwd=2)
#     })
   
   output$myggPlot <- renderPlot({   
     #make plot
     p <- ggplot(airquality, aes_string(x=input$vIn, y=input$vOut)) 
     p <- p + geom_point() + geom_smooth(method=lm)
     p <- p + labs(title = title())
     p <- p + theme(plot.title = element_text(lineheight=3, face="bold", color="black", size=20))
     p <- p + theme(axis.title.x= element_text(lineheight=1.5, face="bold", color="black", size = 14))
     p <- p + theme(axis.title.y= element_text(lineheight=1.5, face="bold", color="black", size = 14))
     print(p)
     
   })

   output$regression <- renderText({
     reg <- myLM()
     int <- reg$coefficients[[1]]
     coeff <- reg$coefficients[[2]]
     regText <- paste(input$vOut, "=", coeff, "*", input$vIn, "+", int, sept=" ") 
     regText
   })
  
   
  }
)