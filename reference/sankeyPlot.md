# Create a sankey plot

Create a sankey plot. Pulls from information metadata if giotto object
is provided. Simple 1 to 1 sankeys can be generated from a single
spatial unit and feature type using the `spat_unit`, `feat_type`,
`meta_type`, `cols`, and (optionally) `idx` params. More complex and
cross spatial unit/feature type sankeys can be set up using the
`sankey_plan` param which accepts a `giottoSankeyPlan` object.  
Also possible to directly use data.frames or lists of data.frames and
giottoPolygon objects. See usage section and examples.

## Usage

``` r
# S4 method for class 'giotto,giottoSankeyPlan'
sankeyPlot(
  x,
  y,
  meta_type = c("cell", "feat"),
  focus_names = NULL,
  unfocused_color = FALSE,
  ...
)

# S4 method for class 'giotto,character'
sankeyPlot(
  x,
  y,
  spat_unit = NULL,
  feat_type = NULL,
  meta_type = c("cell", "feat"),
  idx = NULL,
  focus_names = NULL,
  unfocused_color = FALSE,
  ...
)

# S4 method for class 'data.frame,missing'
sankeyPlot(x, focus_names = NULL, unfocused_color = FALSE, ...)

# S4 method for class 'list,missing'
sankeyPlot(x, focus_names = NULL, unfocused_color = FALSE, ...)

# S4 method for class 'giottoPolygon,giottoPolygon'
sankeyPlot(x, y, focus_names = NULL, unfocused_color = FALSE, ...)
```

## Arguments

- x:

  data source (gobject, data.frame-like object with relations between
  the first two cols provided, or giottoPolygon)

- y:

  giottoSankeyPlan object or character vector referring to source and
  target columns in metadata if x is a gobject. Can also be missing or a
  second giottoPolygon (see usage section)

- meta_type:

  whether to use 'cell' (cell) or 'feat' (feature) metadata

- focus_names:

  character vector of node names to display. Others will be omitted.

- unfocused_color:

  whether to color nodes that are not focused on.

- ...:

  Arguments passed on to `networkD3::sankeyNetwork`

  `Value`

  :   character string naming the variable in the `Links` data frame for
      how far away the nodes are from one another.

  `NodeGroup`

  :   character string specifying the node groups in the `Nodes`. Used
      to color the nodes in the network.

  `LinkGroup`

  :   character string specifying the groups in the `Links`. Used to
      color the links in the network.

  `units`

  :   character string describing physical units (if any) for Value

  `colourScale`

  :   character string specifying the categorical colour scale for the
      nodes. See
      <https://github.com/d3/d3/blob/master/API.md#ordinal-scales>.

  `fontSize`

  :   numeric font size in pixels for the node text labels.

  `fontFamily`

  :   font family for the node text labels.

  `nodeWidth`

  :   numeric width of each node.

  `nodePadding`

  :   numeric essentially influences the width height.

  `margin`

  :   an integer or a named `list`/`vector` of integers for the plot
      margins. If using a named `list`/`vector`, the positions `top`,
      `right`, `bottom`, `left` are valid. If a single integer is
      provided, then the value will be assigned to the right margin. Set
      the margin appropriately to accomodate long text labels.

  `height`

  :   numeric height for the network graph's frame area in pixels.

  `width`

  :   numeric width for the network graph's frame area in pixels.

  `iterations`

  :   numeric. Number of iterations in the diagramm layout for
      computation of the depth (y-position) of each node. Note: this
      runs in the browser on the client so don't push it too high.

  `sinksRight`

  :   boolean. If `TRUE`, the last nodes are moved to the right border
      of the plot.

- spat_unit:

  spatial unit of metadata

- feat_type:

  feature type of metadata

- idx:

  table subset index for 1 to 1 comparisons

## Value

sankey plot

## Examples

``` r
x <- data.frame(
    col1 = c("a", "a", "b"),
    col2 = c("1", "2", "2")
)
sankeyPlot(x)
#> Error: package 'networkD3' is not yet installed
#> 
#>  To install:
#> install.packages(c("networkD3"))

y <- data.frame(
    col1 = "1",
    col2 = c("A", "B", "C")
)

# combine data.frames of relations
# rbind: note that node "1" is mapped the same for x and y
sankeyPlot(rbind(x, y), fontSize = 20)
#> Error: package 'networkD3' is not yet installed
#> 
#>  To install:
#> install.packages(c("networkD3"))

# list: note that node "1" is now considered a different node between x and y
sankeyPlot(list(x, y), fontSize = 20)
#> Error in loadNamespace(x): there is no package called ‘networkD3’

# focus on specific nodes/names
sankeyPlot(rbind(x, y), fontSize = 20, focus_names = c("a", "1", "B"))
#> Error: package 'networkD3' is not yet installed
#> 
#>  To install:
#> install.packages(c("networkD3"))

g <- GiottoData::loadGiottoMini("vizgen")
#> 1. read Giotto object
#> 2. read Giotto feature information
#> 3. read Giotto spatial information
#> 3.1 read Giotto spatial shape information
#> 3.2 read Giotto spatial centroid information
#> 3.3 read Giotto spatial overlap information
#> 4. read Giotto image information
#> python already initialized in this session
#>  active environment : '/usr/bin/python3'
#>  python version : 3.12
# with giottoSankeyPlan
leiden <- sankeySet(
    spat_unit = "aggregate",
    feat_type = "rna",
    col = "leiden_clus"
)
louvain <- sankeySet(
    spat_unit = "aggregate",
    feat_type = "rna",
    col = "louvain_clus"
)
# place defined sets into same object
plan <- leiden + louvain
# assign relationships to compare
sankeyRelate(plan) <- c(0, 1)
sankeyPlot(g, plan)
#> Error: package 'networkD3' is not yet installed
#> 
#>  To install:
#> install.packages(c("networkD3"))

# with single set of metadata
GiottoClass::activeSpatUnit(g) <- "aggregate"
sankeyPlot(g, c("louvain_clus", "leiden_clus"))
#> Error: package 'networkD3' is not yet installed
#> 
#>  To install:
#> install.packages(c("networkD3"))
```
