# spatCellPlot

Visualize cells according to spatial coordinates

## Usage

``` r
spatCellPlot2D(
  gobject,
  spat_unit = NULL,
  feat_type = NULL,
  show_image = FALSE,
  gimage = NULL,
  image_name = NULL,
  largeImage_name = NULL,
  sdimx = "sdimx",
  sdimy = "sdimy",
  spat_enr_names = NULL,
  cell_annotation_values = NULL,
  cell_color_gradient = NULL,
  gradient_midpoint = NULL,
  gradient_style = c("divergent", "sequential"),
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
  show_legend = TRUE,
  legend_text = 8,
  legend_symbol_size = 1,
  background_color = "white",
  vor_border_color = "white",
  vor_max_radius = 200,
  vor_alpha = 1,
  axis_text = 8,
  axis_title = 8,
  cow_n_col = NULL,
  cow_rel_h = 1,
  cow_rel_w = 1,
  cow_align = "h",
  theme_param = list(),
  show_plot = NULL,
  return_plot = NULL,
  save_plot = NULL,
  save_param = list(),
  default_save_name = "spatCellPlot2D"
)

spatCellPlot(...)
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

- sdimx:

  x-axis dimension name (default = 'sdimx')

- sdimy:

  y-axis dimension name (default = 'sdimy')

- spat_enr_names:

  character. names of spatial enrichment results to include

- cell_annotation_values:

  numeric cell annotation columns

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

- select_cell_groups:

  select subset of cells/clusters based on cell_color parameter

- select_cells:

  select subset of cells based on cell IDs

- point_shape:

  point with border or not (border or no_border)

- point_size:

  size of point (cell)

- point_alpha:

  transparency of points

- point_border_col:

  color of border around points

- point_border_stroke:

  stroke size of border around points

- show_cluster_center:

  plot center of selected clusters

- show_center_label:

  plot label of selected clusters

- center_point_size:

  size of center points

- center_point_border_col:

  border color of center points

- center_point_border_stroke:

  border stroke size of center points

- label_size:

  size of labels

- label_fontface:

  font of labels

- show_network:

  show underlying spatial network

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

- show_other_cells:

  display not selected cells

- other_cell_color:

  color for not selected cells

- other_point_size:

  point size for not selected cells

- other_cells_alpha:

  (0 to 1) alpha for not selected cells

- coord_fix_ratio:

  fix ratio between x and y-axis

- show_legend:

  logical. show legend

- legend_text:

  size of legend text

- legend_symbol_size:

  size of legend symbols

- background_color:

  color of plot background

- vor_border_color:

  border colorr for voronoi plot

- vor_max_radius:

  maximum radius for voronoi 'cells'

- vor_alpha:

  transparency of voronoi 'cells'

- axis_text:

  size of axis text

- axis_title:

  size of axis title

- cow_n_col:

  cowplot param: how many columns

- cow_rel_h:

  cowplot param: relative heights of rows (e.g. c(1,2))

- cow_rel_w:

  cowplot param: relative widths of columns (e.g. c(1,2))

- cow_align:

  cowplot param: how to align

- theme_param:

  list of additional params passed to
  [`ggplot2::theme()`](https://ggplot2.tidyverse.org/reference/theme.html)

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

  spatCellPlot(...) passes to spatCellPlot2D()

## Value

ggplot

ggplot

## Details

Description of parameters.

## Examples

``` r
g <- GiottoData::loadGiottoMini("visium", verbose = FALSE)
spatCellPlot2D(g, cell_annotation_values = "leiden_clus")


g <- GiottoData::loadGiottoMini("visium", verbose = FALSE)
spatCellPlot(g, cell_annotation_values = "leiden_clus")

```
