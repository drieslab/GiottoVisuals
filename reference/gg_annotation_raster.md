# Append image to ggplot as annotation_raster

Add a spatially mapped image to a *ggplot2* `gg` object. For terra-based
images, the image will be a cropped and sampled version of the full size
image on disk that has sufficient resolution for the size of the plot
requested.

## Usage

``` r
# S4 method for class 'ggUnionClass,list'
gg_annotation_raster(ggobj, gimage, ext = NULL, geom_blank = TRUE, ...)

# S4 method for class 'ggUnionClass,giottoImage'
gg_annotation_raster(ggobj, gimage, ext = NULL, geom_blank = TRUE, ...)

# S4 method for class 'ggUnionClass,giottoLargeImage'
gg_annotation_raster(ggobj, gimage, ext = NULL, geom_blank = TRUE, ...)

# S4 method for class 'ggUnionClass,giottoAffineImage'
gg_annotation_raster(ggobj, gimage, ext = NULL, geom_blank = TRUE, ...)
```

## Arguments

- ggobj:

  ggplot2 `gg` object

- gimage:

  `giottoLargeImage`, `giottoImage` or `list` thereof

- ext:

  Object that responds to
  [`ext()`](https://rspatial.github.io/terra/reference/ext.html).
  Defines the plot spatial ROI This extent defines which portions of the
  image(s) will be plotted/should be sampled for. The default is the
  same extent as the image.

- geom_blank:

  logical. Whether to apply `[ggplot2::geom_blank()]` to the `gg` object
  so that the image can be plotted by itself.

- ...:

  additional params to pass

## Value

`gg` object with images to plot appended as annotation rasters

## Details

No ... params are implemented for `giottoImage`.  
... params for `giottoLargeImage` passes to automated resampling params
see
[`?auto_image_resample`](https://drieslab.github.io/GiottoVisuals/reference/auto_image_resample.md)
for details

## Examples

``` r
gimg <- GiottoData::loadSubObjectMini("giottoLargeImage")
gg <- ggplot2::ggplot()
out <- GiottoVisuals::gg_annotation_raster(gg, gimg)
print(out)
```
