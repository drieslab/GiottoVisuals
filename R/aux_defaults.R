# default plot n cols ####
#' @title Set default ncols in plotting grid
#' @name set_default_cow_n_col
#' @description
#' Determine a default cow_n_col param value for cowplot based on the number of
#' items to plot.
#' @param cow_n_col number of columns for cowplot to use. A default number is
#' calculated if `NULL` is passed.
#' @param nr_plots number of plots to use with cowplot
#' @returns numeric
#' @examples
#' set_default_cow_n_col(nr_plots = 4)
#'
#' @export
set_default_cow_n_col <- function(
        cow_n_col = NULL,
        nr_plots) {
    if (is.null(cow_n_col)) {
        cow_n_col <- ceiling(sqrt(nr_plots))
    } else {
        cow_n_col
    }
    return(cow_n_col)
}


# default plotting fill color ####








## discrete ####


# -------------------------------------------------------------------------- #
# FUNCTION input to 'color' are also permitted, but REQUIRE an 'n' param
# for downstream functionality. 'giotto.color_discrete_pal' and
# 'giotto.color_discrete_strategy' are additionally ignored
# -------------------------------------------------------------------------- #

#' @name set_default_color_discrete
#' @title Set a discrete coloring scheme
#' @description
#' Provides a palette function that will generate 'n' hexadecimal color codes
#' for discrete colors. Sets a default coloring palette if `NULL` is passed
#' to `colors` param.\cr\cr
#'
#' Supports colors setting at three levels:
#' - **global options** (general session setting with blanket color palette
#' type effects)
#'     - options('giotto.color_d_pal) - palette to use
#'     - options('giotto.color_d_rev) - whether colors should be reversed
#'     - options('giotto.color_d_strategy) - strategy to use when making colors
#'     continuous. See [get_continuous_colors()]
#' - **giotto instructions** (gobject specific and effects specific types
#' of plots)
#'     - run `showColorInstructions()` for details on options/params to set
#'     in the `giottoInstructions` object
#' - **function specific** (directly pass desired colors to plotting function)
#' \cr\cr
#'
#' If a character vector of length 1 input is provided then it will be assumed
#' that a known color palette is being requested from [pal_names()].\cr
#' If a longer character input is provided then they will be expected to be
#' a vector of colors to use. These values will be passed to
#' [simple_palette_factory] which will generate a palette function that
#' interpolates between the colors provided by default and has a `n` param for
#' number of requested colors.\cr
#' Custom function inputs to `colors` is also supported but these custom
#' functions should have a `n` param for number of requested colors.
#' @param colors accepts color inputs
#' @param instrs `giottoInstructions` object (output of `instructions(gobject)`)
#' @param \dots additional params to pass
#' @returns a palette function
#' @examples
#' set_default_color_discrete(
#'     colors = "#eb4034",
#'     instr_rev = NULL, instr_strategy = NULL
#' )
NULL




#' @describeIn set_default_color_discrete Framework function.
#' Direct use should be minimal.
#' Wrap this for specific things (plots or types of features) that need
#' defaults setting.
#' @param instr_pal,instr_rev,instr_strategy used by upstream function to
#' pass specific `giottoInstructions` params
#'
#' @export
set_default_color_discrete <- function(
        colors = NULL,
        ...,
        instr_pal,
        instr_rev,
        instr_strategy) {
    # global giotto options
    opt_pal <- getOption("giotto.color_d_pal", "distinct")
    opt_rev <- getOption("giotto.color_d_rev", FALSE)
    opt_strategy <- getOption("giotto.color_d_strategy", "interpolate")

    # get 'colors' either from param input or options
    if (is.null(colors)) {
        if (is.null(instr_pal)) {
            colors <- opt_pal
        } else {
            colors <- instr_pal
        }
    }

    # get 'reverse' and 'strategy'
    reverse <- ifelse(is.null(instr_rev), opt_rev, instr_rev)
    strategy <- ifelse(is.null(instr_strategy), opt_strategy, instr_strategy)

    # evaluate 'colors'
    if (inherits(colors, "function")) {
        return(colors)
    } else if (inherits(colors, "character")) {
        if (length(colors) > 1) { # assume simple palette if multiple
            # entries in vector
            return(simple_palette_factory(
                col = colors, rev = reverse,
                strategy = strategy
            ))
        } else { # assume call to getColors() otherwise
            # return wrapped
            return(.get_palette_factory(
                pal = colors, rev = reverse,
                strategy = strategy
            ))
        }
    }
}


