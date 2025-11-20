# aes_string2

Internal replacement for the removed
[`ggplot2::aes_string()`](https://ggplot2.tidyverse.org/reference/aes_.html)
pre-v4.0

## Usage

``` r
aes_string2(x, y, ...)
```

## Arguments

- x, y, ...:

  List of name-value pairs in the form `aesthetic = variable` describing
  which variables in the layer data should be mapped to which aesthetics
  used by the paired geom/stat.

  - Mapped values should be provided as a single character input.

  - Non-character inputs will not be altered and will be processed as
    usual.

  - Expressions to be evaluated may be passed as a character string to
    be interpreted via [`str2lang()`](https://rdrr.io/r/base/parse.html)

## Value

An S7 object representing a list with class mapping.

## Examples

``` r
ggplot2::ggplot(iris) +
ggplot2::geom_point(aes_string2(x = "Sepal.Length", y = "Petal.Length"))
```
