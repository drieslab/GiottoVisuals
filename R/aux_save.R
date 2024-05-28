#' @title Plot saving
#' @name plot_save
#' @description
#' Functions to automatically save plots to directory of interest
#' @param gobject giotto object or giottoInstructions
#' @param plot_object ggplot object to plot
#' @param save_dir directory to save to
#' @param save_folder folder in save_dir to save to
#' @param save_name name of plot
#' @param default_save_name default name to save a plot
#' @param save_format format (e.g. png, tiff, pdf, ...)
#' @param show_saved_plot load & display the saved plot
#' @param ncol number of columns for multiplots
#' @param nrow number of rows for multiplot
#' @param scale scale of plots
#' @param base_width width of plot
#' @param base_height height of plot
#' @param base_aspect_ratio aspect ratio of plot
#' @param units plotting units (e.g. in)
#' @param dpi dpi for each plot if plot is in raster format
#' @param limitsize When TRUE (the default), ggsave will not save images larger
#' than 50x50 inches, to prevent the common error of specifying dimensions in
#' pixels.
#' @param plot_count manually set the plot count that is appended to a
#' default_save_name
#' @param \dots additional parameters to pass downstream save functions
#' @returns a plot file
#' @seealso \code{\link{showSaveParameters}} \code{\link[cowplot]{save_plot}}
#' \code{\link[grDevices]{png}}
#' \code{\link[grDevices]{tiff}}
#' \code{\link[grDevices]{pdf}}
#' \code{\link[grDevices]{svg}}
NULL



#' @describeIn plot_save (internal) ggplot saving. ...
#' passes to cowplot::save_plot
#' @keywords internal
.ggplot_save_function <- function(gobject,
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
    ...) {
    if (is.null(plot_object)) {
        stop("\t there is no object to plot \t")
    }

    ## get save information and set defaults
    if (is.null(save_dir)) {
        save_dir <- readGiottoInstructions(gobject,
            param = "save_dir"
        )
    }
    if (is.null(save_folder)) save_folder <- NULL
    if (is.null(plot_count)) plot_count <- getOption("giotto.plot_count")
    if (is.null(save_name)) {
        save_name <- default_save_name
        save_name <- paste0(plot_count, "-", save_name)
        options("giotto.plot_count" = plot_count + 1L)
    }
    if (is.null(save_format)) {
        save_format <- readGiottoInstructions(gobject,
            param = "plot_format"
        )
    }
    if (is.null(dpi)) dpi <- readGiottoInstructions(gobject, param = "dpi")
    if (is.null(base_width)) {
        base_width <- readGiottoInstructions(gobject,
            param = "width"
        )
    }
    if (is.null(base_height)) {
        base_height <- readGiottoInstructions(gobject,
            param = "height"
        )
    }
    if (is.null(base_aspect_ratio)) base_aspect_ratio <- 1.1
    if (is.null(units)) {
        units <- readGiottoInstructions(gobject,
            param = "units"
        )
    }

    ## checking
    dpi <- as.numeric(dpi)
    base_width <- as.numeric(base_width)
    base_height <- as.numeric(base_height)
    base_aspect_ratio <- as.numeric(base_aspect_ratio)

    # create saving location
    if (!is.null(save_folder)) {
        file_location <- paste0(save_dir, "/", save_folder)
    } else {
        file_location <- save_dir
    }
    if (!file.exists(file_location)) dir.create(file_location, recursive = TRUE)
    file_name <- paste0(save_name, ".", save_format)

    cowplot::save_plot(
        plot = plot_object,
        filename = file_name,
        path = file_location,
        device = save_format,
        ncol = ncol,
        nrow = nrow,
        scale = scale,
        base_width = base_width,
        base_height = base_height,
        base_aspect_ratio = base_aspect_ratio,
        units = units,
        dpi = dpi,
        limitsize = limitsize,
        ...
    )

    # show saved plot if requested
    if (isTRUE(show_saved_plot)) {
        if (save_format == "png") {
            if (package_check("png", optional = TRUE)) {
                img <- png::readPNG(source = paste0(
                    file_location, "/",
                    file_name
                ))
                grid::grid.raster(img)
            }
        } else if (save_format == "tiff") {
            if (package_check("tiff", optional = TRUE)) {
                img <- tiff::readTIFF(source = paste0(
                    file_location, "/",
                    file_name
                ))
                grid::grid.raster(img)
            }
        } else {
            warning("\t only png & tiff are currently supported \t")
        }
    }
}