#' @rdname set_default_color_discrete
#' @returns vector of color ids
#' @export
set_default_color_discrete_cell <- function(
        colors = NULL,
        instrs,
        ...) {
    # read instructions
    instr_pal <- readGiottoInstructions(instrs, "cell_color_d_pal", NULL)
    instr_rev <- readGiottoInstructions(instrs, "cell_color_d_rev", NULL)
    instr_strategy <- readGiottoInstructions(
        instrs, "cell_color_d_strategy",
        NULL
    )

    set_default_color_discrete(
        colors = colors,
        instr_pal = instr_pal,
        instr_rev = instr_rev,
        instr_strategy = instr_strategy,
        ...
    )
}

#' @rdname set_default_color_discrete
#' @export
set_default_color_discrete_poly <- function(
        colors = NULL,
        instrs,
        ...) {
    # read instructions
    instr_pal <- readGiottoInstructions(instrs, "poly_color_d_pal", NULL)
    instr_rev <- readGiottoInstructions(instrs, "poly_color_d_rev", NULL)
    instr_strategy <- readGiottoInstructions(
        instrs, "poly_color_d_strategy",
        NULL
    )

    set_default_color_discrete(
        colors = colors,
        instr_pal = instr_pal,
        instr_rev = instr_rev,
        instr_strategy = instr_strategy,
        ...
    )
}

#' @rdname set_default_color_discrete
#' @export
set_default_color_discrete_feat <- function(
        colors = NULL,
        instrs,
        ...) {
    # read instructions
    instr_pal <- readGiottoInstructions(instrs, "feat_color_pal", NULL)
    instr_rev <- readGiottoInstructions(instrs, "feat_color_rev", NULL)
    instr_strategy <- readGiottoInstructions(
        instrs, "feat_color_strategy",
        NULL
    )

    set_default_color_discrete(
        colors = colors,
        instr_pal = instr_pal,
        instr_rev = instr_rev,
        instr_strategy = instr_strategy,
        ...
    )
}

#' @rdname set_default_color_discrete
#' @export
set_default_color_discrete_heatmap_clus <- function(
        colors = NULL,
        instrs,
        ...) {
    # read instructions
    instr_pal <- readGiottoInstructions(
        instrs, "heatmap_clus_color_pal",
        NULL
    )
    instr_rev <- readGiottoInstructions(
        instrs, "heatmap_clus_color_rev",
        NULL
    )
    instr_strategy <- readGiottoInstructions(
        instrs,
        "heatmap_clus_color_strategy", NULL
    )

    set_default_color_discrete(
        colors = colors,
        instr_pal = instr_pal,
        instr_rev = instr_rev,
        instr_strategy = instr_strategy,
        ...
    )
}










## continuous ####


