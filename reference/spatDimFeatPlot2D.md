# spatDimFeatPlot2D

Visualize cells according to spatial AND dimension reduction coordinates
in ggplot mode

## Usage

``` r
spatDimFeatPlot2D(
  gobject,
  spat_unit = NULL,
  feat_type = NULL,
  show_image = FALSE,
  gimage = NULL,
  image_name = NULL,
  largeImage_name = NULL,
  expression_values = c("normalized", "scaled", "custom"),
  plot_alignment = c("vertical", "horizontal"),
  feats,
  order = TRUE,
  dim_reduction_to_use = "umap",
  dim_reduction_name = "umap",
  dim1_to_use = 1,
  dim2_to_use = 2,
  dim_point_shape = c("border", "no_border"),
  dim_point_size = 1,
  dim_point_alpha = 1,
  dim_point_border_col = "black",
  dim_point_border_stroke = 0.1,
  show_NN_network = FALSE,
  show_spatial_network = FALSE,
  dim_network_color = "gray",
  nn_network_to_use = "sNN",
  network_name = "sNN.pca",
  dim_edge_alpha = NULL,
  scale_alpha_with_expression = FALSE,
  sdimx = "sdimx",
  sdimy = "sdimy",
  spatial_network_name = "Delaunay_network",
  spatial_network_color = NULL,
  show_spatial_grid = FALSE,
  grid_color = NULL,
  spatial_grid_name = "spatial_grid",
  spat_point_shape = c("border", "no_border", "voronoi"),
  spat_point_size = 1,
  spat_point_alpha = 1,
  spat_point_border_col = "black",
  spat_point_border_stroke = 0.1,
  spat_edge_alpha = NULL,
  cell_color_gradient = NULL,
  gradient_midpoint = NULL,
  gradient_style = c("divergent", "sequential"),
  gradient_limits = NULL,
  cow_n_col = NULL,
  cow_rel_h = 1,
  cow_rel_w = 1,
  cow_align = "h",
  show_legend = TRUE,
  legend_text = 10,
  dim_background_color = "white",
  spat_background_color = "white",
  vor_border_color = "white",
  vor_max_radius = 200,
  vor_alpha = 1,
  axis_text = 8,
  axis_title = 8,
  show_plot = NULL,
  return_plot = NULL,
  save_plot = NULL,
  save_param = list(),
  default_save_name = "spatDimFeatPlot2D"
)
```

## Arguments

- gobject:

  giotto object

- spat_unit:

  spatial unit (e.g. "cell")

- feat_type:

  feature type (e.g. "rna", "dna", "protein")

- show_image:

  show a tissue background image

- gimage:

  a giotto image

- image_name:

  name of a giotto image or multiple images with group_by

- largeImage_name:

  deprecated. Use `image_name`

- expression_values:

  feat expression values to use

- plot_alignment:

  direction to align plot

- feats:

  features to show

- order:

  order points according to feature expression

- dim_reduction_to_use:

  character. dimension reduction to use

- dim_reduction_name:

  character. dimension reduction name

- dim1_to_use:

  numeric. dimension to use on x-axis

- dim2_to_use:

  numeric. dimension to use on y-axis

- dim_point_shape:

  point with border or not (border or no_border)

- dim_point_size:

  size of points in dim. reduction space

- dim_point_alpha:

  transparancy of point in dim. reduction space

- dim_point_border_col:

  border color of points in dim. reduction space

- dim_point_border_stroke:

  border stroke of points in dim. reduction space

- show_NN_network:

  logical. Show underlying NN network

- show_spatial_network:

  show spatial network

- dim_network_color:

  color of NN network

- nn_network_to_use:

  character. type of NN network to use (kNN vs sNN)

- network_name:

  name of NN network to use, if show_NN_network = TRUE

- dim_edge_alpha:

  dim reduction plot: column to use for alpha of the edges

- scale_alpha_with_expression:

  scale expression with ggplot alpha parameter

- sdimx:

  spatial x-axis dimension name (default = 'sdimx')

- sdimy:

  spatial y-axis dimension name (default = 'sdimy')

- spatial_network_name:

  name of spatial network to use

- spatial_network_color:

  color of spatial network

- show_spatial_grid:

  show spatial grid

- grid_color:

  color of spatial grid

- spatial_grid_name:

  name of spatial grid to use

- spat_point_shape:

  spatial points with border or not (border or no_border)

- spat_point_size:

  spatial plot: point size

- spat_point_alpha:

  transparency of spatial points

- spat_point_border_col:

  color of border around points

- spat_point_border_stroke:

  stroke size of border around points

- spat_edge_alpha:

  edge alpha

- cell_color_gradient:

  character. continuous colors to use. palette to use or vector of
  colors to use (minimum of 2).

- gradient_midpoint:

  numeric. midpoint for color gradient

- gradient_style:

  either 'divergent' (midpoint is used in color scaling) or 'sequential'
  (scaled based on data range)

- gradient_limits:

  numeric vector with lower and upper limits

- cow_n_col:

  cowplot param: how many columns

- cow_rel_h:

  cowplot param: relative heights of rows (e.g. c(1,2))

- cow_rel_w:

  cowplot param: relative widths of columns (e.g. c(1,2))

- cow_align:

  cowplot param: how to align

- show_legend:

  logical. show legend

- legend_text:

  size of legend text

- dim_background_color:

  color of plot background for dimension plot

- spat_background_color:

  color of plot background for spatial plot

- vor_border_color:

  border colorr for voronoi plot

- vor_max_radius:

  maximum radius for voronoi 'cells'

- vor_alpha:

  transparancy of voronoi 'cells'

- axis_text:

  size of axis text

- axis_title:

  size of axis title

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

ggplot

## Details

Description of parameters.

## Examples

``` r
g <- GiottoData::loadGiottoMini("visium", verbose = FALSE)
spatDimFeatPlot2D(g, feats = c("Gna12", "Ccnd2", "Btbd17"))

```
