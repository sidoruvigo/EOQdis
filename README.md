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

The package includes the following functions:
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


## EOQd(l, k, I, q, dis, c)

### Description [function EOQd] 

This function provides an EOQ with discounts where the units purchased have the same reduction in price.


### Parameters

+ **l**: Demand (per unit of time).
+ **k**: Preparation cost (per order).
+ **I**: Storage cost (per article).
+ **q**: Product quantities where the price changes (Vector of quantities within the discounts given in 'dis' are applied).
+ **dis**: Vector of discounts.
+ **c**: Orginal price of the product. (Price of the product without any discount)

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
c <- 5  # Original price of the product
res2 <- EOQd(dis = dis, l = l, k = k, I = I, q = q, c = c)
res2
```

### Real example

A company needs 500 chairs every month to sell in their online store that costs 15€ each. The supplier negotiates with the company that if they buy more than 50 chairs they offer them a 25% disccount and if they buy more than 100 they offer them a 50% disccount. Making an order costs 10€ and the storage cost is estimated to be 2€ per chair.

```{r, eval=T, fig.align='center',message = FALSE, fig.height = 4, fig.width = 6, warning = FALSE, comment=""}
dis <- c(0, 0.25, 0.5)
q <- c(0, 50, 100)
l <- 500
k <- 10
I <- 2
c <- 15

opt <- EOQd(dis = dis, l = l, k = k, I = I, q = q, c = c)
opt
```


## EOQpd(l, k, I, q, c)

### Description [function EOQpd] 

This function provides an EOQ with discounts where the discount occurs for units purchased when a certain amount is reached.When the amount of order increases, the cost price decreases in the additional units ordered, not in all units.


### Parameters

+ **l**: Demand (per unit of time).
+ **k**: Preparation cost (per order).
+ **I**: Storage cost (per article).
+ **q**: Quantites where the discounts are applied.
+ **c**: Vector of cost of goods.

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

An university needs to buy 5000 markers every year, with a cost per order of 15€ and there is an estimated storage cost of 0.2€. The provider has the following policy: if the customer buys less than 500 markers, the cost per item is 0.75€, if the customer buys more than 500 units, the cost per item is 0.5€. We need to determine the optimal policy

```{r, eval=T, fig.align='center',message = FALSE, fig.height = 4, fig.width = 6, warning = FALSE, comment=""}

l <- 5000
k <- 15
I <- 0.2
c <- c(0.75, 0.5)
q <- c(0, 500)

res3 <- EOQpd(l = l, k = k, I = I, c = c, q = q)
res3
```



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
plot(res2)
plot(res3)

```




### Author(s)

+ Soage González, José Carlos.

Maintainer: José Carlos Soage González (jsoage@uvigo.es)

	


