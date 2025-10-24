# GiottoVisuals 0.2.14

## changes
- change `spatInSituPlotPoints()` param `spat_enr_names` to `spat_enr_name`

## enhancements
- `show_axes` param for `spatInSituPlotPoints()`

# GiottoVisuals 0.2.13 (2025/09/30)

## bug fixes
- update for removal of `ggplot2::aes_string()` in ggplot2 v4 [#1192](https://github.com/drieslab/Giotto/issues/1192) by jdub0211

## changes
- replacement of argument radius by pie_scale in `spatDeconvPlot()` to modify pie size.

# GiottoVisuals 0.2.12 (2025/05/06)

## new
- `ridgePlot()`

## bug fixes
- fix `spatInSituPlotDensity()` `polygon_alpha` default setting when polygons plotted last

## enhancements
- requested images not within the plotting window are now handled as warning instead of erroring
- `y_axis_title` param added to `plotMetaDataCellsHeatmap()`
- `spatInSituPlotDensity()` `xlim`/`ylim` now crops on polys
- `spatInSituPlotDensity()` feature plotting via `spatValues()`retrieval

# GiottoVisuals 0.2.11 (2025/01/17)

## enhancements
- improve efficiency of `spatInSituPlotDensity()`
- `use_overlap` param for `spatInSituPlotDensity()` to allow the unoverlapped data to be used for density

## bug fixes
- fix color code/name checking to allow hex codes in `cell_color` plotting param.

# GiottoVisuals 0.2.10 (2024/12/04)

## bug fixes
- fix missing `e` extent error during `spatInSituPlotPoints()` with `show_image = TRUE` introduced in v0.2.9 [#96](https://github.com/drieslab/GiottoVisuals/issues/96) by kunleng

# GiottoVisuals 0.2.9 (2024/11/18)

## bug fixes
- `spatInSituPlotPoints()` `xlim` and `ylim` params now also affect image resampling

## enhancements
- `group_by` and `group_by_subset` for `dimFeatPlot2D()` [#1069](https://github.com/drieslab/Giotto/issues/1069) by xhNorthwestern
- image plotting will now scale values to the 99th percentile when a specific max intensity is not set.

# GiottoVisuals 0.2.8 (2024/11/14)

## enhancements
- `spatPlot3D()` now works with non-categorical data. Uses same params as `spatPlot2D()` for color/gradient selection

## changes
- `spatPlot3D()` `other_point_size` default changed to 3 from 0.5 which was too hard to notice.


# GiottoVisuals 0.2.7 (2024/11/08)

## enhancements
- scattermore plotting for `spatPlot2D()` and `spatFeatPlot2D()`

## bug fixes
- fix color scaling bug for `spatFeatPlot2D()` introduced in 0.2.6

# GiottoVisuals 0.2.6 (2024/10/27)

## new
- `combine_aes()` for combining ggplot2 mappings in a last item wins manner. Allows more than 2 aes to be combined at the same time and provides an optional informative warning
- `gg_params()` for combining and sorting ggplot2 mappings, toplevel params, and data into an arg list for plotting.


# GiottoVisuals 0.2.5 (2024/09/27)

## new
- `gpsparam()` for generating an object containing plot saving parameters
- `cowplot::plot_grid()` re-exported
- `dotPlot()` visualization

## bug fixes
- fix `coord_fix_ratio` passing in `spatFeatPlot2D()` [#972](https://github.com/drieslab/Giotto/issues/972) by kaizen89

# GiottoVisuals 0.2.4 (2024/07/26)

## enhancements
- `giottoLargeImage` `max_window` and `colors` slot info is now followed during ggplot plotting
- `giottoAffineImage` compatibility for giotto ggplot2 plotting functions
- `gg_annotation_raster()` now also performs `geom_blank()` with the extent provided through `ext` param. This can be turned off by setting `geom_blank() = FALSE`

## new
- `geom_text_repel()` and `geom_label_repel()` from `ggplot2` are now re-exported

# GiottoVisuals 0.2.3 (2024/05/28)

## bug fixes
- hotfix for sprintf numerics usage %d -> %f

# GiottoVisuals 0.2.2 (2024/05/22)

## breaking changes
- option `"giotto.color_c_pal"` has been split into `"giotto.color_cd_pal"` and `"giotto.color_cs_pal"` for divergent and sequential continuous palettes

## enhancements
- some options are now initialized on library load to make them easier to access

# GiottoVisuals 0.2.0 (2024/05/13)

## changes
- _GiottoClass >= 0.3.0_ is now required. (object no longer has `@largeImages` slot)
- `largeImage_name` arg is deprecated. `image_name` arg should be used instead
- spatial y dim values are not vertically plotted
- deprecated `spatDimGenePlot3D()`, `spatGenePlot3D()`, `dimGenePlot3D` in favor of the 'feat' naming scheme

## bug fixes
- removed centroid point that unintentionally gets plotted in polygons

## enhancements
- `theme_param` arg has been added to some plotting functions that provides access to `ggplot2::theme()` finetuning
- `gg_annotation_raster()` now performs plot extent detection and resampling of largeImages
- resampling args are now globally settable (see `?auto_image_resample`)
- `polygon_alpha` default is now 1 when plotting polys without images, and 0.5 when plotting with images.


# GiottoVisuals 0.1.7 (2024/03/11)

## Changes
- Change default values show_plot = NA, return_plot = NA, save_plot = NA -> show_plot = NULL, return_plot = NULL, save_plot = NULL.
- Add examples to exported functions
- Update License

# GiottoVisuals 0.1.6 (2024/03/07)

## bug fixes
- fix `spatPlot2D()` and `spatFeatPlot2D()` largeImage plotting when using `group_by`
- fix `edge_alpha` arg in `spatFeatPlot2D()`

## new
- `mixRGB()` vectorized additive mixing in RGB space
- `mixHSV()` vectorized color mixing in HSV space



# GiottoVisuals 0.1.4 (2024/01/25)
## bug fixes
- fix plotting color gradient when using arg `point_shape = "no_border"`
- fix image NA value [#865](https://github.com/drieslab/Giotto/issues/865) by rbutleriii

## new
- `gg_annotation_raster()` internal generic for adding a `giottoImage`, `giottoLargeImage`, or `list` thereof to a `ggplot` object

# GiottoVisuals 0.1.2 (2023/01/12)

## bug fixes
- fix `ComplexHeatmap` saving size issue [#861](https://github.com/drieslab/Giotto/issues/861) by rbutleriii

# GiottoVisuals 0.1.1 (2023/12/16)

## Breaking Changes
- Removed: `getDistinctColors()` to *GiottoUtils*

## Added
- Add: `getDistinctColors()` and `getRainbowColors()` as re-exports from *GiottoUtils*

## Changes
- Changed: Package internal functions now have `.` prefix
- Changed: *GiottoUtils* and *GiottoClass* moved to Imports
- Changed: Other internal function naming changes to bring in line with updates to *GiottoUtils*


# GiottoVisuals 0.1.0 (23/11/29)

Initial release
