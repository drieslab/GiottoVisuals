# Spatial in-situ density plot - single

low level function to plot density plots at the spatial in situ level

## Usage

``` r
.spatInSituPlotDensity_single(
  gobject,
  data,
  feat = NULL,
  sdimx = "x",
  sdimy = "y",
  alpha = 0.95,
  show_polygon = TRUE,
  polygon_feat_type = "cell",
  polygon_color = "black",
  polygon_fill = NULL,
  polygon_fill_as_factor = NULL,
  polygon_alpha = 0.5,
  polygon_size = 0.5,
  coord_fix_ratio = NULL,
  axis_text = 8,
  axis_title = 8,
  legend_text = 6,
  background_color = "black"
)
```

## Value

ggplot

## Details

This function can plot one feature for one modality.
