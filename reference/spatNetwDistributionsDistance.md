# Plot spatial distance distribution

This function return histograms displaying the distance distribution for
each spatial k-neighbor

## Usage

``` r
spatNetwDistributionsDistance(
  gobject,
  spat_unit = NULL,
  spatial_network_name = "spatial_network",
  hist_bins = 30,
  test_distance_limit = NULL,
  ncol = 1,
  show_plot = NULL,
  return_plot = NULL,
  save_plot = NULL,
  save_param = list(),
  default_save_name = "spatNetwDistributionsDistance"
)
```

## Arguments

- gobject:

  giotto object

- spat_unit:

  spatial unit (e.g. "cell")

- spatial_network_name:

  name of spatial network

- hist_bins:

  number of binds to use for the histogram

- test_distance_limit:

  effect of different distance threshold on k-neighbors

- ncol:

  number of columns to visualize the histograms in

- show_plot:

  logical. show plot

- return_plot:

  logical. return ggplot object

- save_plot:

  logical. save the plot

- save_param:

  list of saving parameters, see
  [`showSaveParameters`](https://drieslab.github.io/GiottoVisuals/reference/showSaveParameters.md)

- default_save_name:

  default save name for saving, don't change, change save_name in
  save_param

## Value

ggplot plot
