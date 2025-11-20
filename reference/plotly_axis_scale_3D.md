# plotly_axis_scale_3D

adjust the axis scale in 3D plotly plot

## Usage

``` r
plotly_axis_scale_3D(
  cell_locations,
  sdimx = NULL,
  sdimy = NULL,
  sdimz = NULL,
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

- sdimz:

  z axis of cell spatial location

- mode:

  axis adjustment mode

- custom_ratio:

  set the ratio artificially

## Value

edges in spatial grid as data.table()

## Examples

``` r
my_cell_locations <- data.frame(
    x = sample(10), y = sample(10),
    z = sample(10)
)
plotly_axis_scale_3D(my_cell_locations)
#> [[1]]
#> [1] 1
#> 
#> [[2]]
#> [1] 1
#> 
#> [[3]]
#> [1] 1
#> 
```
