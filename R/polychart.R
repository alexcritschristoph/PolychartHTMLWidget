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
  draw_plot = FALSE

  #Check if dataframe is empty or not empty

  #Check if x and y columns in data frame are
  if (as.character(gg_obj$mapping[['x']]) %in% colnames(gg_data) && as.character(gg_obj$mapping[['y']]) %in% colnames(gg_data))
  {
    draw_plot = TRUE
  }

  if (inherits(gg_obj$facet, 'null'))
  {
    g_facet = "placeholder"
    use_facet = FALSE
  }
  else
  {
    g_facet = toString(unlist(gg_obj$facet[1])$rows)
    use_facet = TRUE
  }
  if (is.null(gg_obj$labels['title'][[1]]))
  {
    title = "placeholder"
    use_title = FALSE
  }
  else
  {
    title = gg_obj$labels['title'][[1]]
    use_title = TRUE
  }

  if (is.null(gg_obj$labels['colour'][[1]]))
  {
    g_color = "placeholder"
    use_color = FALSE
  }
  else
  {
    g_color = gg_obj$labels['colour'][[1]]
    use_color = TRUE
    gg_data$color_val <- palette[as.factor(gg_data[[g_color]])]
  }


  # forward options using x
  x = list(
    data = gg_data,
    facet = g_facet,
    color = g_color,
    title = title,
    x_var = as.character(gg_obj$mapping[['x']]),
    y_var = as.character(gg_obj$mapping[['y']]),
    data_cols = data_cols,
    use_title = use_title,
    use_color = use_color,
    use_facet = use_facet,
    draw_plot = draw_plot
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
polychartOutput <- function(outputId, width = '100%', height = '800px'){
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
