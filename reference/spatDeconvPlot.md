# spatDeconvPlot

Visualize cell type enrichment / deconvolution results in a scatterpie

## Usage

``` r
spatDeconvPlot(
  gobject,
  spat_unit = NULL,
  feat_type = NULL,
  deconv_name = "DWLS",
  show_image = FALSE,
  gimage = NULL,
  image_name = NULL,
  largeImage_name = NULL,
  spat_loc_name = NULL,
  sdimx = "sdimx",
  sdimy = "sdimy",
  cell_color_code = NULL,
  line_color = NA,
  pie_scale = 0.35,
  alpha = 1,
  legend_text = 8,
  background_color = "white",
  title = NULL,
  axis_text = 8,
  axis_title = 8,
  coord_fix_ratio = 1,
  show_plot = NULL,
  return_plot = NULL,
  save_plot = NULL,
  save_param = list(),
  theme_param = list(),
  default_save_name = "spatDeconvPlot"
)
```

## Arguments

- gobject:

  giotto object

- spat_unit:

  spatial unit (e.g. "cell")

- feat_type:

  feature type (e.g. "rna", "dna", "protein")

- deconv_name:

  name of deconvolution results to use

- show_image:

  show a tissue background image

- gimage:

  a giotto image

- image_name:

  name of a giotto image

- largeImage_name:

  name of a giottoLargeImage

- spat_loc_name:

  name of spatial locations

- sdimx:

  x-axis dimension name (default = 'sdimx')

- sdimy:

  y-axis dimension name (default = 'sdimy')

- cell_color_code:

  character. discrete colors to use. palette to use or named vector of
  colors

- line_color:

  color of line within pie charts

- pie_scale:

  amount to scale the pie size if there is no radius mapping exists

- alpha:

  alpha of pie charts

- legend_text:

  size of legend text

- background_color:

  color of plot background

- title:

  title for plot (default = deconv_name)

- axis_text:

  size of axis text

- axis_title:

  size of axis title

- coord_fix_ratio:

  fix ratio between x and y-axis

- show_plot:

  logical. show plot

- return_plot:

  logical. return ggplot object

- save_plot:

  logical. save the plot

- save_param:

  list of saving parameters, see
  [`showSaveParameters`](https://drieslab.github.io/GiottoVisuals/reference/showSaveParameters.md)

- theme_param:

  list of additional params passed to
  [`ggplot2::theme()`](https://ggplot2.tidyverse.org/reference/theme.html)

- default_save_name:

  default save name for saving, don't change, change save_name in
  save_param

## Value

ggplot
