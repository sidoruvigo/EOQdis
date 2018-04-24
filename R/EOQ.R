#' @title EOQ model
#'
#' @description This functions provides the results of the well-known deterministic EOQ (Economic Order Quantity model)
#'
#' @param l Demand (per unit of time).
#' @param k Preparation cost (per order).
#' @param I Storage cost (per article).
#' @param C Cost of goods (per item).
#'
#' @section Assumptions:
#' \itemize{
#' \item{Order arrives instantly.}
#' \item{No stockout.}
#' \item{Constant rate of demand.}
#' }
#'
#' @details This function implements the basic deterministic EOQ (Economic Order Quantity) model.
#'
#' @return  A list containing:
#' \itemize{
#' \item{Q: }{Optimal order quantity.}
#' \item{Z: }{Total cost.}
#' \item{T: }{Cycle length.}
#' \item{N: }{Number of orders.}
#' }
#'
#'
#' @author José Carlos Soage González \email{jsoage@@uvigo.es}
#'
#' @examples
#' \donttest{
#' l <- 520  # Demand
#' k <- 10   # Preparation cost
#' I <- 0.2  # Storage cost per article
#' C <- 5    # Cost of goods per item
#'
#' dat <- EOQ(l = l, k = k, I = I, C = C)
#' dat
#' plot(dat)
#'
#' }
#'
#' @export
EOQ <- function(l, k, I, C){
  if (l < 0) stop("'l' must be >= 0")
  if (k < 0) stop("'k' must be >= 0")
  if (I < 0) stop("'I' must be >= 0")
  if (C < 0) stop("'C' must be >= 0")
  cat("Call:", "\n")
  print(match.call())
  df <- data.frame(Q = NA, Z = NA, T = NA, N = NA)
  IC <- I * C
  Q <- sqrt((2 * k * l) / (IC))
  Z <- C * l + sqrt(2 * l * k * IC)
  T <- Q/l
  N <- 1/T
  df[1, ] <- c(round(Q, 3), round(Z, 3), round(T, 3), round(N, 3))
  x <- list(Q = df$Q, Z = df$Z, T = df$T, N = df$N)
  class(x) <- c("list", "EOQ")
  x
}