#' @describeIn plot_save (internal) base and general saving.
#' ... passes to grDevices png, tiff, pdf, svg
#' @keywords internal
.general_save_function <- function(
        gobject,
        plot_object,
        save_dir = NULL,
        save_folder = NULL,
        save_name = NULL,
        default_save_name = "giotto_plot",
        save_format = c("png", "tiff", "pdf", "svg"),
        show_saved_plot = FALSE,
        base_width = NULL,
        base_height = NULL,
        base_aspect_ratio = NULL,
        units = NULL,
        dpi = NULL,
        plot_count = NULL,
        ...) {
    if (is.null(plot_object)) {
        stop("\t there is no object to plot \t")
    }
    save_format <- match.arg(save_format,
        choices = c("png", "tiff", "pdf", "svg")
    )

    if (any("plotly" %in% class(plot_object))) {
        save_format <- "html"
    }

    ## get save information and set defaults
    if (is.null(save_dir)) {
        save_dir <- readGiottoInstructions(gobject,
            param = "save_dir"
        )
    }
    if (is.null(save_folder)) save_folder <- NULL
    if (is.null(plot_count)) plot_count <- getOption("giotto.plot_count")
    if (is.null(save_name)) {
        save_name <- default_save_name
        save_name <- paste0(plot_count, "-", save_name)
        options("giotto.plot_count" = plot_count + 1)
    }
    if (is.null(save_format)) {
        save_format <- readGiottoInstructions(gobject,
            param = "plot_format"
        )
    }
    if (is.null(dpi)) dpi <- readGiottoInstructions(gobject, param = "dpi")
    if (is.null(base_width)) {
        base_width <- readGiottoInstructions(gobject,
            param = "width"
        )
    }
    if (is.null(base_height)) {
        base_height <- readGiottoInstructions(gobject,
            param = "height"
        )
    }
    if (is.null(base_aspect_ratio)) base_aspect_ratio <- 1.1
    if (is.null(units)) {
        units <- readGiottoInstructions(gobject,
            param = "units"
        )
    }

    ## checking
    dpi <- as.numeric(dpi)
    base_width <- as.numeric(base_width)
    base_height <- as.numeric(base_height)
    base_aspect_ratio <- as.numeric(base_aspect_ratio)

    # create saving location
    if (!is.null(save_folder)) {
        file_location <- paste0(save_dir, "/", save_folder)
    } else {
        file_location <- save_dir
    }
    if (!file.exists(file_location)) dir.create(file_location, recursive = TRUE)
    file_name <- paste0(save_name, ".", save_format)
    full_location <- paste0(file_location, "/", file_name)

    if (any("plotly" %in% class(plot_object))) {
        htmlwidgets::saveWidget(plotly::as_widget(plot_object),
            file = full_location
        )
    } else {
        if (save_format == "png") {
            grDevices::png(
                filename = full_location, width = base_width,
                height = base_height, res = dpi, units = units, ...
            )
            print(plot_object)
            grDevices::dev.off()
        }

        if (save_format == "tiff") {
            grDevices::tiff(
                filename = full_location, width = base_width,
                height = base_height, units = units, ...
            )
            print(plot_object)
            grDevices::dev.off()
        }

        if (save_format == "pdf") {
            grDevices::pdf(
                file = full_location, width = base_width,
                height = base_height, useDingbats = FALSE, ...
            )
            print(plot_object)
            grDevices::dev.off()
        }

        if (save_format == "svg") {
            grDevices::svg(
                filename = full_location, width = base_width,
                height = base_height, ...
            )
            print(plot_object)
            grDevices::dev.off()
        }


        # show saved plot if requested
        if (isTRUE(show_saved_plot)) {
            if (save_format == "png") {
                if (package_check("png", optional = TRUE)) {
                    img <- png::readPNG(source = paste0(
                        file_location,
                        "/", file_name
                    ))
                    grid::grid.raster(img)
                }
            } else if (save_format == "tiff") {
                if (package_check("tiff", optional = TRUE)) {
                    img <- tiff::readTIFF(source = paste0(
                        file_location,
                        "/", file_name
                    ))
                    grid::grid.raster(img)
                }
            } else {
                warning("\t only png & tiff are currently supported \t")
            }
        }
    }
}

