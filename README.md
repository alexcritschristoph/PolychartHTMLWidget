# PolychartHTMLWidget
An HTML Widget wrapper for the Polychart library. Creates a dynamic JavaScript scatterplot directly from a ggplot2 object which can be viewed in RStudio, included in a Shiny.R app, or included ina  static Rmd.
![scatterplot](http://i.imgur.com/4yOPGT1.png)

Takes a GGPLOT2 object as input.



Usage:
library(polychart);

data = mtcars
x = 'wt'
y = 'mpg'
group = 'cyl'

library(ggplot2)

sp <- ggplot(mtcars, aes(x=wt, y=mpg)) + geom_point(shape=1, aes(colour=am)) 

gg <- sp + facet_wrap(~ vs) + ggtitle("This is the title!")

polychart(gg,data_cols=c("drat","hp","qsec"))


For an example of usage with Shiny, run inst/examples/server.R.
