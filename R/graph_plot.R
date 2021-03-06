
#' @title Plot graph for gslope.
#'
#' @param x an object of class `'gslope'`
#'
#' @return Draw graph.
#'
#' @examples
#' w = gslope(as.matrix(mtcars))
#' graph_plot(w)
#' @export

graph_plot <- function(x){
  UseMethod('graph_plot')
}

#' @rdname graph_plot
#' @export
#'
graph_plot.gslope = function(x){
  graph = x$graph
  plot.igraph(graph,layout = layout.circle, vertex.size = 25)
}
