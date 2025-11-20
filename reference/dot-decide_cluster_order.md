# Decide cluster order

creates order for clusters

## Usage

``` r
.decide_cluster_order(
  gobject,
  spat_unit = NULL,
  feat_type = NULL,
  expression_values = c("normalized", "scaled", "custom"),
  feats,
  cluster_column = NULL,
  cluster_order = c("size", "correlation", "custom"),
  cluster_custom_order = NULL,
  cor_method = "pearson",
  hclust_method = "ward.D"
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

  features to use (e.g. genes)

- cluster_column:

  name of column to use for clusters (e.g. "leiden_clus")

- cluster_order:

  method to determine cluster order (e.g. "size", "correlation",
  "custom")

- cluster_custom_order:

  custom order for clusters

- cor_method:

  method for correlation, default to 'pearson'

- hclust_method:

  method for hierarchical clustering, default to 'ward.D'

## Value

custom

## Details

Calculates order for clusters.
