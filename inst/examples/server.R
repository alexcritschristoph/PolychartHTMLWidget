library(shiny)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
  # Expression that generates a histogram. The expression is
  # wrapped in a call to renderPlot to indicate that:
  #
  #  1) It is "reactive" and therefore should be automatically
  #     re-executed when inputs change
  #  2) Its output type is a plot
  make_ggplot = reactive({
    sp <- ggplot(mtcars, aes(x=wt, y=mpg)) +
      geom_point(aes(colour=am))
    gg <- sp +
      facet_grid(vs ~.) +
      ggtitle("This is the title!")
    return(gg)
  })
  output$ggplot1 <- renderPlot({
    make_ggplot()
  })
  output$polychart1 <- renderPolychart({
    gg = make_ggplot()
    polychart(gg_obj = gg,
              data_cols = input$hovervars)
  })
})
