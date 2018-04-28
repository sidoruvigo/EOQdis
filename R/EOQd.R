#' @title EOQ model with discounts (All units with the same discount)
#'
#' @description This function provides an EOQ with discounts where the units purchased have the same reduction in price.
#'
#' @param dis Vector of discounts.
#' @param l Demand of the product (per unit of time).
#' @param k Preparation cost (per order).
#' @param I Storage cost (per article).
#' @param q Product quantities where the price changes (Vector of quantities within the discounts given in 'dis' are applied).
#' @param c Orginal price of the product. (Price of the product without any discount)
#'
#' @details This function implements the deterministic EOQ (Economic Order Quantity) model with discounts where the units purchased have the same reduction in price.
#
#' @return  A list containing:
#' \itemize{
#' \item{Q: }{Optimal order quantity.}
#' \item{Z: }{Total cost.}
#' \item{T: }{Cycle length.}
#' \item{N: }{Number of orders.}
#'  }
#'
#'
#' @author José Carlos Soage González \email{jsoage@@uvigo.es}
#'
#' @examples
#' \donttest{
#'
#' dis <- c(0, 0.05, 0.1)
#' l <- 520
#' k <- 10
#' I <- 0.2
#' c <- 5
#' q <- c(0, 110, 150)
#' dat <- EOQd(dis = dis, l = l, k = k, I = I, q = q, c = c)
#' dat
#' }
#'
#' @export
EOQd <- function(l, k, I, q, dis, c) {
  if (any(dis < 0)) stop("All 'dis' must be >= 0")
  if (l < 0) stop("'l' must be >= 0")
  if (k < 0) stop("'k' must be >= 0")
  if (I < 0) stop("'I' must be >= 0")
  if (any(dis>=1)) stop("Every 'dis' must be <=1")
  if (c <= 0) stop("'c' must be > 0")

  cat("Call:", "\n")
  print(match.call())
  C <- vector("list", length = length(dis))

  for (i in 1:length(dis)) {
    C[i] <- c * (1 - dis[i])
  }

  # Step 1
  j <- length(C)#; print(j)
  Qm <- sqrt((2 * k * l) / (I * as.numeric(C[j]))) #; print(Qm)

  # Step 2
  if (Qm >= q[j]) {
    df <- data.frame(Q = NA, Z = NA, T = NA, N = NA)
    T <- Qm / l
    N <- 1/T
    df[1, ] <- c(Qm, Zmin, T, N)
    x <- list(Q = df$Q, Z = df$Z, T = df$T, N = df$N)
    class(x) <- c("list", "EOQ")
    x

  } else { # Qm is not feasible
    Qmin <- q[j]
    Zmin <- as.numeric(C[j]) *  l + k * l / Qmin + I * as.numeric(C[j])* Qmin / 2 #; print(Zmin)

    # Step 3
    j <- j - 1
    Qj <- sqrt((2 * k * l) / (I * as.numeric(C[j]))) #; print(Qj)

    # Step 4
    if  (Qj >= q[j] & Qj < q[j + 1]) { # Qj is feasible
      Zj <- as.numeric(C[j]) * l + k * l / Qj + I * as.numeric(C[j])* Qj / 2 #; print(Zj)

      if (Zmin > Zj) {
        df <- data.frame(Q = NA, Z = NA, T = NA, N = NA)
        T <- Qj / l
        N <- 1/T
        df[1, ] <- c(Qj, Zmin, T, N)
        x <- list(Q = df$Q, Z = df$Z, T = df$T, N = df$N)
        class(x) <- c("list", "EOQ")
        x
      } else {
        df <- data.frame(Q = NA, Z = NA, T = NA, N = NA)
        T <- Qmin / l
        N <- 1/T
        df[1, ] <- c(Qmin, Zmin, T, N)
        x <- list(Q = df$Q, Z = df$Z, T = df$T, N = df$N)
        class(x) <- c("list", "EOQ")
        x
      }
    } else { # Qj is not feasible
      Zj <- as.numeric(C[j]) * l + k * l / Qj + I * as.numeric(C[j])* Qj / 2 #; print(Zj)

      if (Zj < Zmin) {
        Zmin <- Zj
        Qmin <- Qj
      }
    }
  }

  # Step 5

    while (j >= 2) {

      # Step 3
      j <- j - 1
      Qj <- sqrt((2 * k * l) / (I * as.numeric(C[j]))) #; print(Qj)

      # Step 4
      if  (Qj >= q[j] & Qj < q[j + 1]) {
        Zj <- as.numeric(C[j]) * l + k * l / Qj + I * as.numeric(C[j])* Qj / 2 #; print(Zj)

        if (Zmin > Zj) {
          df <- data.frame(Q = NA, Z = NA, T = NA, N = NA)
          T <- Qj / l
          N <- 1/T
          df[1, ] <- c(Qj, Zmin, T, N)
          x <- list(Q = df$Q, Z = df$Z, T = df$T, N = df$N)
          class(x) <- c("list", "EOQ")
          x
        } else {
          df <- data.frame(Q = NA, Z = NA, T = NA, N = NA)
          T <- Qmin / l
          N <- 1/T
          df[1, ] <- c(Qmin, Zmin, T, N)
          x <- list(Q = df$Q, Z = df$Z, T = df$T, N = df$N)
          class(x) <- c("list", "EOQ")
          x
        }
      } else {
        Zj <- as.numeric(C[j]) * l + k * l / Qj + I * as.numeric(C[j])* Qj / 2 #; print(Zj)

        if (Zj < Zmin) {
          Zmin <- Zj
          Qmin <- Qj
        }
      }
    }

  if (j == 1) {
    df <- data.frame(Q = NA, Z = NA, T = NA, N = NA)
    T <- Qmin/l
    N <- 1/T
    df[1, ] <- c(Qmin, Zmin, T, N)
    x <- list(Q = df$Q, Z = df$Z, T = df$T, N = df$N)
    class(x) <- c("list", "EOQ")
    x
  }
}


