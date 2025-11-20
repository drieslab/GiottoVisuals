# spatNetwDistributionsKneighbors

This function returns a histogram displaying the number of k-neighbors
distribution for each cell

## Usage

``` r
spatNetwDistributionsKneighbors(
  gobject,
  spat_unit = NULL,
  spatial_network_name = "spatial_network",
  hist_bins = 30,
  show_plot = NULL,
  return_plot = NULL,
  save_plot = NULL,
  save_param = list(),
  default_save_name = "spatNetwDistributionsKneighbors"
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
