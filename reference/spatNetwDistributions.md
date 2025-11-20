# spatNetwDistributions

This function return histograms displaying the distance distribution for
each spatial k-neighbor

## Usage

``` r
spatNetwDistributions(
  gobject,
  spat_unit = NULL,
  spatial_network_name = "spatial_network",
  distribution = c("distance", "k_neighbors"),
  hist_bins = 30,
  test_distance_limit = NULL,
  ncol = 1,
  show_plot = NULL,
  return_plot = NULL,
  save_plot = NULL,
  save_param = list(),
  default_save_name = "spatNetwDistributions"
)
```

## Arguments

- gobject:

  giotto object

- spat_unit:

  spatial unit (e.g. "cell")

- spatial_network_name:

  name of spatial network

- distribution:

  show the distribution of cell-to-cell distance or number of k
  neighbors

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

## Details

The **distance** option shows the spatial distance distribution for each
nearest neighbor rank (1st, 2nd, 3th, ... neighbor). With this option
the user can also test the effect of a distance limit on the spatial
network. This distance limit can be used to remove neighbor cells that
are considered to far away.  
The **k_neighbors** option shows the number of k neighbors distribution
over all cells.
