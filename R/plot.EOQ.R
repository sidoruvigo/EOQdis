#' S3 method to plot a EOQ object by using the generic plot function. Plots the scheme of the EOQ model.
#'
#' @title plot.EOQ
#'
#' @param x EOQ object.
#' @param ... Aditional arguments.
#'
#' @examples
#' \dontrun{
#' l <- 520
#' k <- 10
#' I <- 0.2
#' C <- 5
#'
#' res <- EOQ(l = l, k = k, I = I, C = C)
#' res
#' plot(res)
#'
#' res2 <- EOQd(dis = c(0, 0.05, 0.1), l = 520, k = 10, I = 0.2, q = c(0, 110, 150), c = 5)
#' plot(res2)
#'
#' }
#' @export
plot.EOQ <- function(x, ...) {

  ggplot2::ggplot(NULL) +
    ggplot2::geom_segment(ggplot2::aes(x = 0, y = x$Q, xend = x$T, yend = 0,
                     colour = "segment"), size = 2)+
    ggplot2::geom_segment(ggplot2::aes(x = x$T, y = 0, xend = x$T, yend = x$Q,
                     colour = "segment"), size = 2) +
    ggplot2::geom_segment(ggplot2::aes(x = x$T, y = x$Q, xend = 2 * x$T, yend = 0,
                     colour = "segment"), size = 2)+
    ggplot2::geom_segment(ggplot2::aes(x = 2 * x$T, y = 0, xend = 2 * x$T, yend = x$Q,
                     colour = "segment"), size = 2) +
    ggplot2::geom_segment(ggplot2::aes(x = 2 * x$T, y = x$Q, xend = 3 * x$T, yend =  0,
                     colour = "segment"), size = 2)+
    ggplot2::guides(fill = FALSE) +

    ggplot2::scale_x_continuous (expand = c(0, 0)) +
    ggplot2::scale_y_continuous(expand = c(0, 0)) +
    ggplot2::theme(text = ggplot2::element_text(size = 15),
          plot.title = ggplot2::element_text(size = 14, vjust = 1.5, hjust = 0.5),
          axis.title.x = ggplot2::element_blank(),
          axis.title.y = ggplot2::element_blank(),
          panel.background = ggplot2::element_rect(fill = "white"),
          axis.line = ggplot2::element_line(colour = "black", size = 1),
          legend.position = "none")
}
