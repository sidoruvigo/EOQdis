# EOQdis

## Description [package]

This package implements functions suitable to solve problems of deterministic inventory with and without quantity discounts. 

### Usage

In order to use this package, install it with:
```{r, eval=T, fig.align='center',message = FALSE, fig.height = 4, fig.width = 6, warning = FALSE, comment=""}
install.packages("devtools") # If needed

devtools::install_github("sidoruvigo/EOQdis")
```
Load the library with:  `library("EOQdis")`

The package includes the next functions:
+ EOQ()
+ EOQd()
+ EOQpd()
+ plot.EOQ()

## EOQ(l, k, I, C)

### Description [function EOQ] 

This function implements the basic deterministic EOQ (Economic Order Quantity) model.

### Assumptions for the EOQ model

+ Order arrives instantly.
+ No stockout.
+ Constant rate of demand.

### Parameters

+ **l**: Demand (per unit of time).
+ **k**: Preparation cost (per order).
+ **I**: Storage cost (per article).
+ **C**: Cost of goods (per item).

### Return

A list containing:

+ **Q**: Optimal order quantity.
+ **Z**: Total cost.
+ **T**: Cycle length.
+ **N**: Number of orders.


### Usage

```{r, eval=T, fig.align='center',message = FALSE, fig.height = 4, fig.width = 6, warning = FALSE, comment=""}

library(EOQdis)

l <- 520  # Demand
k <- 10   # Preparation cost
I <- 0.2  # Storage cost per article
C <- 5    # Cost of goods per item

res1 <- EOQ(l = l, k = k, I = I, C = C)
res1

```


## EOQd(dis, l, k , I, q)

### Description [function EOQd] 

This function provides an EOQ with discounts where the units purchased have the same reduction in price.


### Parameters

+ **dis**: Vector of discounts.
+ **l**: Demand (per unit of time).
+ **k**: Preparation cost (per order).
+ **I**: Storage cost (per article).
+ **q**: Vector of quantites within the discounts given in 'dis' are applied.

### Return

A list containing:

+ **Q**: Optimal order quantity.
+ **Z**: Total cost.
+ **T**: Cycle length.
+ **N**: Number of orders.


### Usage

```{r, eval=T, fig.align='center',message = FALSE, fig.height = 4, fig.width = 6, warning = FALSE, comment=""}

dis <- c(0, 0.05, 0.1) # Disccounts: 5% and 10%
l <- 520 # Demand (per unit of time).
k <- 10  # Preparation cost (per order).
I <- 0.2 # Storage cost (per article).
q <- c(0, 110, 150) # 5% when the quantity is greater than 110 and less than 150. For more than 150 units the discoun is 10%
res2 <- EOQd(dis = dis, l = l, k = k, I = I, q = q)
res2
```

### Real example

A company needs 5000 chairs every month to sell in their online store. The supplier negotiates with the company that if they buy more than 500 chairs they offer them a 15% disccount and if they buy more than 1000 they offer them a 50% disccount. Every chair costs 10€, make an order costs 40€ and the storage cost is esimated to be 3€ per chair.

```{r, eval=T, fig.align='center',message = FALSE, fig.height = 4, fig.width = 6, warning = FALSE, comment=""}
dis <- c(0, 0.15, 0.5)
q <- c(0, 500, 1000)
l <- 5000
k <- 15
I <- 3

opt <- EOQd(dis = dis, l = l, k = k, I = I, q = q)
opt
```


## EOQpd(c, q, l , k, I)

### Description [function EOQpd] 

This function provides an EOQ with discounts where the discount occurs for units purchased when a certain amount is reached.


### Parameters

+ **l**: Demand (per unit of time).
+ **k**: Preparation cost (per order).
+ **I**: Storage cost (per article).
+ **c**: Vector of cost of goods.
+ **q**: Quantites where the discounts are applied.

### Return

A list containing:
+ **Q**: Optimal order quantity.
+ **Z**: Total cost.
+ **T**: Cycle length.
+ **N**: Number of orders.


### Usage

```{r, eval=T, fig.align='center',message = FALSE, fig.height = 4, fig.width = 6, warning = FALSE, comment=""}

l <- 50000
k <- 10
I <- 0.25
c <- c(0.6, 0.55)
q <- c(0, 1000)

res3 <- EOQpd(l = 50000, k = 10, I = 0.25, c = c, q = q)
res3
```

### Real example

A company is selling.....



## plot.EOQ(z)

### Description [function plot.EOQ] 

S3 method to plot a EOQ object by using the generic plot function.


### Parameters

+ **x** Object of class EOQ.


### Return

A plot with classical EOQ representation.


### Usage

```{r, eval=T, fig.align='center',message = FALSE, fig.height = 4, fig.width = 6, warning = FALSE, comment=""}

plot(res1)

```

We can also convert the results of the EOQd and EOQpd funcions to class EOQ in order to plot the EOQ graph:

```{r, eval=T, fig.align='center',message = FALSE, fig.height = 4, fig.width = 6, warning = FALSE, comment=""}

class(res2) <- "EOQ"
plot(res2)

```


### Author(s)

+ Soage González, José Carlos.

Maintainer: José Carlos Soage González (jsoage@uvigo.es)

	


