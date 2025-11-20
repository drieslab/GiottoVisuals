# Create a ridgeline plot

Plot continuous numeric features as a series of density ridges.
Particularly useful for making comparisons between feature distributions
within a population.

## Usage

``` r
ridgePlot(
  gobject,
  feats,
  ...,
  group_by = NULL,
  group_by_subset = NULL,
  spat_unit = NULL,
  feat_type = NULL,
  stat = "density_ridges",
  ridge_alpha = 1,
  ridge_scale = 5,
  scale_axis = "identity",
  axis_offset = NULL,
  background_color = "white",
  remove_na = NULL,
  show_legend = FALSE,
  title = NULL,
  theme_param = list(),
  cow_n_col = NULL,
  cow_rel_h = 1,
  cow_rel_w = 1,
  cow_align = "h",
  show_plot = NULL,
  return_plot = NULL,
  save_plot = NULL,
  save_param = list(),
  default_save_name = "ridgePlot",
  verbose = NULL
)
```

## Arguments

- gobject:

  giotto object

- feats:

  features to plot. Passed to
  [`GiottoClass::spatValues()`](https://drieslab.github.io/GiottoClass/reference/spatValues.html)

- ...:

  additional params to pass to
  [`GiottoClass::spatValues()`](https://drieslab.github.io/GiottoClass/reference/spatValues.html)

- group_by:

  character. Create multiple plots based on cell annotation column

- group_by_subset:

  character. subset the group_by factor column

- spat_unit:

  spatial unit (e.g. "cell")

- feat_type:

  feature type (e.g. "rna", "dna", "protein")

- stat:

  character. A `stat` accepted by `ggridges::geom_density_ridges()`

- ridge_alpha:

  numeric. Alpha to use for ridgeline plot. Value from 0 to 1.

- ridge_scale:

  numeric. Controls height of ridges.

- scale_axis:

  character (default = `"log2"`. An x axis scaling to use. This value is
  passed to
  [`ggplot2::scale_x_continuous()`](https://ggplot2.tidyverse.org/reference/scale_continuous.html).
  Set `"identity"` to remove scaling.

- axis_offset:

  numeric. Value to add to values. When this value is not provided and
  `axis_scale` is one of `"log"`, `"log2"`, or `"log10"`, a
  `axis_offset` of 1 is used by default.

- background_color:

  background color

- remove_na:

  logical. If `FALSE`, the default, missing values are removed with a
  warning. If `TRUE`, missing values are silently removed.

- show_legend:

  logical. Whether to show legend

- title:

  character. Title for plot

- theme_param:

  list of additional params passed to
  [`ggplot2::theme()`](https://ggplot2.tidyverse.org/reference/theme.html)

- cow_n_col:

  cowplot param: how many columns

- cow_rel_h:

  cowplot param: relative heights of rows (e.g. c(1,2))

- cow_rel_w:

  cowplot param: relative widths of columns (e.g. c(1,2))

- cow_align:

  cowplot param: how to align

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

- verbose:

  be verbose

## Value

ggplot

## Examples

``` r
g <- GiottoData::loadGiottoMini("visium")
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

# plot normalized expresion of first 6 features
ridgePlot(g,
    feats = head(rownames(g)),
    expression_values = "normalized",
    scale_axis = "log2"
)
#> Error: package 'ggridges' is not yet installed
#> 
#>  To install:
#> install.packages(c("ggridges"))

# plot distribution on PCA PCs
ridgePlot(g,
    feats = sprintf("Dim.%d", 1:20),
    scale_axis = "identity"
)
#> Error: package 'ggridges' is not yet installed
#> 
#>  To install:
#> install.packages(c("ggridges"))

ridgePlot(g,
    feats = sprintf("Dim.%d", 1:20),
    scale_axis = "identity",
    group_by = "leiden_clus",
    group_by_subset = c(1:4)
)
#> Error: package 'ggridges' is not yet installed
#> 
#>  To install:
#> install.packages(c("ggridges"))
```
