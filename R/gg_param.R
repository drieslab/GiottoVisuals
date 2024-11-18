.handle_param_dups <- function(x, warn = TRUE, what = "aes") {
    ns <- names(x)
    dups <- duplicated(ns, fromLast = TRUE)

    if (sum(dups) > 0L) {
        if (warn) {
            dup_ns <- unique(ns[dups])
            warning(wrap_txtf(
                "Duplicate %s param found for: `%s`.
                Using last provided",
                what,
                paste(dup_ns, collapse = "`, `")
            ), call. = FALSE)
        }
        x <- x[!dups]
    }
    return(x)
}


#' @name combine_aes
#' @title Combine ggplot2 aesthetics
#' @description Utility for combining ggplot2 `aes` lists. Uses the last
#' provided value when aes names overlap.
#' @param ... one or more objects of class `uneval`
#' (output from [ggplot2::aes()])
#' @param warn_duplicates logical. Warn when aes names overlap
#' @examples
#' a <- ggplot2::aes(a = a1, b = b1, c = c1)
#' b <- ggplot2::aes(x = x1, y = y1, a = a2, c = c2)
#'
#' # warnings turned off
#' combine_aes(a, b, warn_duplicates = FALSE) # b values used for a,c
#' combine_aes(b, a, warn_duplicates = FALSE) # a values used for a,c
#' @family ggplot2 plotting wrangling functions
#' @export
combine_aes <- function(..., warn_duplicates = TRUE) {
    input <- list(...)
    # checkmate::assert_list(input, "uneval")
    res <- do.call(c, input)
    res <- .handle_param_dups(res, warn = warn_duplicates, what = "aes")

    class(res) <- "uneval"
    return(res)
}


#' @name gg_param
#' @title Generate ggplot params
#' @description Based on a set of named inputs, organize them into either
#' ggplot2 aesthetic mappings or toplevel params based on whether they are or
#' are not of the classes `quosure`, `name`, or a language object. The `data`
#' param may be applied here or added afterwards\cr
#'
#' This is mainly a convenience for developers. Users should still use `aes()`
#' and `quo()` for their environment-enclosing characteristics. Inside of
#' packages however, the proper environments for code to run is already
#' available, or can be already processed before passing to plotting.
#' @param data data to plot
#' @param warn_duplicates logical. Warn when aes names provided through ...
#' overlap.
#' @param ... One or more named plotting params. Entries should either be
#' individually named params or lists of named parameters / `aes()` generated
#' aesthetic lists.
#' @examples
#' # data to use
#' library(ggplot2)
#' d <- data.frame(
#'     xvals = seq(10),
#'     yvals = seq(10),
#'     values = seq(0.1, 1, by = 0.1),
#'     size_col = seq(5, 1, length.out = 10)
#' )
#'
#' # ----- single step ----- #
#' p_single <- gg_param(
#'     data = d,
#'     x = as.name("xvals"), # aes
#'     fill = "green", # toplevel
#'     aes(
#'         size = size_col, # aes
#'         y = yvals # aes
#'     ),
#'     show.legend = TRUE, # toplevel
#'     list(
#'         shape = 21, # toplevel
#'         alpha = as.name("values") # aes
#'     )
#' )
#'
#' ggplot() +
#'     do.call(geom_point, p_single)
#'
#' # ----- multistep appending ----- #
#'
#' p0 <- list()
#'
#' # add aesthetics directly through assignment
#' p0$x <- as.name("xvals")
#' p0$show.legend <- TRUE
#'
#' # add aesthetics through `c()` list concatenation
#' # list objects are unnamed and thus are best added this way
#' p0 <- c(p0, list(fill = "green"))
#' p0 <- c(p0, aes(size = size_col, y = yvals))
#' p0 <- c(p0, list(shape = 21, alpha = as.name("values")))
#'
#' # add data
#' p0$data <- d
#'
#' # `quote = TRUE` must be used when using `do.call()` for this
#' p_multi <- do.call(gg_param, p0, quote = TRUE)
#' ggplot() +
#'     do.call(geom_point, p_multi)
#'
#' # ----- nested appending ----- #
#' p_nest <- gg_param(p_single, p_multi)
#' p_nest_sub <- gg_param(p_single, p_multi, data = d[1:5, ]) # change the data to use
#'
#' ggplot() +
#'     do.call(geom_point, p_nest)
#' ggplot() +
#'     do.call(geom_point, p_nest_sub)
#' @family ggplot2 plotting wrangling functions
#' @export
gg_param <- function(..., data = NULL, warn_duplicates = TRUE) {
    input <- c(...)

    # handle nested aes inputs
    in_mapping <- input$mapping
    while (!is.null(in_mapping)) {
        if (inherits(in_mapping, "uneval")) {
            input$mapping <- NULL
            input <- c(input, in_mapping)
        } else {
            stop("`mapping` is a protected param name. Do not use.")
        }
        in_mapping <- input$mapping
    }

    # select last data provided
    if ("data" %in% names(input)) {
        use_data <- input[[tail(which(names(input) == "data"), 1L)]]
        # cleanup `data` entries
        while ("data" %in% names(input)) {
            input$data <- NULL
        }
        if (warn_duplicates && is.null(data)) {
            warning("multiple `data` objects given. Using last one.")
        }
        # replace `data` with last entry if not provided through `data` param
        data <- data %null% use_data
    }

    # empty inputs - return early with empty list (with possible data)
    if (length(input) == 0L) {
        return(list(data = data))
    }

    # check param names
    if (any(is.null(names(input)))) {
        stop("All params must be named", call. = FALSE)
    }

    # param sorting
    is_nse <- vapply(
        FUN.VALUE = logical(1L), input, function(param) {
            inherits(param, c("quosure", "name")) || is.language(param)
        }
    )

    # param dups
    a_items <- input[is_nse]
    a_items <- combine_aes(a_items, warn_duplicates = warn_duplicates)
    p_items <- input[!is_nse]
    p_items <- .handle_param_dups(
        p_items,
        warn = warn_duplicates, what = "toplevel"
    )

    p_items$mapping <- a_items
    p_items$data <- data
    class(p_items) <- "gplot_param"
    return(p_items)
}