#' @name set_default_color_continuous
#' @title Set a default color for continuous values
#' @description
#' Generates a gradient color palette based on input to `colors` param. Sets a
#' default gradient if `NULL` is passed.
#' `midpoint` param only supplied when using color scale with 3 colors.\cr\cr
#'
#' Supports colors setting at four levels:
#' - **type specific defaults** - defaults for a specific feature or type of
#' plot can be passed through `data_default` param
#' - **global options** (general session setting with blanket color palette
#' type effects)
#'   - options('giotto.color_cd_pal) - default continuous divergent palette
#'   is blue, white, red, for sequential ('giotto.color_cs_pal), it is
#'   'viridis'
#'   - options('giotto.color_c_rev) - whether colors should be reversed
#' - **giotto instructions** (gobject specific and effects specific types of
#' plots)
#'     - run `showColorInstructions()` for details on options/params to set in
#'     the `giottoInstructions` object
#' - **function specific** (directly pass desired colors to plotting function)
#' \cr\cr
#'
#' @param colors character or `NULL`. 2 to n number of hex color codes or 1
#' single name of a palette to use can be passed
#' @param instrs `giottoInstructions` object (output of `instructions(gobject)`)
#' @param midpoint numeric. midpoint value of color gradient
#' @param style scale color scale around `midpoint` (divergent) or starting from
#' minimum value (sequential)
#' @param data_default data type (e.g. cells, polys, heatmap) specific default
#' colors to use
#' @param type whether setting is for ggplot2 'fill' or 'color' type function
#' @param \dots additional params to pass to respective ggplot fill_gradient
#' functions
#' @returns continuous color palette
#' @examples
#' g <- GiottoData::loadGiottoMini("vizgen")
#'
#' nr_feat_polys <- function(...) {
#'     spatInSituPlotPoints(g,
#'         polygon_fill = "nr_feats",
#'         polygon_fill_as_factor = FALSE,
#'         polygon_feat_type = "aggregate",
#'         polygon_line_size = 0.1,
#'         polygon_alpha = 1,
#'         ...
#'     )
#' }
#'
#' # default
#' nr_feat_polys()
#'
#' # set global option level: viridis
#' options("giotto.color_c_pal" = "v")
#' nr_feat_polys()
#'
#' # set instructions level: magma
#' GiottoClass::instructions(g, "poly_color_c_pal") <- "magma"
#' nr_feat_polys()
#'
#' GiottoClass::instructions(g, "poly_color_c_rev") <- TRUE
#' nr_feat_polys()
#' nr_feat_polys(polygon_fill_gradient_style = "s")
#'
#'
#' # set function level: mako
#' GiottoClass::instructions(g, "poly_color_c_rev") <- FALSE
#' nr_feat_polys(polygon_fill_gradient = "mako")
#'
#' # set function level: color vector (2 to n colors)
#' nr_feat_polys(
#'     polygon_fill_gradient = c("green", "purple"),
#'     polygon_fill_gradient_style = "s"
#' )
#'
#' nr_feat_polys(
#'     polygon_fill_gradient = c("blue", "yellow", "red"),
#'     polygon_fill_gradient_style = "s"
#' )
#'
#' nr_feat_polys(
#'     polygon_fill_gradient = c(
#'         "darkgrey", "darkblue", "purple", "violet", "cyan"
#'     ),
#'     polygon_fill_gradient_style = "s"
#' )
#'
NULL



