# plotUMAP_3D

Visualize cells according to dimension reduction coordinates

## Usage

``` r
plotUMAP_3D(
  gobject,
  dim_reduction_name = "umap",
  default_save_name = "UMAP_3D",
  ...
)
```

## Arguments

- gobject:

  giotto object

- dim_reduction_name:

  name of UMAP

- default_save_name:

  default save name of UMAP plot

- ...:

  Arguments passed on to
  [`dimPlot3D`](https://drieslab.github.io/GiottoVisuals/reference/dimPlot.md)

  `spat_unit`

  :   spatial unit (e.g. "cell")

  `feat_type`

  :   feature type (e.g. "rna", "dna", "protein")

  `show_plot`

  :   logical. show plot

  `return_plot`

  :   logical. return ggplot object

  `save_plot`

  :   logical. save the plot

  `save_param`

  :   list of saving parameters, see
      [`showSaveParameters`](https://drieslab.github.io/GiottoVisuals/reference/showSaveParameters.md)

  `dim1_to_use`

  :   numeric. dimension to use on x-axis

  `dim2_to_use`

  :   numeric. dimension to use on y-axis

  `dim3_to_use`

  :   numeric. dimension to use on z-axis

  `show_NN_network`

  :   logical. Show underlying NN network

  `nn_network_to_use`

  :   character. type of NN network to use (kNN vs sNN)

  `network_name`

  :   character. name of NN network to use, if show_NN_network = TRUE

  `spat_enr_names`

  :   character. names of spatial enrichment results to include

  `cell_color`

  :   character. what to color cells by (e.g. metadata col or spatial
      enrichment col)

  `color_as_factor`

  :   logical. convert color column to factor. Discrete colors are used
      when this is TRUE. continuous colors when FALSE.

  `cell_color_code`

  :   character. discrete colors to use. palette to use or named vector
      of colors

  `cell_color_gradient`

  :   character. continuous colors to use. palette to use or vector of
      colors to use (minimum of 2).

  `select_cell_groups`

  :   select subset of cells/clusters based on cell_color parameter

  `select_cells`

  :   select subset of cells based on cell IDs

  `show_other_cells`

  :   display not selected cells

  `other_cell_color`

  :   color for not selected cells

  `other_point_size`

  :   point size for not selected cells

  `show_cluster_center`

  :   plot center of selected clusters

  `show_center_label`

  :   plot label of selected clusters

  `center_point_size`

  :   size of center points

  `label_size`

  :   size of labels

  `edge_alpha`

  :   column to use for alpha of the edges

  `point_size`

  :   size of point (cell)

## Value

plotly

## Details

Description of parameters.

## See also

Other reduced dimension visualizations:
[`dimPlot2D()`](https://drieslab.github.io/GiottoVisuals/reference/dimPlot.md),
[`plotPCA()`](https://drieslab.github.io/GiottoVisuals/reference/plotPCA.md),
[`plotPCA_2D()`](https://drieslab.github.io/GiottoVisuals/reference/plotPCA_2D.md),
[`plotPCA_3D()`](https://drieslab.github.io/GiottoVisuals/reference/plotPCA_3D.md),
[`plotTSNE()`](https://drieslab.github.io/GiottoVisuals/reference/plotTSNE.md),
[`plotTSNE_2D()`](https://drieslab.github.io/GiottoVisuals/reference/plotTSNE_2D.md),
[`plotTSNE_3D()`](https://drieslab.github.io/GiottoVisuals/reference/plotTSNE_3D.md),
[`plotUMAP()`](https://drieslab.github.io/GiottoVisuals/reference/plotUMAP.md),
[`plotUMAP_2D()`](https://drieslab.github.io/GiottoVisuals/reference/plotUMAP_2D.md)

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
plotUMAP_3D(g, dim_reduction_name = "3D_umap")
#> create 3D plot
```
