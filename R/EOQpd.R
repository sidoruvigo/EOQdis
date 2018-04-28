#' @title EOQ model with progressive discount for amounts.
#'
#' @description This function provides an EOQ with discounts where the discount occurs for units purchased when a certain amount is reached. When the amount of
#' order increases, the cost price decreases in the additional units ordered, not in all units.
#'
#' @param l Demand of the product (per unit of time).
#' @param k Preparation cost (per order).
#' @param I Storage cost (per article).
#' @param c Vector of costs of the good.
#' @param q Product quantities where the price changes. Vector of quantites within the discounts are applied.
#'
#' @details This function implements the deterministic EOQ (Economic Order Quantity) model with discounts where the discount occurs for units purchased when a certain amount is reached.
#
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
#'
#' l <- 50000
#' k <- 10
#' I <- 0.25
#' c <- c(0.6, 0.55)
#' q <- c(0, 1000)
#' dat <- EOQpd(l = 50000, k = 10, I = 0.25, c = c, q = q)
#' dat
#' }
#'
#' @export
EOQpd <- function(l, k, I, q, c) {
  if (any(c < 0)) stop("'c' must be >= 0")
  if (any(q < 0)) stop("'q' must be >= 0")
  if (l < 0) stop("'l' must be >= 0")
  if (k < 0) stop("'k' must be >= 0")
  if (I < 0) stop("'I' must be >= 0")
  cat("Call:", "\n")
  print(match.call())

  # Step 1
  Q <- vector("list", length = length(c))
  R <- vector("list", length = length(c))

  for (i in 2:length(Q)) {
    R[i] <- c[1] * (q[i] - q[i - 1])
  }
  R[1] <- 0

  for (j in 1:length(Q)) {
    Q[j] <- sqrt((2 * (as.numeric(R[j]) - as.numeric(c[j]) * as.numeric(q[j]) + k) * l) / (as.numeric(I * as.numeric(c[j]))))
  }

  # Step 2
  fsb <- which(Q > q)
  ji <- fsb # Factibles

  Z <- as.numeric(0)
    for (i in 1:length(ji)) {
         Z[i] <- c[i] * l + (as.numeric(R[i]) - c[i] * q[i] + k) * l / as.numeric(Q[i]) + I * c[i] + as.numeric(Q[i])/2 + I /2 * (as.numeric(R[i]) - c[i] * q[i])
    }

  min <- which.min(Z)
  Zopt <- min(Z)
  Qopt <- as.numeric(Q[min])
  df <- data.frame(Q = NA, Z = NA, T = NA, N = NA)
  T <- Qopt/l
  N <- 1/T
  df[1, ] <- c(Qopt, Zopt, T, N)
  x <- list(Q = df$Q, Z = df$Z, T = df$T, N = df$N)
  class(x) <- c("list", "EOQ")
  x
}

