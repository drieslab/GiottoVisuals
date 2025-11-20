# Optimized image resampling

Downsample terra-based images for plotting. Uses
[`spatSample`](https://rspatial.github.io/terra/reference/sample.html)
to load onlya portion of the original image, speeding up plotting and
lowering memory footprint.

Default behavior of `spatSample` is to crop if only a smaller ROI is
needed for plotting followed by the sampling process in order to reduce
wasted sampling by focusing the sample space. For very large ROIs, this
crop can be time intensive and require writing to disk.

This function examines the ROI dimensions as defined through the limits
of the spatial locations to be plotted, and decides between the
following two methods in order to avoid this issue:

- **Method A.** First crop original image, then sample `max_sample`
  (default = 5e5) values to generate final image. Intended for smaller
  ROIs. Force usage of this method by setting `flex_resample = FALSE`

- **Method B.** First oversample, then crop. Intended for larger ROIs.
  Base sample size is `max_sample`, which is then multiplied by a scale
  factor \>1 that increases the smaller the ROI is and is defined by:
  original dimensions/crop dimensions where the larger ratio between x
  and y dims is chosen. Scale factor is capped by `max_resample_scale`

Control points for this function are set by `max_crop` which decides the
max ROI area after which switchover to method B happens in order to
avoid laborious crops and `max_resample_scale` which determines the
maximum scale factor for number of values to sample. Both values can be
adjusted depending on system resources. Additionally, `flex_resample`
determines if this switching behavior happens. When set to `FALSE`, only
method A is used.

## Usage

``` r
.auto_resample_gimage(
  img,
  plot_ext = NULL,
  img_border = 0.125,
  crop_ratio_fun = .img_to_crop_ratio_gimage,
  sample_fun = .sample_gimage,
  flex_resample = TRUE,
  max_sample = getOption("giotto.plot_img_max_sample", 5e+05),
  max_crop = getOption("giotto.plot_img_max_crop", 1e+08),
  max_resample_scale = getOption("giotto.plot_img_max_resample_scale", 100)
)
```

## Arguments

- img:

  giotto image to plot

- plot_ext:

  extent of plot (defaults to the image extent)

- img_border:

  if not 0 or FALSE, expand plot_ext by this percentage on each side
  before applying crop on image. See details

- flex_resample:

  logical. Default = TRUE. Forces usage of method A when FALSE.

- max_sample:

  numeric. Default = 5e5. Maximum n values to sample from the image. If
  larger than `max_crop`, will override `max_crop.` Globally settable
  with the option "giotto.plot_img_max_sample"

- max_crop:

  numeric. Default = 1e8. Maximum crop size (px area) allowed for
  **method A** before switching to **method B** (see description).
  Globally settable with option "giotto.plot_img_max_crop"

- max_resample_scale:

  numeric. Default = 100. Maximum scalefactor allowed to be applied on
  `max_sample` in order to oversample when compensating for decreased
  resolution when cropping after sampling. Globally settable with option
  "giotto.plot_img_max_resample_scale".

## Value

a giotto image cropped and resampled properly for plotting

## Details

**img_border** expand ext to use for plotting the image. This makes it
so that the image is not cut off sharply at the edge of the plot extent.
Needed since plots often define extent by centroids, and polygons may
hang over the edge of the extent.

## See also

[`spatSample`](https://rspatial.github.io/terra/reference/sample.html)

## Examples

``` r
if (FALSE) { # \dontrun{
img <- GiottoData::loadSubObjectMini("giottoLargeImage")
.auto_resample_gimage(img)
} # }
```
