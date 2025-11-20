# .spatPlot2D_single

Visualize cells according to spatial coordinates

## Usage

``` r
.spatPlot2D_single(
  gobject,
  feat_type = NULL,
  spat_unit = NULL,
  plot_method = "ggplot",
  show_image = FALSE,
  gimage = NULL,
  image_name = NULL,
  spat_loc_name = NULL,
  sdimx = "sdimx",
  sdimy = "sdimy",
  spat_enr_names = NULL,
  cell_color = NULL,
  color_as_factor = TRUE,
  cell_color_code = NULL,
  cell_color_gradient = NULL,
  gradient_midpoint = NULL,
  gradient_style = "divergent",
  gradient_limits = NULL,
  select_cell_groups = NULL,
  select_cells = NULL,
  point_shape = c("border", "no_border", "voronoi"),
  point_size = 3,
  point_alpha = 1,
  point_border_col = "black",
  point_border_stroke = 0.1,
  show_cluster_center = FALSE,
  show_center_label = FALSE,
  center_point_size = 4,
  center_point_border_col = "black",
  center_point_border_stroke = 0.1,
  label_size = 4,
  label_fontface = "bold",
  show_network = FALSE,
  spatial_network_name = "Delaunay_network",
  network_color = NULL,
  network_alpha = 1,
  show_grid = FALSE,
  spatial_grid_name = "spatial_grid",
  grid_color = NULL,
  show_other_cells = TRUE,
  other_cell_color = "lightgrey",
  other_point_size = 1,
  other_cells_alpha = 0.1,
  coord_fix_ratio = 1,
  title = NULL,
  show_legend = TRUE,
  show_axes = NULL,
  legend_text = 8,
  legend_symbol_size = 1,
  background_color = "white",
  vor_border_color = "white",
  vor_max_radius = 200,
  vor_alpha = 1,
  axis_text = 8,
  axis_title = 8,
  theme_param = list(),
  show_plot = NULL,
  return_plot = NULL,
  save_plot = NULL,
  verbose = FALSE,
  save_param = list(),
  default_save_name = "spatPlot2D_single"
)
```

## Arguments

- gobject:

  giotto object

- feat_type:

  feature type (e.g. "rna", "dna", "protein")

- spat_unit:

  spatial unit (e.g. "cell")

- show_image:

  show a tissue background image

- gimage:

  a giotto image

- image_name:

  name of giotto image(s) to plot

- spat_loc_name:

  name of spatial locations

- sdimx:

  x-axis dimension name (default = 'sdimx')

- sdimy:

  y-axis dimension name (default = 'sdimy')

- spat_enr_names:

  character. names of spatial enrichment results to include

- cell_color:

  character. what to color cells by (e.g. metadata col or spatial
  enrichment col)

- color_as_factor:

  logical. convert color column to factor. Discrete colors are used when
  this is TRUE. continuous colors when FALSE.

- cell_color_code:

  character. discrete colors to use. palette to use or named vector of
  colors

- cell_color_gradient:

  character. continuous colors to use. palette to use or vector of
  colors to use (minimum of 2).

- show_cluster_center:

  plot center of selected clusters

- show_center_label:

  plot label of selected clusters

- center_point_size:

  size of center points

- spatial_network_name:

  name of spatial network to use

- network_color:

  color of spatial network

- network_alpha:

  alpha of spatial network

- show_grid:

  show spatial grid

- spatial_grid_name:

  name of spatial grid to use

- grid_color:

  color of spatial grid

- coord_fix_ratio:

  fix ratio between x and y-axis

- vor_border_color:

  border colorr for voronoi plot

- vor_max_radius:

  maximum radius for voronoi 'cells'

- vor_alpha:

  transparency of voronoi 'cells'

- theme_param:

  list of additional params passed to
  [`ggplot2::theme()`](https://ggplot2.tidyverse.org/reference/theme.html)

- show_plot:

  logical. show plot

- return_plot:

  logical. return ggplot object

- save_plot:

  logical. save the plot

- verbose:

  be verbose

- save_param:

  list of saving parameters, see
  [`showSaveParameters`](https://drieslab.github.io/GiottoVisuals/reference/showSaveParameters.md)

- default_save_name:

  default save name for saving, don't change, change save_name in
  save_param

## Value

ggplot

## Details

Description of parameters.

## See also

[`spatPlot3D`](https://drieslab.github.io/GiottoVisuals/reference/spatPlot.md)
