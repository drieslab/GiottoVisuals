# Data.table of sankey set locations

Return a data.table containing where the sets of metadata to relate to
each other exists inside the Giotto object.

## Usage

``` r
sankeySetAddresses(x)
```

## Arguments

- x:

  giottoSankeyPlan object

## Value

a `giottoSankeyPlan`

## Examples

``` r
my_sankeyplan <- sankeySet(
    spat_unit = "cell",
    feat_type = "rna", col = "leiden_clus"
)
my_sankeyplan <- sankeySetAddresses(my_sankeyplan)
```
