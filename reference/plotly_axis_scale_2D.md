# plotly_axis_scale_2D

adjust the axis scale in 2D plotly plot

## Usage

``` r
plotly_axis_scale_2D(
  cell_locations,
  sdimx = NULL,
  sdimy = NULL,
  mode = c("cube", "real", "custom"),
  custom_ratio = NULL
)
```

## Arguments

- cell_locations:

  spatial_loc in giotto object

- sdimx:

  x axis of cell spatial location

- sdimy:

  y axis of cell spatial location

- mode:

  axis adjustment mode

- custom_ratio:

  set the ratio artificially

## Value

edges in spatial grid as data.table()

## Examples

``` r
my_cell_locations <- data.frame(x = sample(10), y = sample(10))
plotly_axis_scale_2D(my_cell_locations)
#> [[1]]
#> [1] 1
#> 
#> [[2]]
#> [1] 1
#> 
```
