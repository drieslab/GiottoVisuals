# plotStatDelaunayNetwork

Plots network statistics for a Delaunay network..

## Usage

``` r
plotStatDelaunayNetwork(
  gobject,
  feat_type = NULL,
  spat_unit = NULL,
  method = c("deldir", "delaunayn_geometry", "RTriangle"),
  dimensions = "all",
  maximum_distance = "auto",
  minimum_k = 0,
  options = "Pp",
  Y = TRUE,
  j = TRUE,
  S = 0,
  show_plot = NULL,
  return_plot = NULL,
  save_plot = NULL,
  save_param = list(),
  default_save_name = "plotStatDelaunayNetwork",
  ...
)
```

## Arguments

- gobject:

  giotto object

- feat_type:

  feature type (e.g. "rna", "dna", "protein")

- spat_unit:

  spatial unit (e.g. "cell")

- method:

  package to use to create a Delaunay network

- dimensions:

  which spatial dimensions to use (maximum 2 dimensions)

- maximum_distance:

  distance cuttof for Delaunay neighbors to consider

- minimum_k:

  minimum neigbhours if maximum_distance != NULL

- options:

  (geometry) String containing extra control options for the underlying
  Qhull command; see the Qhull documentation
  (../doc/qhull/html/qdelaun.html) for the available options. (default =
  'Pp', do not report precision problems)

- Y:

  (RTriangle) If TRUE prohibits the insertion of Steiner points on the
  mesh boundary.

- j:

  (RTriangle) If TRUE jettisons vertices that are not part of the final
  triangulation from the output.

- S:

  (RTriangle) Specifies the maximum number of added Steiner points.

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

- ...:

  Other parameters

## Value

giotto object with updated spatial network slot
