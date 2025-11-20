# Calculations for a sankey relationship pair

Get matched values to compare from the giotto object. Comparison columns
are then passed as a data.table to `.sankey_compare` to be calculated.

## Usage

``` r
.sankey_relation_pair(g, gsp, rel_idx, node_idx_start = 0)
```

## Arguments

- g:

  giotto object

- gsp:

  giottoSankeyPlan object

- rel_idx:

  index of relation pair in `gsp`

- node_idx_start:

  starting index to assign new nodes

## Value

list with 1. node names and 2. data.table with cols source, target, and
value
