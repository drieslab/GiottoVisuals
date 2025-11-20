# Plot saving

Functions to save plots to directory of interest.
`all_plots_save_function()` is used for plot saving operations.
`gpsparam()` is used to generate a set of save parameters and filepath
based on available parameter and `giottoInstructions` values.

## Usage

``` r
all_plots_save_function(
  gobject,
  plot_object,
  save_dir = NULL,
  save_folder = NULL,
  save_name = NULL,
  default_save_name = "giotto_plot",
  save_format = NULL,
  show_saved_plot = FALSE,
  ncol = 1,
  nrow = 1,
  scale = 1,
  base_width = NULL,
  base_height = NULL,
  base_aspect_ratio = NULL,
  units = NULL,
  dpi = NULL,
  limitsize = TRUE,
  plot_count = NULL,
  GPSPARAM = NULL,
  ...
)

gpsparam(
  instructions,
  type = c("gg", "plotly", "general"),
  save_dir = NULL,
  save_folder = NULL,
  save_name = NULL,
  default_save_name = "giotto_plot",
  save_format = NULL,
  dpi = NULL,
  base_width = NULL,
  base_height = NULL,
  base_aspect_ratio = NULL,
  units = NULL,
  plot_count = NULL,
  ...
)
```

## Arguments

- gobject:

  giotto object or giottoInstructions

- plot_object:

  ggplot object to plot

- save_dir:

  directory to save to

- save_folder:

  folder in save_dir to save to

- save_name:

  name of plot

- default_save_name:

  default name to save a plot

- save_format:

  format (e.g. png, tiff, pdf, ...)

- show_saved_plot:

  load & display the saved plot

- ncol:

  number of columns for multiplots

- nrow:

  number of rows for multiplot

- scale:

  scale of plots

- base_width:

  width of plot

- base_height:

  height of plot

- base_aspect_ratio:

  aspect ratio of plot

- units:

  plotting units (e.g. in)

- dpi:

  dpi for each plot if plot is in raster format

- limitsize:

  When TRUE (the default), ggsave will not save images larger than 50x50
  inches, to prevent the common error of specifying dimensions in
  pixels.

- plot_count:

  manually set the plot count that is appended to a default_save_name

- GPSPARAM:

  `giotto_plot_save_param` object. If provided, will be used instead of
  most other general save params. (save_dir, save_folder, save_name,
  default_save_name, save_format, base_width, base_height,
  base_aspect_ratio, units, dpi, plot_count)

- ...:

  additional parameters to pass downstream save functions.
  [`cowplot::save_plot()`](https://wilkelab.org/cowplot/reference/save_plot.html)
  is used for `ggplot2` plots. grDevices png, tiff svg, pdf is used for
  base and general saving

- instructions:

  `giotto` or `giottoInstructions` object

- type:

  `character`. One of `"gg"', '"plotly"', '"general"` to designate which
  type of plot to save. This affects which types of outputs are
  possible.

## Value

`all_plots_save_function` returns a plot file. `gpsparam` returns a
`giotto_plot_save_param` object

## See also

[`showSaveParameters`](https://drieslab.github.io/GiottoVisuals/reference/showSaveParameters.md)
[`save_plot`](https://wilkelab.org/cowplot/reference/save_plot.html)
[`png`](https://rdrr.io/r/grDevices/png.html)
[`tiff`](https://rdrr.io/r/grDevices/png.html)
[`pdf`](https://rdrr.io/r/grDevices/pdf.html)
[`svg`](https://rdrr.io/r/grDevices/cairo.html)

## Examples

``` r
g <- GiottoData::loadGiottoMini("visium")
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
df <- data.frame(x = rnorm(5), y = rnorm(5))
g_plot <- ggplot2::ggplot(df, ggplot2::aes(x, y)) +
    ggplot2::geom_point()
all_plots_save_function(g, g_plot)
```
