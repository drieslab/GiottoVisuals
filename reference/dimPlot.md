# Plot dimension reduction

Visualize cells according to dimension reduction coordinates

## Usage

``` r
dimPlot2D(
  gobject,
  spat_unit = NULL,
  feat_type = NULL,
  group_by = NULL,
  group_by_subset = NULL,
  dim_reduction_to_use = "umap",
  dim_reduction_name = NULL,
  dim1_to_use = 1,
  dim2_to_use = 2,
  spat_enr_names = NULL,
  show_NN_network = FALSE,
  nn_network_to_use = "sNN",
  network_name = "sNN.pca",
  cell_color = NULL,
  color_as_factor = TRUE,
  cell_color_code = NULL,
  cell_color_gradient = NULL,
  gradient_midpoint = NULL,
  gradient_style = c("divergent", "sequential"),
  gradient_limits = NULL,
  select_cell_groups = NULL,
  select_cells = NULL,
  show_other_cells = TRUE,
  other_cell_color = "lightgrey",
  other_point_size = 0.5,
  show_cluster_center = FALSE,
  show_center_label = TRUE,
  center_point_size = 4,
  center_point_border_col = "black",
  center_point_border_stroke = 0.1,
  label_size = 4,
  label_fontface = "bold",
  edge_alpha = NULL,
  point_shape = c("border", "no_border"),
  point_size = 1,
  point_alpha = 1,
  point_border_col = "black",
  point_border_stroke = 0.1,
  title = NULL,
  show_legend = TRUE,
  legend_text = 10,
  legend_symbol_size = 2,
  background_color = "white",
  axis_text = 8,
  axis_title = 8,
  cow_n_col = NULL,
  cow_rel_h = 1,
  cow_rel_w = 1,
  cow_align = "h",
  show_plot = NULL,
  return_plot = NULL,
  save_plot = NULL,
  save_param = list(),
  default_save_name = "dimPlot2D"
)

dimPlot(...)

dimPlot3D(
  gobject,
  spat_unit = NULL,
  feat_type = NULL,
  dim_reduction_to_use = "umap",
  dim_reduction_name = "umap",
  dim1_to_use = 1,
  dim2_to_use = 2,
  dim3_to_use = 3,
  spat_enr_names = NULL,
  select_cell_groups = NULL,
  select_cells = NULL,
  show_other_cells = TRUE,
  other_cell_color = "lightgrey",
  other_point_size = 2,
  show_NN_network = FALSE,
  nn_network_to_use = "sNN",
  network_name = "sNN.pca",
  color_as_factor = TRUE,
  cell_color = NULL,
  cell_color_code = NULL,
  cell_color_gradient = NULL,
  show_cluster_center = FALSE,
  show_center_label = TRUE,
  center_point_size = 4,
  label_size = 4,
  edge_alpha = NULL,
  point_size = 3,
  show_plot = NULL,
  return_plot = NULL,
  save_plot = NULL,
  save_param = list(),
  default_save_name = "dim3D"
)
```

## Arguments

- gobject:

  giotto object

- spat_unit:

  spatial unit (e.g. "cell")

- feat_type:

  feature type (e.g. "rna", "dna", "protein")

- group_by:

  character. Create multiple plots based on cell annotation column

- group_by_subset:

  character. subset the group_by factor column

- dim_reduction_to_use:

  character. dimension reduction to use

- dim_reduction_name:

  character. dimension reduction name

- dim1_to_use:

  numeric. dimension to use on x-axis

- dim2_to_use:

  numeric. dimension to use on y-axis

- spat_enr_names:

  character. names of spatial enrichment results to include

- show_NN_network:

  logical. Show underlying NN network

- nn_network_to_use:

  character. type of NN network to use (kNN vs sNN)

- network_name:

  character. name of NN network to use, if show_NN_network = TRUE

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

- show_other_cells:

  display not selected cells

- other_cell_color:

  color for not selected cells

- other_point_size:

  point size for not selected cells

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

- edge_alpha:

  column to use for alpha of the edges

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

- title:

  character. title for plot, defaults to cell_color parameter

- show_legend:

  logical. show legend

- legend_text:

  size of legend text

- legend_symbol_size:

  size of legend symbols

- background_color:

  color of plot background

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

  dimPlot(...) passes to dimPlot2D()

- dim3_to_use:

  numeric. dimension to use on z-axis

## Value

ggplot

ggplot

plotly (dimplot3D only)

## See also

Other reduced dimension visualizations:
[`plotPCA()`](https://drieslab.github.io/GiottoVisuals/reference/plotPCA.md),
[`plotPCA_2D()`](https://drieslab.github.io/GiottoVisuals/reference/plotPCA_2D.md),
[`plotPCA_3D()`](https://drieslab.github.io/GiottoVisuals/reference/plotPCA_3D.md),
[`plotTSNE()`](https://drieslab.github.io/GiottoVisuals/reference/plotTSNE.md),
[`plotTSNE_2D()`](https://drieslab.github.io/GiottoVisuals/reference/plotTSNE_2D.md),
[`plotTSNE_3D()`](https://drieslab.github.io/GiottoVisuals/reference/plotTSNE_3D.md),
[`plotUMAP()`](https://drieslab.github.io/GiottoVisuals/reference/plotUMAP.md),
[`plotUMAP_2D()`](https://drieslab.github.io/GiottoVisuals/reference/plotUMAP_2D.md),
[`plotUMAP_3D()`](https://drieslab.github.io/GiottoVisuals/reference/plotUMAP_3D.md)

## Examples

``` r
g <- GiottoData::loadGiottoMini("visium", verbose = FALSE)
dimPlot2D(g)

g <- GiottoData::loadGiottoMini("visium", verbose = FALSE)
dimPlot(g)
```
