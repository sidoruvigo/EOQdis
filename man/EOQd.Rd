% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/EOQd.R
\name{EOQd}
\alias{EOQd}
\title{EOQ model with discounts (All units with the same discount)}
\usage{
EOQd(l, k, I, q, dis, c)
}
\arguments{
\item{l}{Demand of the product (per unit of time).}

\item{k}{Preparation cost (per order).}

\item{I}{Storage cost (per article).}

\item{q}{Product quantities where the price changes (Vector of quantities within the discounts given in 'dis' are applied).}

\item{dis}{Vector of discounts.}

\item{c}{Orginal price of the product. (Price of the product without any discount)}
}
\value{
A list containing:
\itemize{
\item{Q: }{Optimal order quantity.}
\item{Z: }{Total cost.}
\item{T: }{Cycle length.}
\item{N: }{Number of orders.}
 }
}
\description{
This function provides an EOQ with discounts where the units purchased have the same reduction in price.
}
\details{
This function implements the deterministic EOQ (Economic Order Quantity) model with discounts where the units purchased have the same reduction in price.
}
\examples{
\donttest{

dis <- c(0, 0.05, 0.1)
l <- 520
k <- 10
I <- 0.2
q <- c(0, 110, 150)
c <- 5
dat <- EOQd(dis = dis, l = l, k = k, I = I, q = q, c = c)
dat
}

}
\author{
José Carlos Soage González \email{jsoage@uvigo.es}
}