#' @describeIn set_default_color_continuous Framework function. Direct use
#' should be minimal. Specific wrapper functions should be used for each item
#' that needs defaults setting (plots or types of features).
#' @param instr_pal,instr_rev used by upstream function to pass specific
#' `giottoInstructions` params
#' @export
set_default_color_continuous <- function(
        colors = NULL, # used for function inputs
        midpoint = NULL,
        style = c("divergent", "sequential"),
        ...,
        instr_pal,
        instr_rev,
        data_default = NULL,
        type = c("fill", "color")) {
    if (!is.null(midpoint)) checkmate::assert_numeric(midpoint)
    if (!is.null(instr_pal)) checkmate::assert_character(instr_pal)
    if (!is.null(instr_rev)) checkmate::assert_logical(instr_rev)
    if (!is.null(data_default)) checkmate::assert_list(data_default)

    style <- g_match_arg(style[1], choices = c("divergent", "sequential"))
    type <- g_match_arg(type[1], choices = c("fill", "color"))

    # select gradient functions to use
    grad <- switch(type,
        "fill" = ggplot2::scale_fill_gradient,
        "color" = ggplot2::scale_color_gradient
    )
    gradn <- switch(type,
        "fill" = ggplot2::scale_fill_gradientn,
        "color" = ggplot2::scale_color_gradientn
    )
    grad2 <- switch(type,
        "fill" = ggplot2::scale_fill_gradient2,
        "color" = ggplot2::scale_color_gradient2
    )

    # global giotto options
    opt_pal <- switch(style,
        "divergent" = getOption("giotto.color_cd_pal"),
        "sequential" = getOption("giotto.color_cs_pal")
    )

    opt_rev <- getOption("giotto.color_c_rev", FALSE)

    # get 'colors' either from param input or options
    if (is.null(colors)) { # function-level input
        if (is.null(instr_pal)) {
            # instructions-level input (data type specific)
            if (!is.null(data_default)) {
                # global-level input (gradient style specific)
                colors <- data_default$pal
            } else {
                colors <- opt_pal
            }
        } else {
            colors <- instr_pal
        }
    }

    # get 'reverse'
    reverse <- ifelse(is.null(instr_rev), opt_rev, instr_rev)

    # evaluate 'colors'
    switch(style,
        "divergent" = .evaluate_color_gradient_divergent(
            colors = colors,
            reverse = reverse,
            midpoint = midpoint,
            grad2 = grad2,
            grad = grad,
            gradn = gradn,
            ...
        ),
        "sequential" = .evaluate_color_gradient_sequential(
            colors = colors,
            reverse = reverse,
            gradn = gradn,
            grad = grad,
            ...
        )
    )
}


.evaluate_color_gradient_divergent <- function(colors, reverse, midpoint, ..., grad2, grad, gradn) {
    if (is.null(midpoint)) midpoint <- 0

    if (inherits(colors, "character")) {
        if (length(colors) == 3L) {
            # assume simple palette if 3 entries in vector
            if (reverse) colors <- rev(colors)
            gradient <- grad2(
                low = colors[[1]],
                mid = colors[[2]],
                high = colors[[3]],
                midpoint = midpoint,
                ...
            )
        } else if (length(colors) == 2L) {
            if (reverse) colors <- rev(colors)
            gradient <- grad(
                low = colors[[1]],
                high = colors[[2]],
                ...
            )
        } else if (length(colors) == 1L) {
            # assume call to getColors() otherwise
            # return wrapped
            colors <- .get_palette_factory(
                pal = colors, rev = reverse,
                strategy = "cutoff"
            )(256)
            gradient <- gradn(
                colors = colors,
                rescaler = mid_rescaler(mid = midpoint), ...
            )
        } else { # assume custom palette
            gradient <- gradn(
                colors = colors,
                rescaler = mid_rescaler(mid = midpoint), ...
            )
        }
    } else if (inherits(colors, "ScaleContinuous")) {
        gradient <- colors
    } else {
        stop("set_default_color_continuous: unsupported 'color' input")
    }
    gradient
}

.evaluate_color_gradient_sequential <- function(colors, reverse, ..., gradn, grad) {
    if (inherits(colors, "character")) {
        if (length(colors) == 3L) {
            # assume simple palette if 3 entries in vector
            if (reverse) colors <- rev(colors)
            gradient <- gradn(colors = colors, ...)
        } else if (length(colors) == 2L) {
            if (reverse) colors <- rev(colors)
            gradient <- grad(
                low = colors[[1]],
                high = colors[[2]],
                ...
            )
        } else if (length(colors) == 1L) {
            # assume call to getColors() otherwise
            # return wrapped
            colors <- .get_palette_factory(
                pal = colors, rev = reverse,
                strategy = "cutoff"
            )(256)
            gradient <- gradn(colors = colors, ...)
        } else { # assume custom palette
            gradient <- gradn(colors = colors, ...)
        }
    } else if (inherits(colors, "ScaleContinuous")) {
        gradient <- colors
    } else {
        stop("set_default_color_continuous: unsupported 'color' input")
    }
    gradient
}


