#' @name gg_annotation_raster
#' @keywords internal
#' @title Append image to ggplot as annotation_raster
#' @param ggobj ggplot2 `gg` object
#' @param gimage `giottoLargeImage`, `giottoImage` or `list` thereof
#' @param \dots additional params to pass
#' @details
#' No ... params are implemented for `giottoImage`. \cr ... params for
#' `giottoLargeImage` passes to automated resampling params see
#' `?auto_image_resample` for details
#' @return `gg` object with images to plot appended as annotation rasters
NULL

#' @rdname gg_annotation_raster
setMethod(
    "gg_annotation_raster",
    signature(ggobj = "gg", gimage = "list"),
    function(ggobj, gimage, ...) {
        for (i in seq_along(gimage)) {
            ggobj <- gg_annotation_raster(ggobj, gimage[[i]], ...)
        }
        return(ggobj)
    }
)

#' @rdname gg_annotation_raster
setMethod(
    "gg_annotation_raster",
    signature(ggobj = "gg", gimage = "giottoImage"),
    function(ggobj, gimage, ...) {
        # extract min and max from object
        my_xmax <- gimage@minmax[1]
        my_xmin <- gimage@minmax[2]
        my_ymax <- gimage@minmax[3]
        my_ymin <- gimage@minmax[4]

        # convert giotto image object into array
        img_array <- as.numeric(gimage@mg_object[[1]])

        # extract adjustments from object
        xmax_b <- gimage@boundaries[1]
        xmin_b <- gimage@boundaries[2]
        ymax_b <- gimage@boundaries[3]
        ymin_b <- gimage@boundaries[4]

        # append to ggobj
        ggobj <- ggobj + annotation_raster(
            img_array,
            xmin = my_xmin - xmin_b, xmax = my_xmax + xmax_b,
            ymin = my_ymin - ymin_b, ymax = my_ymax + ymax_b
        )

        # TODO geom_raster to accommodate single-channel
        return(ggobj)
    }
)

#' @rdname gg_annotation_raster
#' @param ext Object that responds to `ext()`. Defines the plot spatial ROI
#' that the image should be sampled for.
setMethod(
    "gg_annotation_raster",
    signature(ggobj = "gg", gimage = "giottoLargeImage"),
    function(ggobj, gimage, ext = NULL, ...) {

        # apply plot ext
        if (!is.null(ext)) {
            gimage <- .auto_resample_gimage(
                img = gimage,
                plot_ext = ext,
                ...
            )
        }

        # get plotting minmax
        extent <- terra::ext(gimage@raster_object)[seq_len(4)]
        xmin <- extent[["xmin"]]
        xmax <- extent[["xmax"]]
        ymin <- extent[["ymin"]]
        ymax <- extent[["ymax"]]

        # convert raster object into array with 3 channels
        img_array <- terra::as.array(gimage@raster_object)

        # TODO: check if required, fixes NaN values
        # replacing NA's by zero or another value directly in raster object?
        # raster[is.na(raster[])] <- 0
        if (is.nan(max(img_array[, , 1]))) {
            img_array[, , 1][is.nan(img_array[, , 1])] <- max(img_array[, , 1],
                na.rm = TRUE
            )
        }

        if (dim(img_array)[3] > 1) {
            if (is.nan(max(img_array[, , 2]))) {
                img_array[, , 2][is.nan(img_array[, , 2])] <-
                    max(img_array[, , 2], na.rm = TRUE)
            }
        }

        if (dim(img_array)[3] > 2) {
            if (is.nan(max(img_array[, , 3]))) {
                img_array[, , 3][is.nan(img_array[, , 3])] <-
                    max(img_array[, , 3], na.rm = TRUE)
            }
        }

        img_array <- img_array / max(img_array, na.rm = TRUE)
        if (dim(img_array)[3] == 1) {
            img_array_RGB <- array(NA, dim = c(dim(img_array)[seq_len(2)], 3))
            img_array_RGB[, , seq_len(3)] <- img_array
        } else {
            img_array_RGB <- img_array
        }

        # handle NA values
        img_array_RGB[is.na(img_array_RGB)] <- 0

        # append to ggobj
        ggobj <- ggobj + annotation_raster(
            img_array_RGB,
            xmin = xmin, xmax = xmax,
            ymin = ymin, ymax = ymax
        )

        # TODO geom_raster to accommodate single-channel
        return(ggobj)
    }
)






# Internals ####

# returns the spatial extent needed for the plot
# ... passes to ext() `giotto` method
.guess_plot_extent <- function(
        gobject, spat_unit = NULL, spat_loc_name = NULL, ext = NULL, ...
    ) {

    if (!is.null(ext)) ext <- ext(ext) # normalize to `SpatExtent` class
    # if ext already given, directly return
    if (inherits(ext, "SpatExtent")) return(ext)

    # find extent from one of poly, spatlocs, points, in that order of pref
    e <- ext(
        gobject,
        spat_unit = spat_unit,
        all_data = FALSE,
        verbose = FALSE,
        name = list(spatlocs = spat_loc_name),
        # `name` only passes to `getSpatialLocations()` if spatlocs are
        # present and used to find extent
        ... # You can ensure they are used by setting prefer = "spatlocs
    )

    if (is.null(e)) {
        stop(wrap_txt(
            "No `ext` provided and no spatial locations or polygons discovered.
             Cannot determine largeImage resample extent"
        ))
    }
    return(e)
}


