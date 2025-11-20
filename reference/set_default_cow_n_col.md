# Set default ncols in plotting grid

Determine a default cow_n_col param value for cowplot based on the
number of items to plot.

## Usage

``` r
set_default_cow_n_col(cow_n_col = NULL, nr_plots)
```

## Arguments

- cow_n_col:

  number of columns for cowplot to use. A default number is calculated
  if `NULL` is passed.

- nr_plots:

  number of plots to use with cowplot

## Value

numeric

## Examples

``` r
set_default_cow_n_col(nr_plots = 4)
#> [1] 2
```
