#' @importFrom ggplot2 "ggplot"
#' @importFrom ggplot2 "geom_tile"
#' @importFrom ggplot2 "scale_fill_gradient"
#' @importFrom ggplot2 "aes"
#' @importFrom ggplot2 "ggtitle"
#' @importFrom ggplot2 "xlab"
#' @importFrom ggplot2 "ylab"
#' @importFrom ggplot2 "theme"
#' @importFrom ggplot2 "labs"
#' @importFrom ggplot2 "element_text"
#' @importFrom GGally "ggcorr"

#' @title Plot precision matrix
#'
#' @param x an object of class `'gslope'`
#' @param col a character, color name. Default "black"
#' @param plt a plot type. Accepts either \code{'precision'}, \code{'covariance'}, \code{'corr'} or \code{'scaled_precision'}. Default \code{'precision'}.
#'
#' @return Prints output on the screen
#'
#' @examples
#' w = gslope(as.matrix(mtcars))
#' plot(w, col = "green", plt = "precision")
#' plot(w, plt = "corr")
#' plot(w,  col = "purple", plt = "scaled_precision")

#' @export

plot <- function(x, plt, col){
  UseMethod('plot')
}

#' @rdname plot
#' @export
#'
plot.gslope = function(x, plt = "scaled_precision", col = "black"){
  
  if(!(plt %in% c("precision", "corr", "scaled_precision", "covariance"))) stop("Plt must be either precision, covariance, corr or scaled_precision")

  if(plt == "scaled_precision") {
    scaled_precision = x$scaled_precision_matrix
    X = colnames(scaled_precision)
    y = X
    data = expand.grid(X = X, Y = y)
    data$value = c(scaled_precision)
    
    result = ggplot(data, mapping = aes(X, Y, fill = value)) + 
      geom_tile() +
      scale_fill_gradient(low = col, high = "white") +
      ggtitle("Scaled precision matrix") +
      ylab("") +
      xlab("") +
      theme(plot.title = element_text(hjust = 0.5))
  }
  
  if(plt == "precision") {
    precision_matrix = x$precision_matrix
    X = colnames(precision_matrix)
    y = X
    data = expand.grid(X = X, Y = y)
    data$value = c(precision_matrix)
    
    result = ggplot(data, mapping = aes(X, Y, fill = value)) + 
      geom_tile() +
      scale_fill_gradient(low = "white", high = col) +
      ggtitle("Precision matrix") +
      ylab("") +
      xlab("") +
      theme(plot.title = element_text(hjust = 0.5))
  }
  if(plt == "corr") {
    result = ggcorr(cov2cor(x$covariance_matrix), 
           nbreaks = 5, 
           low = col, 
           high = col)+
      labs(title = "Correlation matrix") +
      theme(plot.title = element_text(hjust = 0.5))
  }
  
  if(plt == "covariance") {
    covariance = x$covariance_matrix
    X = colnames(covariance)
    y = X
    data = expand.grid(X = X, Y = y)
    data$value = c(covariance)
    
    result = ggplot(data, mapping = aes(X, Y, fill = value)) + 
      geom_tile() +
      scale_fill_gradient(low = "white", high = col) +
      ggtitle("Covariance matrix") +
      ylab("") +
      xlab("") +
      theme(plot.title = element_text(hjust = 0.5))
  }

  result
}