#' @name auto_image_resample
#' @title Optimized image resampling
#' @description
#' Downsample terra-based images for plotting. Uses
#' \code{\link[terra]{spatSample}} to load onlya  portion of the original image,
#' speeding up plotting and lowering memory footprint.
#'
#' Default behavior of `spatSample` is to crop if only a smaller ROI is
#' needed for plotting followed by the sampling process in order to reduce
#' wasted sampling by focusing the sample space. For very large ROIs, this
#' crop can be time intensive and require writing to disk.
#'
#' This function examines the ROI dimensions as defined through the limits of
#' the spatial locations to be plotted, and decides between the following two
#' methods in order to avoid this issue:
#' \itemize{
#'     \item{\strong{Method A.} First crop original image, then sample
#'     `max_sample` (default = 5e5) values to generate final image. Intended
#'     for smaller ROIs. Force usage of this method by setting
#'     `flex_resample = FALSE`}
#'     \item{\strong{Method B.} First oversample, then crop. Intended for larger
#'     ROIs. Base sample size is `max_sample`, which is then multiplied by a
#'     scale factor >1 that increases the smaller the ROI is and is defined by:
#'     original dimensions/crop dimensions where the larger ratio between x
#'     and y dims is chosen. Scale factor is capped by
#'     \code{max_resample_scale}}
#' }
#' Control points for this function are set by \code{max_crop} which decides
#' the max ROI area after which switchover to method B happens in order to
#' avoid laborious crops and \code{max_resample_scale} which determines the
#' maximum scale factor for number of values to sample. Both values can be
#' adjusted depending on system resources. Additionally, \code{flex_resample}
#' determines if this switching behavior happens.
#' When set to \code{FALSE}, only method A is used.
#' @param img giotto image to plot
#' @param plot_ext extent of plot (required)
#' @param img_border if not 0 or FALSE, expand plot_ext by this percentage on
#' each side before applying crop on image. See details
#' @param flex_resample logical. Default = TRUE. Forces usage of method A when
#' FALSE.
#' @param max_sample numeric. Default = 5e5. Maximum n values to sample from the
#' image. If larger than `max_crop`, will override `max_crop.`
#' Globally settable with the option "giotto.plot_img_max_sample"
#' @param max_crop numeric. Default = 1e8. Maximum crop size (px area) allowed
#' for \strong{method A} before switching to \strong{method B}
#' (see description).
#' Globally settable with option "giotto.plot_img_max_crop"
#' @param max_resample_scale numeric. Default = 100. Maximum scalefactor allowed
#' to be applied on `max_sample` in order to oversample when compensating
#' for decreased resolution when cropping after sampling. Globally settable with
#' option "giotto.plot_img_max_resample_scale".
#' @details
#' **img_border**
#' expand ext to use for plotting the image. This makes it so that the image
#' is not cut off sharply at the edge of the plot extent. Needed since plots
#' often define extent by centroids, and polygons may hang over the edge of the
#' extent.
#' @returns a giotto image cropped and resampled properly for plotting
#' @examples
#' \dontrun{
#' img <- GiottoData::loadSubObjectMini("giottoLargeImage")
#' .auto_resample_gimage(img)
#' }
#' @seealso \code{\link[terra]{spatSample}}
#' @keywords internal
.auto_resample_gimage <- function(
        img,
        plot_ext = NULL,
        img_border = 0.125,
        flex_resample = TRUE,
        max_sample = getOption("giotto.plot_img_max_sample", 5e5),
        max_crop = getOption("giotto.plot_img_max_crop", 1e8),
        max_resample_scale = getOption(
            "giotto.plot_img_max_resample_scale", 100
        )
) {

    img_ext <- terra::ext(img)
    if (is.null(plot_ext)) crop_ext <- img_ext # default
    else crop_ext <- ext(plot_ext)
    bound_poly <- as.polygons(crop_ext)

    # override max_crop if needed
    if (max_sample > max_crop) max_crop <- max_sample

    # apply img border
    # - cropping with extent larger than the image extent works
    if (img_border > 0) {

        crop_ext <- bound_poly %>%
            rescale(1 + img_border) %>%
            ext()

        # determine final crop (normalizes extent when larger than available)
        crop_ext <- ext(crop(bound_poly, crop_ext))
    }

    # determine ratio of crop vs original
    original_dims <- dim(img)[c(2L, 1L)] # x, y ordering
    ratios <- range(crop_ext) / range(img_ext) # x, y ordering
    crop_dims <- original_dims * ratios
    crop_area_px <- prod(crop_dims)

    if (!isTRUE(flex_resample) || crop_area_px <= max_crop) {
        # [METHOD A]:
        # 1. Crop if needed
        # 2. resample to final image
        if (!isTRUE(flex_resample) && crop_area_px > max_crop) {
            warning("Plotting large regions with flex_resample == FALSE will
                    increase time and may require scratch space.")
        }

        vmsg(.is_debug = TRUE,
             sprintf("img auto_res: [A] | area: %f | max: %f",
                     crop_area_px, max_crop))

        crop_img <- terra::crop(
            x = img@raster_object,
            y = crop_ext
        )
        img@raster_object <- terra::spatSample(
            crop_img,
            size = max_sample,
            method = "regular",
            as.raster = TRUE
        )
    } else {
        # [METHOD B]:
        # 1. Oversample
        # 2. crop to final image
        # Sample n values where max_sample is scaled by a value >1
        # Scale factor is fullsize image dim/crop dim. Larger of the two
        # ratios is chosen
        scalef <- max(1/ratios)
        # This scaling is ALSO capped by max_resample_scale
        if (scalef > max_resample_scale) scalef <- max_resample_scale

        vmsg(.is_debug = TRUE,
             sprintf("img auto_res: [B] | scalef: %f | max_scale: %f",
                     scalef, max_resample_scale))

        oversample_img <- terra::spatSample(
            img@raster_object,
            size = round(max_sample * scalef),
            method = "regular",
            as.raster = TRUE
        )
        img@raster_object <- terra::crop(
            x = oversample_img,
            y = crop_ext
        )
    }
    return(img)
}


