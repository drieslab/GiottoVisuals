

#' @name gg_simple_scatter
#' @title gg_simple_scatter
#' @param ggobject ggplot2 object
#' @param data data.frame-like object of information to plot
#' @param x col to plot as x in 'data'
#' @param y col to plot as y in 'data'
#' @param xlab a title for the x axis
#' @param ylab a title for the y axis
#' @param main an overall title for the plot
#' @inheritDotParams ggplot2::aes
#' @param return ggplot object
#' @keywords internal
#' @export
gg_simple_scatter = function(ggobject = NULL, data, x, y, xlab = 'x', ylab = 'y', main = NULL, ...) {
  pl <- gg_input(ggobject)

  aes_args_list = list(x = x, y = y, ...)

  pl <- pl +
    ggplot2::geom_point(data = data, aes_string2(x, y, ...)) +
    ggplot2::theme_classic() +
    ggplot2::labs(x = xlab, y = ylab)

  if(!is.null(main)) {
    pl <- pl + ggplot2::ggtitle(label = main)
  }

  pl
}



