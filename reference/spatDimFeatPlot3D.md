# spatDimFeatPlot3D

Visualize cells according to spatial AND dimension reduction coordinates
in ggplot mode

## Usage

``` r
spatDimFeatPlot3D(
  gobject,
  feat_type = NULL,
  spat_unit = NULL,
  spat_loc_name = NULL,
  expression_values = c("normalized", "scaled", "custom"),
  plot_alignment = c("horizontal", "vertical"),
  dim_reduction_to_use = "umap",
  dim_reduction_name = "umap",
  dim1_to_use = 1,
  dim2_to_use = 2,
  dim3_to_use = NULL,
  sdimx = "sdimx",
  sdimy = "sdimy",
  sdimz = "sdimz",
  genes,
  cluster_column = NULL,
  select_cell_groups = NULL,
  select_cells = NULL,
  show_other_cells = TRUE,
  other_cell_color = "lightgrey",
  other_point_size = 1.5,
  show_NN_network = FALSE,
  nn_network_to_use = "sNN",
  nn_network_color = "lightgrey",
  nn_network_alpha = 0.5,
  network_name = "sNN.pca",
  label_size = 16,
  genes_low_color = "blue",
  genes_mid_color = "white",
  genes_high_color = "red",
  dim_point_size = 3,
  show_spatial_network = FALSE,
  spatial_network_name = "Delaunay_network",
  spatial_network_color = "lightgray",
  spatial_network_alpha = 0.5,
  show_spatial_grid = FALSE,
  spatial_grid_name = "spatial_grid",
  spatial_grid_color = NULL,
  spatial_grid_alpha = 0.5,
  spatial_point_size = 3,
  legend_text_size = 12,
  axis_scale = c("cube", "real", "custom"),
  custom_ratio = NULL,
  x_ticks = NULL,
  y_ticks = NULL,
  z_ticks = NULL,
  show_plot = NULL,
  return_plot = NULL,
  save_plot = NULL,
  save_param = list(),
  default_save_name = "spatDimFeatPlot3D"
)

spatDimGenePlot3D(...)
```

## Arguments

- gobject:

  giotto object

- feat_type:

  feature type (e.g. "rna", "dna", "protein")

- spat_unit:

  spatial unit (e.g. "cell")

- spat_loc_name:

  name of spatial locations to use

- expression_values:

  gene expression values to use

- plot_alignment:

  direction to align plot

- dim_reduction_to_use:

  dimension reduction to use

- dim_reduction_name:

  dimension reduction name

- dim1_to_use:

  dimension to use on x-axis

- dim2_to_use:

  dimension to use on y-axis

- dim3_to_use:

  dimension to use on z-axis

- sdimx:

  spatial dimension to use on x-axis

- sdimy:

  spatial dimension to use on y-axis

- sdimz:

  spatial dimension to use on z-axis

- genes:

  genes to show

- cluster_column:

  cluster column to select groups

- select_cell_groups:

  select subset of cells/clusters based on cell_color parameter

- select_cells:

  select subset of cells based on cell IDs

- show_other_cells:

  display not selected cells

- other_cell_color:

  color of not selected cells

- other_point_size:

  size of not selected cells

- show_NN_network:

  show underlying NN network

- nn_network_to_use:

  type of NN network to use (kNN vs sNN)

- nn_network_color:

  color of NN network

- nn_network_alpha:

  alpha of NN network

- network_name:

  name of NN network to use, if show_NN_network = TRUE

- label_size:

  size of labels

- genes_low_color:

  color for low expression levels

- genes_mid_color:

  color for medium expression levels

- genes_high_color:

  color for high expression levels

- dim_point_size:

  dim reduction plot: point size

- show_spatial_network:

  show spatial network (boolean)

- spatial_network_name:

  name of spatial network to use

- spatial_network_color:

  color of spatial network

- spatial_network_alpha:

  alpha of spatial network

- show_spatial_grid:

  show spatial grid (boolean)

- spatial_grid_name:

  name of spatial grid to use

- spatial_grid_color:

  color of spatial grid

- spatial_grid_alpha:

  alpha of spatial grid

- spatial_point_size:

  spatial plot: point size

- legend_text_size:

  size of legend

- axis_scale:

  the way to scale the axis

- custom_ratio:

  customize the scale of the plot

- x_ticks:

  set the number of ticks on the x-axis

- y_ticks:

  set the number of ticks on the y-axis

- z_ticks:

  set the number of ticks on the z-axis

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

  additional params to pass

## Value

plotly

## Details

Description of parameters.

## Functions

- `spatDimGenePlot3D()`: deprecated

## Examples

``` r
g <- GiottoData::loadGiottoMini("starmap")
#> 1. read Giotto object
#> 2. read Giotto feature information
#> 3. read Giotto spatial information
#> 4. read Giotto image information
#> python already initialized in this session
#>  active environment : '/usr/bin/python3'
#>  python version : 3.12
spatDimFeatPlot3D(g, genes = "Slc17a7")
#> Warning: 'layout' objects don't have these attributes: 'NA'
#> Valid attributes include:
#> '_deprecated', 'activeshape', 'annotations', 'autosize', 'autotypenumbers', 'calendar', 'clickmode', 'coloraxis', 'colorscale', 'colorway', 'computed', 'datarevision', 'dragmode', 'editrevision', 'editType', 'font', 'geo', 'grid', 'height', 'hidesources', 'hoverdistance', 'hoverlabel', 'hovermode', 'images', 'legend', 'mapbox', 'margin', 'meta', 'metasrc', 'modebar', 'newshape', 'paper_bgcolor', 'plot_bgcolor', 'polar', 'scene', 'selectdirection', 'selectionrevision', 'separators', 'shapes', 'showlegend', 'sliders', 'smith', 'spikedistance', 'template', 'ternary', 'title', 'transition', 'uirevision', 'uniformtext', 'updatemenus', 'width', 'xaxis', 'yaxis', 'boxmode', 'barmode', 'bargap', 'mapType'
```
