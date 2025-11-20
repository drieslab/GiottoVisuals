# Create clustered expression dendrogram

Create a dendrogram based on a data.table with columns for cluster ID,
variables, and their values. If no specific values are provided for the
'col' params then they will be assumed as 1. clus_col, 2. var_col, 3.
val_col

## Usage

``` r
create_cluster_dendrogram(
  data,
  clus_col = names(data)[[1]],
  var_col = names(data)[[2]],
  val_col = names(data)[[3]],
  cor = c("pearson", "spearman"),
  distance = "ward.D",
  h = NULL,
  h_color = "red",
  rotate = FALSE,
  ...
)
```

## Arguments

- data:

  data.table. Should include columns with clustering labels, variables
  that are being clustered, and the values of those clusters.

- clus_col:

  character. name of column with clustering info

- var_col:

  character. name of column with variable name

- val_col:

  character. name of column with values info

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

- ...:

  Arguments passed on to `ggdendro::ggdendrogram`

  `segments`

  :   If TRUE, show line segments

  `labels`

  :   if TRUE, shows segment labels

  `leaf_labels`

  :   if TRUE, shows leaf labels

  `theme_dendro`

  :   if TRUE, applies a blank theme to plot (see `theme_dendro()`)

## Value

ggdendrogram

## Examples

``` r
g <- GiottoData::loadGiottoMini("visium", verbose = FALSE)

g_expression <- head(GiottoClass::getExpression(g, output = "matrix"))
g_expression_df <- as.data.frame(as.matrix(g_expression))
g_expression_df$feat_ID <- rownames(g_expression)

g_expression_melt <- data.table::melt(g_expression_df,
    id.vars = "feat_ID",
    measure.vars = colnames(g_expression), variable.name = "cell_ID",
    value.name = "raw_expression"
)
#> Error in melt.default(g_expression_df, id.vars = "feat_ID", measure.vars = colnames(g_expression),     variable.name = "cell_ID", value.name = "raw_expression"): The melt generic in data.table has been passed a data.frame and will attempt to redirect to the relevant reshape2 method; please note that reshape2 is superseded and is no longer actively developed, and this redirection is now deprecated. To continue using melt methods from reshape2 while both packages are attached, e.g. melt.list, you can prepend the namespace, i.e. reshape2::melt(g_expression_df). In the next version, this warning will become an error.

create_cluster_dendrogram(data.table::as.data.table(g_expression_melt),
    var_col = "cell_ID", clus_col = "feat_ID", "raw_expression"
)
#> Error: object 'g_expression_melt' not found
```
