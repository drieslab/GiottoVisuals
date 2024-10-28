#' @name gg_annotation_raster
#' @title Append image to ggplot as annotation_raster
#' @description
#' Add a spatially mapped image to a *ggplot2* `gg` object.
#' For terra-based images, the image will be a cropped and sampled version
#' of the full size image on disk that has sufficient resolution for the size
#' of the plot requested.
#'
#' @param ggobj ggplot2 `gg` object
#' @param gimage `giottoLargeImage`, `giottoImage` or `list` thereof
#' @param ext Object that responds to `ext()`. Defines the plot spatial ROI
#' This extent defines which portions of the image(s) will be plotted/should
#' be sampled for. The default is the same extent as the image.
#' @param geom_blank logical. Whether to apply `[ggplot2::geom_blank()]` to the
#' `gg` object so that the image can be plotted by itself.
#' @param \dots additional params to pass
#' @details
#' No ... params are implemented for `giottoImage`. \cr ... params for
#' `giottoLargeImage` passes to automated resampling params see
#' `?auto_image_resample` for details
#' @return `gg` object with images to plot appended as annotation rasters
#' @examples
#' gimg <- GiottoData::loadSubObjectMini("giottoLargeImage")
#' gg <- ggplot2::ggplot()
#' out <- GiottoVisuals::gg_annotation_raster(gg, gimg)
#' print(out)
NULL

# * list ####
#' @rdname gg_annotation_raster
#' @export
setMethod(
    "gg_annotation_raster",
    signature(ggobj = "gg", gimage = "list"),
    function(ggobj, gimage, ext = NULL, geom_blank = TRUE, ...) {

        # apply geom_blank
        ext <- ext %null% ext(gimage[[1L]])
        if (geom_blank) ggobj <- .gg_geom_blank(ggobj, ext)

        # attach images in a loop
        for (i in seq_along(gimage)) {
            ggobj <- gg_annotation_raster(
                ggobj, gimage[[i]],
                ext = ext,
                geom_blank = FALSE, # hardcode FALSE since already done.
                ...
            )
        }
        return(ggobj)
    }
)

# * giottoImage ####
#' @rdname gg_annotation_raster
#' @export
setMethod(
    "gg_annotation_raster",
    signature(ggobj = "gg", gimage = "giottoImage"),
    function(ggobj, gimage, ext = NULL, geom_blank = TRUE, ...) {

        # apply geom_blank
        ext <- ext %null% ext(gimage)
        if (geom_blank) ggobj <- .gg_geom_blank(ggobj, ext)

        # convert giotto image object into array
        img_array <- as.numeric(gimage@mg_object[[1]])

        # append to ggobj
        ggobj <- .gg_append_imagearray(ggobj, img_array, ext)

        # TODO geom_raster to accommodate single-channel
        return(ggobj)
    }
)

# * giottoLargeImage ####
#' @rdname gg_annotation_raster
#' @export
setMethod(
    "gg_annotation_raster",
    signature(ggobj = "gg", gimage = "giottoLargeImage"),
    function(ggobj, gimage, ext = NULL, geom_blank = TRUE, ...) {

        # geom_blank
        ext <- ext %null% ext(gimage)
        if (geom_blank) ggobj <- .gg_geom_blank(ggobj, ext)

        # resample from extent
        gimage <- .auto_resample_gimage(
            img = gimage,
            plot_ext = ext,
            crop_ratio_fun = .img_to_crop_ratio_gimage,
            sample_fun = .sample_gimage,
            ...
        )

        # append raster to gg
        ggobj <- .gg_append_spatraster(ggobj = ggobj, gimage = gimage)

        return(ggobj)
    }
)

