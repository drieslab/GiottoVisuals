#' @name ridgePlot
#' @title Create a ridgeline plot
#' @inheritParams data_access_params
#' @inheritParams plot_output_params
#' @param feats features to plot. Passed to [GiottoClass::spatValues()]
#' @param ... additional params to pass to [GiottoClass::spatValues()]
#' @param stat character. A `stat` accepted by
#' [ggridges::geom_density_ridges()]
#' @param alpha numeric. Alpha to use for ridgeline plot. Value from 0 to 1.
#' @param axis_scale character (default = `"log2"`.
#' An x axis scaling to use. This value is passed to
#' [ggplot2::scale_x_continuous()]. Set `"identity"` to remove scaling.
#' @param axis_offset numeric. Value to add to values. When this value is not
#' provided and `axis_scale` is one of `"log"`, `"log2"`, or `"log10"`, a
#' `axis_offset` of 1 is used by default.
#' @param background_color background color
#' @param show_legend logical. Whether to show legend
#' @param remove_na logical. If `FALSE`, the default, missing values are
#' removed with a warning. If `TRUE`, missing values are silently removed.
#' @param theme_param list of additional params passed to `ggplot2::theme()`
#' @param verbose be verbose
#' @returns ggplot
#' @examples
#' g <- GiottoData::loadGiottoMini("visium")
#'
#' # plot normalized expresion of first 6 features
#' ridgePlot(g,
#'     feats = head(rownames(g)),
#'     expression_values = "normalized"
#' )
#'
#' # plot distribution on PCA PCs
#' ridgePlot(g,
#'     feats = sprintf("Dim.%d", 1:20),
#'     scale_axis = "identity"
#' )
#' @export
ridgePlot <- function(gobject, feats, ...,
    # group_by = "leiden_clus",
    stat = "density_ridges",
    alpha = 1,
    scale_axis = "log2",
    axis_offset = NULL,
    background_color = "white",
    remove_na = NULL,
    show_legend = FALSE,
    theme_param = list(),
    show_plot = NULL,
    return_plot = NULL,
    save_plot = NULL,
    save_param = list(),
    default_save_name = "ridgePlot",
    verbose = NULL) {
    value <- NULL # NSE vars
    checkmate::assert_character(feats)
    checkmate::assert_character(scale_axis)
    checkmate::assert_numeric(axis_offset, null.ok = TRUE)
    if (is.null(axis_offset) && scale_axis %in% c("log", "log2", "log10")) {
        axis_offset <- 1
    }

    package_check("ggridges")
    # pull data to plot
    data <- spatValues(gobject, feats = feats, ..., verbose = verbose)
    data <- data[, -1] # remove cell_ID col
    data <- data.table::melt(data,
        measure.vars = colnames(data),
        variable.name = "feat",
        value.name = "value"
    )
    # apply axis offset
    if (!is.null(axis_offset)) {
        data[, value := value + axis_offset]
    }

    # accumulate plot aesthetics
    plot_aes <- ggplot2::aes_string(
        x = "value",
        y = "feat",
        fill = "feat"
    )

    # accumulate theme param
    theme_param$panel.background <- theme_param$panel.background %null%
        ggplot2::element_rect(fill = background_color)

    pl <- ggplot2::ggplot(data = data) +
        ggridges::geom_density_ridges(
            mapping = plot_aes,
            alpha = alpha,
            stat = stat,
            na.rm = remove_na %null% FALSE,
            show.legend = show_legend
        ) +
        ggplot2::labs(x = "", y = "") +
        ggplot2::scale_x_continuous(transform = scale_axis) +
        ggridges::theme_ridges() +
        do.call(ggplot2::theme, theme_param)

    return(plot_output_handler(
        gobject = gobject,
        plot_object = pl,
        save_plot = save_plot,
        return_plot = return_plot,
        show_plot = show_plot,
        default_save_name = default_save_name,
        save_param = save_param,
        else_return = NULL
    ))
}
