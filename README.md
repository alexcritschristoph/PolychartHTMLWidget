# PolychartHTMLWidget
An HTML Widget wrapper for the Polychart library. 
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
