# FSV_show

Visualize spatial variable genes calculated by spatial_DE

## Usage

``` r
FSV_show(
  results,
  ms_results = NULL,
  size = c(4, 2, 1),
  color = c("blue", "green", "red"),
  sig_alpha = 0.5,
  unsig_alpha = 0.5
)
```

## Arguments

- results:

  results calculated by spatial_DE

- ms_results:

  ms_results calculated by spatial_DE

- size:

  indicate different levels of qval

- color:

  indicate different SV features

- sig_alpha:

  transparency of significant genes

- unsig_alpha:

  transparency of non-significant genes

## Value

ggplot object

## Details

Description of parameters.
