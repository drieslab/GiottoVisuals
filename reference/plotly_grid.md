# plotly_grid

provide grid segment to draw in plot_ly()

## Usage

``` r
plotly_grid(
  spatial_grid,
  x_start = "x_start",
  y_start = "y_start",
  x_end = "x_end",
  y_end = "y_end"
)
```

## Arguments

- spatial_grid:

  spatial_grid in giotto object

- x_start:

  default to "x_start"

- y_start:

  default to "y_start"

- x_end:

  default to "x_end"

- y_end:

  default to "y_end"

## Value

edges in spatial grid as data.table()

## Examples

``` r
g <- GiottoData::loadGiottoMini("visium", verbose = FALSE)

library(GiottoClass)
g <- createSpatialGrid(
    gobject = g,
    sdimx_stepsize = 400,
    sdimy_stepsize = 400,
    minimum_padding = 0
)

my_spatial_grid <- getSpatialGrid(g)
#> The grid name was not specified, default to the first: "spatial_grid"

plotly_grid(my_spatial_grid)
#>     edge_id     x     y x_end y_end
#>       <int> <num> <num> <num> <num>
#>  1:       1  2955 -5605  2955 -2405
#>  2:       2  3355 -5605  3355 -2405
#>  3:       3  3755 -5605  3755 -2405
#>  4:       4  4155 -5605  4155 -2405
#>  5:       5  4555 -5605  4555 -2405
#>  6:       6  4955 -5605  4955 -2405
#>  7:       7  5355 -5605  5355 -2405
#>  8:       8  5755 -5605  5755 -2405
#>  9:       9  6155 -5605  6155 -2405
#> 10:      10  6555 -5605  6555 -2405
#> 11:      11  2955 -5605  6555 -5605
#> 12:      12  2955 -5205  6555 -5205
#> 13:      13  2955 -4805  6555 -4805
#> 14:      14  2955 -4405  6555 -4405
#> 15:      15  2955 -4005  6555 -4005
#> 16:      16  2955 -3605  6555 -3605
#> 17:      17  2955 -3205  6555 -3205
#> 18:      18  2955 -2805  6555 -2805
#> 19:      19  2955 -2405  6555 -2405
```