#' @rdname plot_save
#' @examples
#' g <- GiottoClass::createGiottoInstructions(save_plot = TRUE)
#' df <- data.frame(x = rnorm(5), y = rnorm(5))
#' g_plot <- ggplot2::ggplot(df, ggplot2::aes(x,y)) + ggplot2::geom_point()
#' all_plots_save_function(g, g_plot)
#' 
#' @export
all_plots_save_function <- function(gobject,
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
    ...) {
    if (any("ggplot" %in% class(plot_object))) {
        .ggplot_save_function(
            gobject = gobject,
            plot_object = plot_object,
            save_dir = save_dir,
            save_folder = save_folder,
            save_name = save_name,
            default_save_name = default_save_name,
            save_format = save_format,
            show_saved_plot = show_saved_plot,
            ncol = ncol,
            nrow = nrow,
            scale = scale,
            base_width = base_width,
            base_height = base_height,
            base_aspect_ratio = base_aspect_ratio,
            units = units,
            dpi = dpi,
            limitsize = limitsize,
            plot_count = plot_count,
            ...
        )
    } else {
        .general_save_function(
            gobject = gobject,
            plot_object = plot_object,
            save_dir = save_dir,
            save_folder = save_folder,
            save_name = save_name,
            default_save_name = default_save_name,
            save_format = save_format,
            show_saved_plot = show_saved_plot,
            base_width = base_width,
            base_height = base_height,
            base_aspect_ratio = base_aspect_ratio,
            units = units,
            dpi = dpi,
            plot_count = plot_count,
            ...
        )
    }
}




#' @title showSaveParameters
#' @name showSaveParameters
#' @description Description of Giotto saving options,
#' links to \code{\link{all_plots_save_function}}
#' @returns Instructions on how to use the automatic plot saving options
#' within Giotto
#' @export
#' @examples
#' showSaveParameters()
showSaveParameters <- function() {
    message("This is a simple guide to help you automatically saving plots. \n")
    message("Importantly, defaults for all these parameters can be set at
    the beginning with createGiottoInstructions() \n")
    message("See
    https://rubd.github.io/Giotto/articles/instructions_and_plotting.html
    for more information and examples \n \n")

    message("Each plotting function in Giotto has 4 important parameters for
    showing and/or saving a plot: \n
        - show_plot: TRUE or FALSE, show the plot to the console
        - return_plot: TRUE or FALSE, return the plot to the console
        (e.g. to further modify or save the plot
        - save_plot: TRUE or FALSE, automatically save the plot
        - save_param: a list of parameters that can be set \n")

    message("The following list of parameters can be provided to save_param: \n
        - save_dir: directory to save the plot to
        - save_folder: if not NULL, a subfolder within save_dir that will
        be created to save the plot to
        - save_name: name of the plot (no extension needed, see save_format)
        - save_format: picture format to use, default is .png
        - ncol: number of columns for multiplots
        - nrow: number of rows for multiplot
        - scale: scale of plots
        - base_width: width of plot
        - base_height: height of plot
        - base_aspect_ratio: ratio of plot
        - units: plotting units (e.g. in)
        - dpi: dpi for each plot if plot is in raster format\n")

    message("Example: \n
        plotfunction(...,
                    save_plot = TRUE,
                    save_param = list(save_name = 'favorite_name',
                    units = 'png'))")
}
