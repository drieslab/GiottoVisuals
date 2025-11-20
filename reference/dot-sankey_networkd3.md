# Create networkd3 sankey

Wrapper for networkd3's sankeyNetwork function. Adds some additional
params for controlling the plot.

## Usage

``` r
.sankey_networkd3(
  Links,
  Nodes,
  Source = "source",
  Target = "target",
  Value = "value",
  NodeID = "name",
  nodePadding = 1,
  sinksRight = FALSE,
  focus_names = NULL,
  unfocused_replacer = "",
  unfocused_color = FALSE,
  ...
)
```

## Value

networkd3 sankey
