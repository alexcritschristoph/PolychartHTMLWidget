#' Create polychart-based scatter plot
#'
#' More info here.
#'
#' @importFrom htmlwidgets createWidget
#'
#' @export
polychart <- function(gg_obj, width = NULL, height = NULL, data_cols=c(0,1), palette=c("#3182bd","#fd8d3c","#74c476")) {

  palette = as.factor(palette)

  #Get data
  gg_data = gg_obj$data
  g_facet = toString(unlist(gg_obj$facet[1])$rows)

  title = gg_obj$labels['title'][[1]]
  #Get color
  g_color = gg_obj$labels['colour'][[1]]

  gg_data$color_val <- palette[as.factor(gg_data[[g_color]])]

  # forward options using x
  x = list(
    data = gg_data,
    facet = g_facet,
    color = g_color,
    title = title,
    x_var = gg_obj$labels['x'][[1]],
    y_var = gg_obj$labels['y'][[1]],
    data_cols = data_cols
  )

  # create widget
  createWidget(
    name = 'polychart',
    x,
    width = width,
    height = height,
    package = 'polychart'
  )
}
#' Widget output function for use in Shiny
#'
#' @importFrom htmlwidgets shinyWidgetOutput
#' @export
polychartOutput <- function(outputId, width = '100%', height = '400px'){
  shinyWidgetOutput(outputId, 'polychart', width, height, package = 'polychart')
}
#' Widget render function for use in Shiny
#'
#' @importFrom htmlwidgets shinyRenderWidget
#' @export
renderPolychart <- function(expr, env = parent.frame(), quoted = FALSE) {
  if (!quoted) { expr <- substitute(expr) } # force quoted
  shinyRenderWidget(expr, polychartOutput, env, quoted = TRUE)
}
