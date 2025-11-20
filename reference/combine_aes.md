# Combine ggplot2 aesthetics

Utility for combining ggplot2 `aes` lists. Uses the last provided value
when aes names overlap.

## Usage

``` r
combine_aes(..., warn_duplicates = TRUE)
```

## Arguments

- ...:

  one or more objects of class `uneval` (output from
  [`ggplot2::aes()`](https://ggplot2.tidyverse.org/reference/aes.html))

- warn_duplicates:

  logical. Warn when aes names overlap

## Value

uneval object

## See also

Other ggplot2 plotting wrangling functions:
[`gg_param()`](https://drieslab.github.io/GiottoVisuals/reference/gg_param.md)

## Examples

``` r
a <- ggplot2::aes(a = a1, b = b1, c = c1)
b <- ggplot2::aes(x = x1, y = y1, a = a2, c = c2)

# warnings turned off
combine_aes(a, b, warn_duplicates = FALSE) # b values used for a,c
#> $b
#> <quosure>
#> expr: ^b1
#> env:  0x557a4f3239c0
#> 
#> $x
#> <quosure>
#> expr: ^x1
#> env:  0x557a4f3239c0
#> 
#> $y
#> <quosure>
#> expr: ^y1
#> env:  0x557a4f3239c0
#> 
#> $a
#> <quosure>
#> expr: ^a2
#> env:  0x557a4f3239c0
#> 
#> $c
#> <quosure>
#> expr: ^c2
#> env:  0x557a4f3239c0
#> 
#> attr(,"class")
#> [1] "uneval"
combine_aes(b, a, warn_duplicates = FALSE) # a values used for a,c
#> $x
#> <quosure>
#> expr: ^x1
#> env:  0x557a4f3239c0
#> 
#> $y
#> <quosure>
#> expr: ^y1
#> env:  0x557a4f3239c0
#> 
#> $a
#> <quosure>
#> expr: ^a1
#> env:  0x557a4f3239c0
#> 
#> $b
#> <quosure>
#> expr: ^b1
#> env:  0x557a4f3239c0
#> 
#> $c
#> <quosure>
#> expr: ^c1
#> env:  0x557a4f3239c0
#> 
#> attr(,"class")
#> [1] "uneval"
```