# * giottoAffineImage ####
#' @rdname gg_annotation_raster
#' @export
setMethod(
    "gg_annotation_raster",
    signature(ggobj = "gg", gimage = "giottoAffineImage"),
    function(ggobj, gimage, ext = NULL, geom_blank = TRUE, ...) {

        # geom_blank
        ext <- ext %null% ext(gimage)
        if (geom_blank) ggobj <- .gg_geom_blank(ggobj, ext)

        # resample from extent
        gimage <- .auto_resample_gimage(
            img = gimage,
            plot_ext = ext,
            crop_ratio_fun = .img_to_crop_ratio_gaffimage,
            sample_fun = .sample_gaffimage,
            ...
        )

        # append raster to gg
        ggobj <- .gg_append_spatraster(ggobj = ggobj, gimage = gimage)

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

# internal to convert a SpatExtent into a data.frame with x and y values that
# ggplot2 can use to determine bounds of placement
.ext_to_dummy_df <- function(x) {
    data.frame(
        sdimx = x[][c(1, 2)],
        sdimy = x[][c(3, 4)],
        row.names = NULL
    )
}

# apply a region to plot to the gg object. Input should be a SpatExtent or
# coercible. Returns ggobject with geom_blank assigned
.gg_geom_blank <- function(ggobj, e) {
    # NSE vars
    sdimx <- sdimy <- NULL

    # create minimal dummy value data.frame of spatial locations that cover
    # the spatial region to plot
    bounds_dt <- .ext_to_dummy_df(e)
    # assign region to plot
    ggobj <- ggobj + geom_blank(data = bounds_dt, aes(sdimx, sdimy))
    return(ggobj)
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
#' @param plot_ext extent of plot (defaults to the image extent)
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
        crop_ratio_fun = .img_to_crop_ratio_gimage,
        sample_fun = .sample_gimage,
        flex_resample = TRUE,
        max_sample = getOption("giotto.plot_img_max_sample", 5e5),
        max_crop = getOption("giotto.plot_img_max_crop", 1e8),
        max_resample_scale = getOption(
            "giotto.plot_img_max_resample_scale", 100
        )
) {

    # 1. determine source image and cropping extents
    if (is.null(plot_ext)) crop_ext <- ext(img) # default to img extent
    else crop_ext <- ext(plot_ext)
    bound_poly <- as.polygons(crop_ext)

    # 1.1. override max_crop if needed
    if (max_sample > max_crop) max_crop <- max_sample

    # 1.2. apply img border expansion
    # - note: cropping with extent larger than the image extent is supported
    if (img_border > 0) {

        crop_ext <- bound_poly %>%
            rescale(1 + img_border) %>%
            ext()

        # determine final crop (normalizes extent when larger than available)
        crop_ext <- ext(crop(bound_poly, crop_ext))
    }

    # 2. determine cropping area
    original_dims <- dim(img)[c(2L, 1L)] # x, y ordering
    ratios <- crop_ratio_fun(img = img, crop_ext = crop_ext) # x, y ordering
    crop_dims <- original_dims * ratios
    crop_area_px <- prod(crop_dims)

    # 3. perform flexible resample/crop based on cropping area
    if (!isTRUE(flex_resample) || crop_area_px <= max_crop) {
        # [METHOD A]:
        # 1. Crop if needed
        # 2. resample to final image
        if (!isTRUE(flex_resample) && crop_area_px > max_crop) {
            warning(
                "Plotting large regions with flex_resample == FALSE will\n ",
                "increase time and may require scratch space."
            )
        }

        vmsg(.is_debug = TRUE,
             sprintf("img auto_res: [A] | area: %f | max: %f",
                     crop_area_px, max_crop))

        crop_img <- terra::crop(img, crop_ext)
        res <- sample_fun(crop_img, size = max_sample)
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

        oversample_img <- sample_fun(img, size = round(max_sample * scalef))
        res <- terra::crop(oversample_img, crop_ext)
    }
    return(res)
}




# determine ratio of crop vs full image extent
.img_to_crop_ratio_gimage <- function(img, crop_ext) {
    img_ext <- ext(img)
    ratio <- range(crop_ext) / range(img_ext)
    # crops larger than the image are possible, but meaningless for this
    # calculate. so the ratios are capped at 1.
    ratio[ratio > 1] <- 1
    return(ratio)
}

.img_to_crop_ratio_gaffimage <- function(img, crop_ext) {
    # Do not use the ext() method for giottoAffineImage
    # Instead use the mapping applied to the underlying SpatRaster.
    # For giottoAffineImage, these two values are usually different.
    img_ext <- ext(img@raster_object)
    # find the extent needed in the source (untransformed) image
    crop_bound <- terra::as.polygons(crop_ext)
    crop_bound$id <- "bound" # affine() requires ID values
    crop_ext <- ext(affine(crop_bound, img@affine, inv = TRUE))
    ratio <- range(crop_ext) / range(img_ext)
    # crops larger than the image are possible, but meaningless for this
    # calculate. so the ratios are capped at 1.
    ratio[ratio > 1] <- 1
    return(ratio)
}




# pull sampled values from original image into target spatial mapping
# should return a giottoLargeImage
.sample_gimage <- function(x, size) {
    x@raster_object <- terra::spatSample(
        x = x@raster_object,
        size = size,
        method = "regular",
        as.raster = TRUE
    )
    return(x)
}

.sample_gaffimage <- function(x, size) {
    res <- x@funs$realize_magick(size = size)
    return(res)
}




# make an image array compatible with ggplot::annotation_raster()
# maxval is the cutoff after which everything is max intensity
# returns: raster
.gg_imgarray_2_raster <- function(x, maxval = NULL, col = NULL) {
    nlyr <- dim(x)[3L] # number of channels/layers
    if (is.na(nlyr)) nlyr <- 1L
    # NOTE: 4 layers allowed (rgba), but may conflict with actual 4 info
    # layer cases which SHOULD be converted to 3 layer
    #
    # more than 4 layers -> directly ignore layers past the 3rd
    if (nlyr > 4L) {
        nlyr <- 3L
        x <- x[, , seq_len(3)]
    }

    # handle NaN values -- set as max value of that layer
    # these may arise due to save artefacting when values are larger than
    # expected
    for (lyr in seq_len(nlyr)) {
        if (is.nan(max(x[, , lyr]))) {
            x[, , lyr][is.nan(x[, , lyr])] <-
                max(x[, , lyr], na.rm = TRUE)
        }
    }

    # handle NA values -- set as 0
    x[is.na(x)] <- 0

    if (nlyr == 1L) {
        # SINGLE CHANNEL #
        # max window cutoff
        if (!is.null(maxval)) x[x > maxval] <- maxval
        # colorize
        if (is.null(col)) {
            col <- getMonochromeColors("white", n = 256)
        }
        r <- .colorize_single_channel_raster(x, col = col)
    } else {
        # RGB EXPECTED #
        # convert to range 0:1 (needed for as.raster())
        x <- scales::rescale(x, to = c(0, 1))
        r <- grDevices::as.raster(x)
    }

    return(r)
}




# `x` is array to use
# `col` is character vector of colors to use
.colorize_single_channel_raster <- function(x, col) {
    if (!is.na(dim(x)[3L])) x <- x[,, 1L] # convert to matrix
    r <- range(x, na.rm = TRUE)
    x <- (x - r[1])/(r[2] - r[1])
    x <- round(x * (length(col) - 1) + 1)
    x[] <- col[x]
    terra::as.raster(x)
}

# append image array to a gg object
.gg_append_imagearray <- function(ggobj, a, ext) {
    # append to ggobj
    extent <- ext(ext)[seq_len(4L)]
    ggobj <- ggobj + annotation_raster(a,
        xmin = extent[["xmin"]], xmax = extent[["xmax"]],
        ymin = extent[["ymin"]], ymax = extent[["ymax"]]
    )
}

# append a giotto image object containing a SpatRaster that has already been
# resampled/pulled into memory. Output is a `gg` object
.gg_append_spatraster <- function(ggobj, gimage) {
    # convert gimage to a raster
    a <- terra::as.array(gimage@raster_object) %>%
        .gg_imgarray_2_raster(
            maxval = gimage@max_window,
            col = gimage@colors
        )

    ggobj <- .gg_append_imagearray(ggobj, a, ext(gimage))
    return(ggobj)
}


