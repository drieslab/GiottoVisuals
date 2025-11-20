# gg_simple_scatter

gg_simple_scatter

## Usage

``` r
gg_simple_scatter(
  ggobject = NULL,
  data,
  x,
  y,
  xlab = "x",
  ylab = "y",
  main = NULL,
  ...
)
```

## Arguments

- ggobject:

  ggplot2 object

- data:

  data.frame-like object of information to plot

- x:

  col to plot as x in 'data'

- y:

  col to plot as y in 'data'

- xlab:

  a title for the x axis

- ylab:

  a title for the y axis

- main:

  an overall title for the plot

- ...:

  Arguments passed on to
  [`ggplot2::aes`](https://ggplot2.tidyverse.org/reference/aes.html)

  :   

## Value

a ggplot object

## Examples

``` r
x <- data.frame(x = rnorm(10), y = rnorm(10))
gg_simple_scatter(data = x, x = "x", y = "y")

```
