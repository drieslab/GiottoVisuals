# plotHeatmap

Creates heatmap for features and clusters.

## Usage

``` r
plotHeatmap(
  gobject,
  spat_unit = NULL,
  feat_type = NULL,
  expression_values = c("normalized", "scaled", "custom"),
  feats,
  cluster_column = NULL,
  cluster_order = c("size", "correlation", "custom"),
  cluster_custom_order = NULL,
  cluster_color_code = NULL,
  cluster_cor_method = "pearson",
  cluster_hclust_method = "ward.D",
  feat_order = c("correlation", "custom"),
  feat_custom_order = NULL,
  feat_cor_method = "pearson",
  feat_hclust_method = "complete",
  show_values = c("rescaled", "z-scaled", "original"),
  size_vertical_lines = 1.1,
  gradient_colors = deprecated(),
  gradient_color = NULL,
  gradient_style = c("divergent", "sequential"),
  feat_label_selection = NULL,
  axis_text_y_size = NULL,
  legend_nrows = 1,
  show_plot = NULL,
  return_plot = NULL,
  save_plot = NULL,
  save_param = list(),
  default_save_name = "plotHeatmap"
)
```

## Arguments

- gobject:

  giotto object

- spat_unit:

  spatial unit (e.g. "cell")

- feat_type:

  feature type (e.g. "rna", "dna", "protein")

- expression_values:

  expression values to use (e.g. "normalized", "scaled", "custom")

- feats:

  features to use

- cluster_column:

  name of column to use for clusters (e.g. "leiden_clus")

- cluster_order:

  method to determine cluster order (e.g. "size", "correlation",
  "custom")

- cluster_custom_order:

  custom order for clusters

- cluster_color_code:

  color code for clusters

- cluster_cor_method:

  method for cluster correlation, default to "pearson"

- cluster_hclust_method:

  method for hierarchical clustering of clusters, default to "ward.D"

- feat_order:

  method to determine features order (e.g. "correlation", "custom")

- feat_custom_order:

  custom order for features

- feat_cor_method:

  method for features correlation, default to "pearson"

- feat_hclust_method:

  method for hierarchical clustering of features, default to "complete"

- show_values:

  which values to show on heatmap (e.g. "rescaled", "z-scaled",
  "original")

- size_vertical_lines:

  sizes for vertical lines

- gradient_colors:

  deprecated

- gradient_color:

  character. continuous colors to use. palette to use or vector of
  colors to use (minimum of 2).

- gradient_style:

  either 'divergent' (midpoint is used in color scaling) or 'sequential'
  (scaled based on data range)

- feat_label_selection:

  subset of features to show on y-axis

- axis_text_y_size:

  size for y-axis text

- legend_nrows:

  number of rows for the cluster legend

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

If you want to display many features there are 2 ways to proceed:

- 1\. set axis_text_y_size to a very small value and show all features

- 2\. provide a subset of features to display to feat_label_selection

## Examples

``` r
g <- GiottoData::loadGiottoMini("visium", verbose = FALSE)
plotHeatmap(g,
    feats = c("Gm19935", "Gna12", "Ccnd2", "Btbd17"),
    cluster_column = "leiden_clus"
)

```
