# Create heatmap data.table

creates order for clusters

## Usage

``` r
.create_heatmap_dt(
  gobject,
  spat_unit = NULL,
  feat_type = NULL,
  expression_values = c("normalized", "scaled", "custom"),
  feats,
  cluster_column = NULL,
  cluster_order = c("size", "correlation", "custom"),
  cluster_custom_order = NULL,
  cluster_cor_method = "pearson",
  cluster_hclust_method = "ward.D",
  feat_order = c("correlation", "custom"),
  feat_custom_order = NULL,
  feat_cor_method = "pearson",
  feat_hclust_method = "complete"
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

## Value

list

## Details

Creates input data.tables for plotHeatmap function.
