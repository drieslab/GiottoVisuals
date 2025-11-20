# Show Giotto color instructions

Show the color instructions that are settable in Giotto. A data.table of
the information is invisibly returned

## Usage

``` r
showColorInstructions()
```

## Value

data.table of Giotto color option information

## Examples

``` r
showColorInstructions()
#> 
#> option      :  'cell_color_d_pal' 
#> default     :  NULL (distinct colors) 
#> description :  Cell: color palette to use for discrete color values.
#>         Can be supplied as a the name of a palette accessible by `getColors()`,
#>         custom color vector, or an external function with a 'n' colors
#>         requested param 
#> 
#> option      :  'poly_color_d_pal' 
#> default     :  NULL (distinct colors) 
#> description :  Poly: color palette to use for discrete color values.
#>         Can be supplied as a the name of a palette accessible by `getColors()`,
#>         custom color vector, or an external function with a 'n' colors
#>         requested param 
#> 
#> option      :  'feat_color_pal' 
#> default     :  NULL (distinct colors) 
#> description :  Feat: color palette to use for discrete color values.
#>         Can be supplied as a the name of a palette accessible by `getColors()`,
#>         custom color vector, or an external function with a 'n' colors
#>         requested param 
#> 
#> option      :  'heatmap_clus_color_pal' 
#> default     :  NULL (distinct colors) 
#> description :  Heatmap Clusters: color palette to use for discrete color values.
#>         Can be supplied as a the name of a palette accessible by `getColors()`,
#>         custom color vector, or an external function with a 'n' colors
#>         requested param 
#> 
#> option      :  'cell_color_d_rev' 
#> default     :  FALSE 
#> description :  Cell: whether discrete color values should be reversed 
#> 
#> option      :  'poly_color_d_rev' 
#> default     :  FALSE 
#> description :  Poly: whether discrete color values should be reversed 
#> 
#> option      :  'feat_color_rev' 
#> default     :  FALSE 
#> description :  Feat: whether discrete color values should be reversed 
#> 
#> option      :  'heatmap_clus_color_rev' 
#> default     :  FALSE 
#> description :  Heatmap Clusters: whether discrete color values should be reversed 
#> 
#> option      :  'cell_color_d_strategy' 
#> default     :  'interpolate' 
#> description :  Cell: 'interpolate', 'recycle', or 'cutoff'. Policy to use when more
#>         colors are requested than exist within palette. 
#> 
#> option      :  'poly_color_d_strategy' 
#> default     :  'interpolate' 
#> description :  Poly: 'interpolate', 'recycle', or 'cutoff'. Policy to use when more
#>         colors are requested than exist within palette. 
#> 
#> option      :  'feat_color_strategy' 
#> default     :  'interpolate' 
#> description :  Feat: 'interpolate', 'recycle', or 'cutoff'. Policy to use when more
#>         colors are requested than exist within palette. 
#> 
#> option      :  'heatmap_clus_color_strategy' 
#> default     :  'interpolate' 
#> description :  Heatmap Clusters: 'interpolate', 'recycle', or 'cutoff'. Policy to
#>         use when more colors are requested than exist within palette. 
#> 
#> option      :  'cell_color_c_pal' 
#> default     :  c('blue', 'white', 'red') 
#> description :  Cell: color palette to use for continuous color values. Can be
#>         supplied as a the name of a palette accessible by `getColors()`,
#>         custom color vector, or an external function with a 'n' colors
#>         requested param 
#> 
#> option      :  'poly_color_c_pal' 
#> default     :  c('blue', 'white', 'red') 
#> description :  Poly: color palette to use for continuous color values. Can be
#>         supplied as a the name of a palette accessible by `getColors()`,
#>         custom color vector, or an external function with a 'n' colors
#>         requested param 
#> 
#> option      :  'cell_color_c_rev' 
#> default     :  FALSE 
#> description :  Cell: whether continuous color values should be reversed 
#> 
#> option      :  'poly_color_c_rev' 
#> default     :  FALSE 
#> description :  Poly: whether continuous color values should be reversed 
#> 
#> option      :  'heatmap_color_pal' 
#> default     :  c('blue', 'white', 'red') 
#> description :  Heatmap: color palette to use for continuous color values.
#>         Can be supplied as a the name of a palette accessible by `getColors()`,
#>         custom color vector, or an external function with a 'n' colors
#>         requested param 
#> 
#> option      :  'heatmap_color_rev' 
#> default     :  FALSE 
#> description :  Heatmap: whether continuous color values should be reversed 
```
