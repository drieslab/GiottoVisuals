# plotMetaDataCellsHeatmap

Creates heatmap for numeric cell metadata within aggregated clusters.

## Usage

``` r
plotMetaDataCellsHeatmap(
  gobject,
  spat_unit = NULL,
  feat_type = NULL,
  metadata_cols = NULL,
  spat_enr_names = NULL,
  value_cols = NULL,
  first_meta_col = NULL,
  second_meta_col = NULL,
  show_values = c("zscores", "original", "zscores_rescaled"),
  custom_cluster_order = NULL,
  clus_cor_method = "pearson",
  clus_cluster_method = "complete",
  custom_values_order = NULL,
  values_cor_method = "pearson",
  values_cluster_method = "complete",
  gradient_color = NULL,
  gradient_midpoint = 0,
  gradient_style = c("divergent", "sequential"),
  midpoint = deprecated(),
  x_text_size = 8,
  x_text_angle = 45,
  y_text_size = 8,
  y_axis_title = "genes",
  strip_text_size = 8,
  show_plot = NULL,
  return_plot = NULL,
  save_plot = NULL,
  save_param = list(),
  default_save_name = "plotMetaDataCellsHeatmap"
)
```

## Arguments

- gobject:

  giotto object

- spat_unit:

  spatial unit (e.g. "cell")

- feat_type:

  feature type (e.g. "rna", "dna", "protein")

- metadata_cols:

  annotation columns found in pDataDT(gobject)

- spat_enr_names:

  spatial enrichment results to include

- value_cols:

  value columns to use

- first_meta_col:

  if more than 1 metadata column, select the x-axis factor

- second_meta_col:

  if more than 1 metadata column, select the facetting factor

- show_values:

  which values to show on heatmap (e.g. "zscores", "original",
  "zscores_rescaled")

- custom_cluster_order:

  custom cluster order (default = NULL)

- clus_cor_method:

  correlation method for clusters, default to "pearson"

- clus_cluster_method:

  hierarchical cluster method for the clusters, default to "complete"

- custom_values_order:

  custom values order (default = NULL)

- values_cor_method:

  correlation method for values, default to "pearson"

- values_cluster_method:

  hierarchical cluster method for the values, default to "complete"

- gradient_color:

  character. continuous colors to use. palette to use or vector of
  colors to use (minimum of 2).

- gradient_midpoint:

  numeric. midpoint for color gradient

- gradient_style:

  either 'divergent' (midpoint is used in color scaling) or 'sequential'
  (scaled based on data range)

- midpoint:

  deprecated. Use gradient_midpoint.

- x_text_size:

  size of x-axis text

- x_text_angle:

  angle of x-axis text

- y_text_size:

  size of y-axis text

- y_axis_title:

  character. default is "genes".

- strip_text_size:

  size of strip text

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

ggplot or data.table

## Details

Creates heatmap for the average values of selected value columns in the
different annotation groups.

## See also

[`plotMetaDataHeatmap`](https://drieslab.github.io/GiottoVisuals/reference/plotMetaDataHeatmap.md)
for feature expression instead of numeric cell annotation data.
