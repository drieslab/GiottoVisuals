# Set a relation between two sankey sets

Set a relation to be compared across two sets of metadata annotations in
the Giotto object.

## Usage

``` r
# S4 method for class 'giottoSankeyPlan'
sankeyRelate(x, ...)

# S4 method for class 'giottoSankeyPlan,logical,data.frame'
sankeyRelate(x, add) <- value

# S4 method for class 'giottoSankeyPlan,logical,numeric'
sankeyRelate(x, add) <- value

# S4 method for class 'giottoSankeyPlan,logical,character'
sankeyRelate(x, add) <- value

# S4 method for class 'giottoSankeyPlan,missing,ANY'
sankeyRelate(x) <- value

# S4 method for class 'giottoSankeyPlan,missing,NULL'
sankeyRelate(x) <- value
```

## Arguments

- x:

  giottoSankeyPlan object

- ...:

  additional params to pass

- add:

  logical. whether relation to add through `value` should be appended or
  replace all existing relations

- value:

  numerical vector (zero indexed) of sets to compare

## Value

giottoSankeyPlan
