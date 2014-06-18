library(shiny)

data <- airquality

shinyUI(pageWithSidebar(
  headerPanel("Visual regression of Air Quality Dataset"),
  sidebarPanel(
    p("This app allows the user to visually explore linear relationships among 
      variables in the New York Air Quality data set."),
    p("Please choose your outcome and predictor variables from the drop-down lists."),
    selectInput("vOut", "Outcome:",
      names(airquality), 
      selected = "Ozone", multiple = FALSE, selectize = TRUE),
    selectInput("vIn", "Predictor:",
                names(airquality), 
                selected = "Month", multiple = FALSE, selectize = TRUE),
    tags$b('More about the data:'),
    tags$p('Daily readings of the following air quality values for May 1, 1973 (a Tuesday) to September 30, 1973.'),
    tags$ul(
      tags$li(tags$b('Ozone:'), ' Mean ozone in parts per billion from 1300 to 1500 hours at Roosevelt Island'),
      tags$li(tags$b('Solar.R:'), ' Solar radiation in Langleys in the frequency band 4000-7700 Angstroms from 0800 to 1200 hours at Central Park'),
      tags$li(tags$b('Wind:'), ' Average wind speed in miles per hour at 0700 and 1000 hours at LaGuardia Airport'),
      tags$li(tags$b('Temp:'), ' Maximum daily temperature in degrees Fahrenheit at La Guardia Airport.')
    
    )
  ),
  mainPanel(
    #plotOutput('myPlot'),
    plotOutput('myggPlot'),
    tags$h3('Regression Model'),
    verbatimTextOutput('regression')
  )
))


