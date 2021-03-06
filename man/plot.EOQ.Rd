% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/plot.EOQ.R
\name{plot.EOQ}
\alias{plot.EOQ}
\title{plot.EOQ}
\usage{
\method{plot}{EOQ}(x, ...)
}
\arguments{
\item{x}{EOQ object.}

\item{...}{Aditional arguments.}
}
\description{
S3 method to plot a EOQ object by using the generic plot function. Plots the scheme of the EOQ model.
}
\examples{
\dontrun{
l <- 520
k <- 10
I <- 0.2
C <- 5

res <- EOQ(l = l, k = k, I = I, C = C)
res
plot(res)

res2 <- EOQd(dis = c(0, 0.05, 0.1), l = 520, k = 10, I = 0.2, q = c(0, 110, 150), c = 5)
plot(res2)

}
}
