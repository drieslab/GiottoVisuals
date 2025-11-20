# Create a `giottoSankeyPlan` with one set of annotations

Create a `giottoSankeyPlan` with one set of annotations

## Usage

``` r
sankeySet(
  spat_unit = NULL,
  feat_type = NULL,
  col,
  index = NULL,
  label = NA_character_
)
```

## Arguments

- spat_unit:

  spatial unit of the metadata

- feat_type:

  feature type of the metadata

- col:

  which column of metadata to pull from. Must be data that can be
  treated categorically.

- index:

  character, integer, or logical vector to subset metadata table

- label:

  (optional) character label for a set

## Value

a `giottoSankeyPlan`

## Examples

``` r
my_sankeyplan <- sankeySet(
    spat_unit = "cell",
    feat_type = "rna", col = "leiden_clus"
)
```
