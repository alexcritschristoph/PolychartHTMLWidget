library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  # Application title
  titlePanel("Hello Shiny!"),
  # Sidebar with a slider input for the number of bins
  sidebarLayout(
    sidebarPanel(
      selectInput("hovervars", "Hover Variables",
                  choices = colnames(mtcars),
                  selected = colnames(mtcars),
                  multiple = TRUE)
    ),
    # Show a plot of the generated distribution
    mainPanel(
      polychart::polychartOutput("polychart1")
    )
  )
))
