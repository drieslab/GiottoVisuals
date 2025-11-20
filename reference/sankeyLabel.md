# Get and set the sankey labels information

Get and set the sankey labels information

## Usage

``` r
sankeyLabel(x)

sankeyLabel(x) <- value
```

## Arguments

- x:

  giottoSankeyPlan

- value:

  values to set

## Value

character

a `giottoSankeyPlan`

## Examples

``` r
my_sankeyplan <- sankeySet(
    spat_unit = "cell",
    feat_type = "rna", col = "leiden_clus"
)
my_sankeyplan <- `sankeyLabel<-`(my_sankeyplan, value = "my_label")
sankeyLabel(my_sankeyplan)
#> [1] "my_label"

my_sankeyplan <- sankeySet(
    spat_unit = "cell",
    feat_type = "rna", col = "leiden_clus"
)
my_sankeyplan <- `sankeyLabel<-`(my_sankeyplan, value = "my_label")
```
