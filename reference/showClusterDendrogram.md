# showClusterDendrogram

Creates dendrogram for selected clusters.

## Usage

``` r
showClusterDendrogram(
  gobject,
  spat_unit = NULL,
  feat_type = NULL,
  expression_values = c("normalized", "scaled", "custom"),
  cluster_column,
  cor = c("pearson", "spearman"),
  distance = "ward.D",
  h = NULL,
  h_color = "red",
  rotate = FALSE,
  show_plot = NULL,
  return_plot = NULL,
  save_plot = NULL,
  save_param = list(),
  default_save_name = "showClusterDendrogram",
  ...
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

- cluster_column:

  name of column to use for clusters (e.g. "leiden_clus")

- cor:

  correlation score to calculate distance (e.g. "pearson", "spearman")

- distance:

  distance method to use for hierarchical clustering, default to
  "ward.D"

- h:

  height of horizontal lines to plot

- h_color:

  color of horizontal lines

- rotate:

  rotate dendrogram 90 degrees

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

  Arguments passed on to `ggdendro::ggdendrogram`

  `data`

  :   Either a dendro object or an object that can be coerced to class
      dendro using the `dendro_data()` function, i.e. objects of class
      dendrogram, hclust or tree

  `segments`

  :   If TRUE, show line segments

  `labels`

  :   if TRUE, shows segment labels

  `leaf_labels`

  :   if TRUE, shows leaf labels

  `theme_dendro`

  :   if TRUE, applies a blank theme to plot (see `theme_dendro()`)

## Value

ggplot

## Details

Expression correlation dendrogram for selected clusters.

## Examples

``` r
g <- GiottoData::loadGiottoMini("visium", verbose = FALSE)
showClusterDendrogram(g, cluster_column = "leiden_clus")
#> Error: package 'ggdendro' is not yet installed
#> 
#>  To install:
#> install.packages(c("ggdendro"))
```
