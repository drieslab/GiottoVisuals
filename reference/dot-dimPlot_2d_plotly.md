# .dimPlot_2d_plotly

Visualize cells at their 2D dimension reduction coordinates with plotly

## Usage

``` r
.dimPlot_2d_plotly(
  gobject,
  spat_unit = NULL,
  feat_type = NULL,
  dim_reduction_to_use = "umap",
  dim_reduction_name = "umap",
  dim1_to_use = 1,
  dim2_to_use = 2,
  spat_enr_names = NULL,
  select_cell_groups = NULL,
  select_cells = NULL,
  show_other_cells = TRUE,
  other_cell_color = "lightgrey",
  other_point_size = 0.5,
  show_NN_network = FALSE,
  nn_network_to_use = "sNN",
  network_name = "sNN.pca",
  color_as_factor = TRUE,
  cell_color = NULL,
  cell_color_code = NULL,
  show_cluster_center = FALSE,
  show_center_label = TRUE,
  center_point_size = 4,
  label_size = 4,
  edge_alpha = NULL,
  point_size = 5
)
```

## Value

plotly object