#' @rdname set_default_color_continuous
#' @export
set_default_color_continuous_cell <- function(colors = NULL,
    instrs,
    midpoint = NULL,
    style = "divergent",
    ...,
    data_default = NULL) {
    # read instructions
    instr_pal <- readGiottoInstructions(instrs, "cell_color_c_pal", NULL)
    instr_rev <- readGiottoInstructions(instrs, "cell_color_c_rev", NULL)

    set_default_color_continuous(
        colors = colors,
        instr_pal = instr_pal,
        instr_rev = instr_rev,
        midpoint = midpoint,
        style = style,
        data_default = data_default,
        ...
    )
}

#' @rdname set_default_color_continuous
#' @export
set_default_color_continuous_poly <- function(colors = NULL,
    instrs,
    midpoint = NULL,
    style = "divergent",
    ...) {
    # read instructions
    instr_pal <- readGiottoInstructions(instrs, "poly_color_c_pal", NULL)
    instr_rev <- readGiottoInstructions(instrs, "poly_color_c_rev", NULL)

    set_default_color_continuous(
        colors = colors,
        instr_pal = instr_pal,
        instr_rev = instr_rev,
        midpoint = midpoint,
        style = style,
        ...
    )
}


#' @rdname set_default_color_continuous
#' @export
set_default_color_continuous_heatmap <- function(colors = NULL,
    instrs,
    midpoint = NULL,
    style = "divergent",
    ...) {
    # read instructions
    instr_pal <- readGiottoInstructions(instrs, "heatmap_color_pal", NULL)
    instr_rev <- readGiottoInstructions(instrs, "heatmap_color_rev", NULL)

    set_default_color_continuous(
        colors = colors,
        instr_pal = instr_pal,
        instr_rev = instr_rev,
        midpoint = midpoint,
        style = style,
        ...
    )
}

#' @rdname set_default_color_continuous
#' @export
set_default_color_continuous_CCcom_heatmap <- function(colors = NULL,
    instrs,
    midpoint = NULL,
    style = "divergent",
    ...) {
    # read instructions
    instr_pal <- readGiottoInstructions(instrs, "CCcom_heatmap_color_pal", NULL)
    instr_rev <- readGiottoInstructions(instrs, "CCcom_heatmap_color_rev", NULL)

    set_default_color_continuous(
        colors = colors,
        instr_pal = instr_pal,
        instr_rev = instr_rev,
        midpoint = midpoint,
        style = style,
        data_default = list(
            pal = c("darkblue", "blue", "white", "red", "darkred")
        ),
        ...
    )
}

#' @rdname set_default_color_continuous
#' @export
set_default_color_continuous_CCcom_dotplot <- function(colors = NULL,
    instrs,
    midpoint = NULL,
    style = "divergent",
    ...,
    type = c("fill", "color"),
    data_default = list(
        pal = c("darkblue", "blue", "white", "red", "darkred")
    )) {
    # read instructions
    instr_pal <- readGiottoInstructions(instrs, "CCcom_dotplot_color_pal", NULL)
    instr_rev <- readGiottoInstructions(instrs, "CCcom_dotplot_color_rev", NULL)

    set_default_color_continuous(
        colors = colors,
        instr_pal = instr_pal,
        instr_rev = instr_rev,
        midpoint = midpoint,
        style = style,
        data_default = data_default,
        type = type,
        ...
    )
}





# TODO ####

# default background fill
# default point size




# info function ####

