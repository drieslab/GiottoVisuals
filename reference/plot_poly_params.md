# Params documentation template: plot_poly_params

Params documentation template: plot_poly_params

## Arguments

- show_polygon:

  overlay polygon information (e.g. cell shape)

- use_overlap:

  use polygon and feature coordinates overlap results

- polygon_feat_type:

  feature type associated with polygon information

- polygon_color:

  color for polygon border. Set `NA` to remove border

- polygon_bg_color:

  color for polygon background (overruled by polygon_fill)

- polygon_fill:

  character. what to color to fill polgyons by (e.g. metadata col or
  spatial enrichment col)

- polygon_fill_gradient:

  polygon fill gradient colors given in order from low to high

- polygon_fill_gradient_midpoint:

  value to set as gradient midpoint (optional). If left as `NULL`, the
  median value detected will be chosen

- polygon_fill_gradient_style:

  either 'divergent' (midpoint is used in color scaling) or 'sequential'
  (scaled based on data range)

- polygon_fill_as_factor:

  is fill color a factor

- polygon_fill_code:

  code to color the fill column

- polygon_alpha:

  alpha of polygon

- polygon_line_size:

  line width of the polygon's outline

## Value

ggplot
