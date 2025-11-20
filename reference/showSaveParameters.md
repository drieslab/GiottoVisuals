# showSaveParameters

Description of Giotto saving options, links to
[`all_plots_save_function`](https://drieslab.github.io/GiottoVisuals/reference/plot_save.md)

## Usage

``` r
showSaveParameters()
```

## Value

Instructions on how to use the automatic plot saving options within
Giotto

## Examples

``` r
showSaveParameters()
#> This is a simple guide to help you automatically saving plots. 
#> Importantly, defaults for all these parameters can be set at
#>     the beginning with createGiottoInstructions() 
#> See
#>     https://rubd.github.io/Giotto/articles/instructions_and_plotting.html
#>     for more information and examples 
#>  
#> Each plotting function in Giotto has 4 important parameters for
#>     showing and/or saving a plot: 
#> 
#>         - show_plot: TRUE or FALSE, show the plot to the console
#>         - return_plot: TRUE or FALSE, return the plot to the console
#>         (e.g. to further modify or save the plot
#>         - save_plot: TRUE or FALSE, automatically save the plot
#>         - save_param: a list of parameters that can be set 
#> The following list of parameters can be provided to save_param: 
#> 
#>         - save_dir: directory to save the plot to
#>         - save_folder: if not NULL, a subfolder within save_dir that will
#>         be created to save the plot to
#>         - save_name: name of the plot (no extension needed, see save_format)
#>         - save_format: picture format to use, default is .png
#>         - ncol: number of columns for multiplots
#>         - nrow: number of rows for multiplot
#>         - scale: scale of plots
#>         - base_width: width of plot
#>         - base_height: height of plot
#>         - base_aspect_ratio: ratio of plot
#>         - units: plotting units (e.g. in)
#>         - dpi: dpi for each plot if plot is in raster format
#> Example: 
#> 
#>         plotfunction(...,
#>                     save_plot = TRUE,
#>                     save_param = list(save_name = 'favorite_name',
#>                     units = 'png'))
```
