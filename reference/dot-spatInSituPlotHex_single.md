# Spatial in-situ hexbin plot - single

function to plot hexbins at the spatial in situ level

## Usage

``` r
.spatInSituPlotHex_single(
  gobject,
  feat = NULL,
  feat_type = "rna",
  sdimx = "x",
  sdimy = "y",
  binwidth = NULL,
  min_axis_bins = NULL,
  alpha = 0.5,
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
