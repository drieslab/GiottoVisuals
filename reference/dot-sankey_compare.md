# Calculations for a sankey relationship pair

Generate the data.table of source, target, and value for a relation pair
as well as the list of node names to be used with sankey plotting.

## Usage

``` r
.sankey_compare(data_dt, idx_start = 0)
```

## Arguments

- data_dt:

  data.table with two columns. Each should contain categorical data.

- idx_start:

  starting index of nodes

## Value

list with 1. node names and 2. data.table with cols source, target, and
value
