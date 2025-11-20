# dimFeatPlot3D

Visualize cells and gene expression according to dimension reduction
coordinates

## Usage

``` r
dimFeatPlot3D(
  gobject,
  feat_type = NULL,
  spat_unit = NULL,
  expression_values = c("normalized", "scaled", "custom"),
  genes = NULL,
  dim_reduction_to_use = "umap",
  dim_reduction_name = "umap",
  dim1_to_use = 1,
  dim2_to_use = 2,
  dim3_to_use = 3,
  show_NN_network = FALSE,
  nn_network_to_use = "sNN",
  network_name = "sNN.pca",
  network_color = "lightgray",
  cluster_column = NULL,
  select_cell_groups = NULL,
  select_cells = NULL,
  show_other_cells = TRUE,
  other_cell_color = "lightgrey",
  other_point_size = 1,
  edge_alpha = NULL,
  point_size = 2,
  genes_high_color = NULL,
  genes_mid_color = "white",
  genes_low_color = "blue",
  show_legend = TRUE,
  show_plot = NULL,
  return_plot = NULL,
  save_plot = NULL,
  save_param = list(),
  default_save_name = "dimFeatPlot3D"
)

dimGenePlot3D(...)
```

## Arguments

- gobject:

  giotto object

- feat_type:

  feature type (e.g. "rna", "dna", "protein")

- spat_unit:

  spatial unit (e.g. "cell")

- expression_values:

  gene expression values to use

- genes:

  genes to show

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

- show_NN_network:

  show underlying NN network

- nn_network_to_use:

  type of NN network to use (kNN vs sNN)

- network_name:

  name of NN network to use, if show_NN_network = TRUE

- network_color:

  color of NN network

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

- edge_alpha:

  column to use for alpha of the edges

- point_size:

  size of point (cell)

- genes_high_color:

  color for high expression levels

- genes_mid_color:

  color for medium expression levels

- genes_low_color:

  color for low expression levels

- show_legend:

  show legend

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

- `dimGenePlot3D()`: deprecated

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

dimFeatPlot3D(g, genes = "Slc17a7", dim_reduction_name = "3D_umap")
```