#' @name showColorInstructions
#' @title Show Giotto color instructions
#' @description Show the color instructions that are settable in Giotto.
#' A data.table of the information is invisibly returned
#' @returns data.table of Giotto color option information
#' @examples
#' showColorInstructions()
#'
#' @export
showColorInstructions <- function() {
    # DT vars
    option <- default <- description <- NULL

    out <- giotto_color_instructions[, paste(
        "\noption      : ", color_blue(option),
        "\ndefault     : ", default,
        "\ndescription : ", description,
        "\n"
    )]

    message(out)
    return(invisible(giotto_color_instructions))
}


# TODO update for additional CCcom and dotplots
giotto_color_instructions <- data.table::data.table(
    option = c(
        "'cell_color_d_pal'",
        "'poly_color_d_pal'",
        "'feat_color_pal'",
        "'heatmap_clus_color_pal'",
        "'cell_color_d_rev'",
        "'poly_color_d_rev'",
        "'feat_color_rev'",
        "'heatmap_clus_color_rev'",
        "'cell_color_d_strategy'",
        "'poly_color_d_strategy'",
        "'feat_color_strategy'",
        "'heatmap_clus_color_strategy'",
        "'cell_color_c_pal'",
        "'poly_color_c_pal'",
        "'cell_color_c_rev'",
        "'poly_color_c_rev'",
        "'heatmap_color_pal'",
        "'heatmap_color_rev'"
    ),
    default = c(
        "NULL (distinct colors)",
        "NULL (distinct colors)",
        "NULL (distinct colors)",
        "NULL (distinct colors)",
        "FALSE",
        "FALSE",
        "FALSE",
        "FALSE",
        "'interpolate'",
        "'interpolate'",
        "'interpolate'",
        "'interpolate'",
        "c('blue', 'white', 'red')",
        "c('blue', 'white', 'red')",
        "FALSE",
        "FALSE",
        "c('blue', 'white', 'red')",
        "FALSE"
    ),
    description = c(
        "Cell: color palette to use for discrete color values.
        Can be supplied as a the name of a palette accessible by `getColors()`,
        custom color vector, or an external function with a 'n' colors
        requested param",
        "Poly: color palette to use for discrete color values.
        Can be supplied as a the name of a palette accessible by `getColors()`,
        custom color vector, or an external function with a 'n' colors
        requested param",
        "Feat: color palette to use for discrete color values.
        Can be supplied as a the name of a palette accessible by `getColors()`,
        custom color vector, or an external function with a 'n' colors
        requested param",
        "Heatmap Clusters: color palette to use for discrete color values.
        Can be supplied as a the name of a palette accessible by `getColors()`,
        custom color vector, or an external function with a 'n' colors
        requested param",
        "Cell: whether discrete color values should be reversed",
        "Poly: whether discrete color values should be reversed",
        "Feat: whether discrete color values should be reversed",
        "Heatmap Clusters: whether discrete color values should be reversed",
        "Cell: 'interpolate', 'recycle', or 'cutoff'. Policy to use when more
        colors are requested than exist within palette.",
        "Poly: 'interpolate', 'recycle', or 'cutoff'. Policy to use when more
        colors are requested than exist within palette.",
        "Feat: 'interpolate', 'recycle', or 'cutoff'. Policy to use when more
        colors are requested than exist within palette.",
        "Heatmap Clusters: 'interpolate', 'recycle', or 'cutoff'. Policy to
        use when more colors are requested than exist within palette.",
        "Cell: color palette to use for continuous color values. Can be
        supplied as a the name of a palette accessible by `getColors()`,
        custom color vector, or an external function with a 'n' colors
        requested param",
        "Poly: color palette to use for continuous color values. Can be
        supplied as a the name of a palette accessible by `getColors()`,
        custom color vector, or an external function with a 'n' colors
        requested param",
        "Cell: whether continuous color values should be reversed",
        "Poly: whether continuous color values should be reversed",
        "Heatmap: color palette to use for continuous color values.
        Can be supplied as a the name of a palette accessible by `getColors()`,
        custom color vector, or an external function with a 'n' colors
        requested param",
        "Heatmap: whether continuous color values should be reversed"
    )
)
