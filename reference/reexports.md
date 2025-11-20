# Objects exported from other packages

These objects are imported from other packages. Follow the links below
to see their documentation.

- colorRamp2:

  [`colorRamp2`](https://rdrr.io/pkg/colorRamp2/man/colorRamp2.html)

- cowplot:

  [`plot_grid`](https://wilkelab.org/cowplot/reference/plot_grid.html)

- ggrepel:

  [`geom_label_repel`](https://ggrepel.slowkow.com/reference/geom_text_repel.html),
  [`geom_text_repel`](https://ggrepel.slowkow.com/reference/geom_text_repel.html)

- GiottoUtils:

  [`getDistinctColors`](https://drieslab.github.io/GiottoUtils/reference/getDistinctColors.html),
  [`getRainbowColors`](https://drieslab.github.io/GiottoUtils/reference/getRainbowColors.html)

## Value

a function to create continous colors

## Examples

``` r
colorRamp2::colorRamp2(breaks = seq_len(2), colors = c("blue", "red"))
#> function (x = NULL, return_rgb = FALSE, max_value = 1) 
#> {
#>     if (is.null(x)) {
#>         stop("Please specify `x`.")
#>     }
#>     att = attributes(x)
#>     if (is.data.frame(x)) 
#>         x = as.matrix(x)
#>     l_na = is.na(x)
#>     if (all(l_na)) {
#>         return(rep(NA, length(l_na)))
#>     }
#>     x2 = x[!l_na]
#>     x2 = ifelse(x2 < breaks[1], breaks[1], ifelse(x2 > breaks[length(breaks)], 
#>         breaks[length(breaks)], x2))
#>     ibin = .bincode(x2, breaks, right = TRUE, include.lowest = TRUE)
#>     res_col = character(length(x2))
#>     for (i in unique(ibin)) {
#>         l = ibin == i
#>         res_col[l] = .get_color(x2[l], breaks[i], breaks[i + 
#>             1], colors[i, ], colors[i + 1, ], space = space)
#>     }
#>     res_col = paste(res_col, transparency_str[1], sep = "")
#>     if (return_rgb) {
#>         res_col = t(col2rgb(as.vector(res_col), alpha = TRUE)/255)
#>         return(res_col)
#>     }
#>     else {
#>         res_col2 = character(length(x))
#>         res_col2[l_na] = NA
#>         res_col2[!l_na] = res_col
#>         attributes(res_col2) = att
#>         return(res_col2)
#>     }
#> }
#> <bytecode: 0x557a3a9bd2d0>
#> <environment: 0x557a3a981720>
#> attr(,"breaks")
#> [1] 1 2
#> attr(,"colors")
#> [1] "#0000FFFF" "#FF0000FF"
#> attr(,"transparency")
#> [1] 0
#> attr(,"space")
#> [1] "LAB"
```
