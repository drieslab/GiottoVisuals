# plotUMAP_2D

Short wrapper for UMAP visualization

## Usage

``` r
plotUMAP_2D(
  gobject,
  dim_reduction_name = NULL,
  default_save_name = "UMAP_2D",
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
  [`dimPlot2D`](https://drieslab.github.io/GiottoVisuals/reference/dimPlot.md)

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

  `cow_n_col`

  :   cowplot param: how many columns

  `cow_rel_h`

  :   cowplot param: relative heights of rows (e.g. c(1,2))

  `cow_rel_w`

  :   cowplot param: relative widths of columns (e.g. c(1,2))

  `cow_align`

  :   cowplot param: how to align

  `group_by`

  :   character. Create multiple plots based on cell annotation column

  `group_by_subset`

  :   character. subset the group_by factor column

  `gradient_midpoint`

  :   numeric. midpoint for color gradient

  `gradient_style`

  :   either 'divergent' (midpoint is used in color scaling) or
      'sequential' (scaled based on data range)

  `gradient_limits`

  :   numeric vector with lower and upper limits

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

  `center_point_border_col`

  :   border color of center points

  `center_point_border_stroke`

  :   border stroke size of center points

  `label_size`

  :   size of labels

  `label_fontface`

  :   font of labels

  `edge_alpha`

  :   column to use for alpha of the edges

  `point_shape`

  :   point with border or not (border or no_border)

  `point_size`

  :   size of point (cell)

  `point_alpha`

  :   transparency of points

  `point_border_col`

  :   color of border around points

  `point_border_stroke`

  :   stroke size of border around points

  `title`

  :   character. title for plot, defaults to cell_color parameter

  `show_legend`

  :   logical. show legend

  `legend_text`

  :   size of legend text

  `legend_symbol_size`

  :   size of legend symbols

  `background_color`

  :   color of plot background

  `axis_text`

  :   size of axis text

  `axis_title`

  :   size of axis title

## Value

ggplot

## Details

Description of parameters, see
[`dimPlot2D`](https://drieslab.github.io/GiottoVisuals/reference/dimPlot.md).
For 3D plots see
[`plotUMAP_3D`](https://drieslab.github.io/GiottoVisuals/reference/plotUMAP_3D.md)

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
[`plotUMAP_3D()`](https://drieslab.github.io/GiottoVisuals/reference/plotUMAP_3D.md)

## Examples

``` r
g <- GiottoData::loadGiottoMini("visium", verbose = FALSE)
plotUMAP_2D(g)
```
