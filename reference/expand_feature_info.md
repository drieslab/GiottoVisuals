# expand_feature_info

low level function to expand feature coordinates by adding jitter to
coordinates

## Usage

``` r
expand_feature_info(
  spatial_feat_info,
  expand_counts = FALSE,
  count_info_column = "count",
  jitter = c(0, 0),
  verbose = TRUE
)
```

## Arguments

- spatial_feat_info:

  a data.table of spatial feature information

- expand_counts:

  logical. whether points should be expanded based on count

- jitter:

  numeric vector. amount of jitter to add

- verbose:

  be verbose

## Value

data.table

## Examples

``` r
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
x <- GiottoClass::getFeatureInfo(g)
x <- data.table::as.data.table(x)
```
