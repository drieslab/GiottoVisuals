# Generate a simple palette function

Simple palette function generator. Creates a function with param n that
dictates how many colors to return from the provided vector of
hexadecimal color values. Generated functions send warning if there are
not enough colors to use and it needs to recycle values.

## Usage

``` r
simple_palette_factory(col, rev = FALSE, strategy = "interpolate")
```

## Arguments

- col:

  character vector. Hexadecimal color codes

- rev:

  whether to reverse order of vector

- strategy:

  policy when insufficient colors are available

## Value

a function

## See also

[`set_default_color_discrete()`](https://drieslab.github.io/GiottoVisuals/reference/set_default_color_discrete.md)

## Examples

``` r
simple_palette_factory(col = "#eb4034")
#> function (n) 
#> {
#>     get_continuous_colors(col = col, n = n, strategy = strategy)
#> }
#> <bytecode: 0x557a59942708>
#> <environment: 0x557a6e94eaa0>
```
