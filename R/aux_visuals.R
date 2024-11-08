#' @include aux_save.R
NULL


# clusters ####

#' @title Decide cluster order
#' @name .decide_cluster_order
#' @description creates order for clusters
#' @inheritParams data_access_params
#' @param expression_values expression values to use
#' (e.g. "normalized", "scaled", "custom")
#' @param feats features to use (e.g. genes)
#' @param cluster_column name of column to use for clusters
#' (e.g. "leiden_clus")
#' @param cluster_order method to determine cluster order
#' (e.g. "size", "correlation", "custom")
#' @param cluster_custom_order custom order for clusters
#' @param cor_method method for correlation, default to 'pearson'
#' @param hclust_method method for hierarchical clustering, default to 'ward.D'
#' @return custom
#' @details Calculates order for clusters.
#' @keywords internal
.decide_cluster_order <- function(
        gobject,
        spat_unit = NULL,
        feat_type = NULL,
        expression_values = c("normalized", "scaled", "custom"),
        feats,
        cluster_column = NULL,
        cluster_order = c("size", "correlation", "custom"),
        cluster_custom_order = NULL,
        cor_method = "pearson",
        hclust_method = "ward.D") {
    # Set feat_type and spat_unit
    spat_unit <- set_default_spat_unit(
        gobject = gobject,
        spat_unit = spat_unit
    )
    feat_type <- set_default_feat_type(
        gobject = gobject,
        spat_unit = spat_unit,
        feat_type = feat_type
    )

    # expression data
    values <- match.arg(
        expression_values,
        unique(c(
            "normalized", "scaled", "custom",
            expression_values
        ))
    )
    expr_values <- getExpression(
        gobject = gobject,
        spat_unit = spat_unit,
        feat_type = feat_type,
        values = values,
        output = "matrix"
    )

    # subset expression data
    detected_feats <- feats[feats %in% rownames(expr_values)]
    # subset_values <- expr_values[rownames(expr_values) %in% detected_feats, ]

    # metadata
    cell_metadata <- pDataDT(gobject,
        spat_unit = spat_unit,
        feat_type = feat_type
    )

    ## check parameters
    if (is.null(cluster_column)) .gstop("cluster column must be selected")
    if (!cluster_column %in% colnames(cell_metadata)) {
        .gstop(
            "cluster column is not found in",
            str_bracket(spat_unit), str_bracket(feat_type),
            "metadata"
        )
    }

    ## cluster order ##
    cluster_order <- match.arg(
        cluster_order,
        c("size", "correlation", "custom")
    )


    if (cluster_order == "size") {
        ## sorts clusters from big to small (# of cells per cluster)
        clus_sort_sizes <- sort(table(cell_metadata[[cluster_column]]))
        clus_sort_names <- names(clus_sort_sizes)
    } else if (cluster_order == "correlation") {
        ## sorts clusters based on their correlation
        subset_matrix <- create_cluster_matrix(
            gobject = gobject,
            spat_unit = spat_unit,
            feat_type = feat_type,
            cluster_column = cluster_column,
            feat_subset = detected_feats,
            expression_values = values
        )

        cormatrix <- cor_flex(x = subset_matrix, method = cor_method)
        cordist <- stats::as.dist(1 - cormatrix, diag = TRUE, upper = TRUE)
        corclus <- stats::hclust(d = cordist, method = hclust_method)
        clus_names <- rownames(cormatrix)
        names(clus_names) <- seq_len(length(clus_names))
        clus_sort_names <- clus_names[corclus$order]
        clus_sort_names <- gsub(
            pattern = "cluster_",
            replacement = "", x = clus_sort_names
        )
    } else if (cluster_order == "custom") {
        ## sorts based on a given custom order
        if (is.null(cluster_custom_order)) {
            stop("\n custom order parameter is not given \n")
        }
        clus_sort_names <- cluster_custom_order
    }
    return(clus_sort_names)
}




# ggplot helper ####

#' @title aes_string2
#' @name aes_string2
#' @param \dots aes_string parameters
#' @keywords internal
#' @description makes sure aes_string can also be used with names that
#' start with numeric values
#' @keywords internal
#' @returns Aesthetics elements
#'
aes_string2 <- function(...) {
    args <- lapply(list(...), function(x) sprintf("`%s`", x))
    do.call(ggplot2::aes_string, args)
}


#' @title gg input
#' @name gg_input
#' @description modular handling of ggplot inputs for functions that may either
#' append additional information to a ggplot object or be where the ggobject is
#' first made.
#' @param ggobject ggplot object or NULL
#' @keywords internal
#' @returns A ggplot object
gg_input <- function(ggobject) {
    if (is.null(ggobject)) {
        return(ggplot2::ggplot())
    } else {
        checkmate::assert_class(ggobject, "ggplot")
        return(ggobject)
    }
}


# giotto point plotting ####

#' @title giotto_point
#' @name giotto_point
#' @description Plot a point scatter layer via one of ggplot::geom_point,
#' scattermore::geom_scattermore or scattermore::geom_scattermost
#' @param plot_method which scatter plotting method to use.
#' @param size point size parameter
#' @param ext SpatVector. Spatial extent of the plotting region. Used when
#' considering raster size for rasterization with scattermore and scattermost
#' @param scattermost_xy 2-column object with data. Used with scattermost since
#' it doesn't talk to ggplot
#' @param scattermost_color Color vector (or a single color). Used with
#' scattermost since it doesn't talk to ggplot
#' @param \dots geom_point parameters
#' @keywords internal
#' @noRd
#' @returns ggplot2::geom_point layer
giotto_point <- function(
        plot_method = c("ggplot", "scattermore", "scattermost"),
        size = 1,
        ext,
        scattermost_xy = NULL,
        scattermost_color = NULL,
        ...) {
    plot_method <- match.arg(
        arg = plot_method,
        choices = c("ggplot", "scattermore", "scattermost")
    )

    px <- getOption("giotto.plot_point_raster", 5e5)
    if (!missing(ext)) {
        edim <- setNames(range(ext), NULL)
        ext_area <- prod(edim)
        px_per_unit <- px / ext_area
        pixels <- ceiling(edim * sqrt(px_per_unit))
    } else {
        pixels <- rep(ceiling(sqrt(px)), 2L)
    }

    # assemble argslist
    a <- list(...)

    if (plot_method %in% c("scattermore", "scattermost")) {
        a$pointsize <- size
        a$pixels <- pixels
        vmsg(.is_debug = TRUE, "rasterization dims:", pixels)
    } else {
        a$size <- size
    }

    # dispatch to plot method
    switch(plot_method,
        "ggplot" = {
            do.call(ggplot2::geom_point, a)
        },
        "scattermore" = {
            package_check(pkg_name = "scattermore", repository = "CRAN")
            do.call(scattermore::geom_scattermore, a)
        },
        "scattermost" = {
            package_check(pkg_name = "scattermore", repository = "CRAN")
            a$xy <- scattermost_xy
            a$color <- scattermost_color
            do.call(scattermore::geom_scattermost, a)
        }
    )
}





# rescale values ####

# based on ggplot2 internal
mid_rescaler <- function(mid) {
    function(x, to = c(0, 1), from = range(x, na.rm = TRUE)) {
        scales::rescale_mid(x, to, from, mid)
    }
}






# plotly helper ####

#' @title plotly_network
#' @name plotly_network
#' @description provide network segment to draw in 3D plot_ly()
#' @param network network object
#' @param x default to "sdimx_begin"
#' @param y default to "sdimy_begin"
#' @param z default to "sdimz_begin"
#' @param x_end default to "sdimx_end"
#' @param y_end default to "sdimy_end"
#' @param z_end default to "sdimz_end"
#'
#' @returns edges in network as data.table
#'
#' @export
plotly_network <- function(network,
    x = "sdimx_begin",
    y = "sdimy_begin",
    z = "sdimz_begin",
    x_end = "sdimx_end",
    y_end = "sdimy_end",
    z_end = "sdimz_end") {
    edges <- data.table::data.table(
        edge_id = seq_len(3 * dim(network)[1]),
        x = 0,
        y = 0,
        z = 0
    )

    edges[edges$edge_id %% 3 == 1]$x <- as.double(network[[x]])
    edges[edges$edge_id %% 3 == 1]$y <- as.double(network[[y]])
    edges[edges$edge_id %% 3 == 1]$z <- as.double(network[[z]])

    edges[edges$edge_id %% 3 == 2]$x <- as.double(network[[x_end]])
    edges[edges$edge_id %% 3 == 2]$y <- as.double(network[[y_end]])
    edges[edges$edge_id %% 3 == 2]$z <- as.double(network[[z_end]])

    edges[edges$edge_id %% 3 == 0]$x <- NA
    edges[edges$edge_id %% 3 == 0]$y <- NA
    edges[edges$edge_id %% 3 == 0]$z <- NA

    return(edges)
}


#' @title plotly_grid
#' @name plotly_grid
#' @description provide grid segment to draw in plot_ly()
#'
#' @param x_start default to "x_start"
#' @param y_start default to "y_start"
#' @param x_end default to "x_end"
#' @param y_end default to "y_end"
#' @param spatial_grid spatial_grid in giotto object
#'
#' @returns edges in spatial grid as data.table()
#' @examples
#' g <- GiottoData::loadGiottoMini("visium", verbose = FALSE)
#'
#' library(GiottoClass)
#' g <- createSpatialGrid(gobject = g,
#' sdimx_stepsize = 400,
#' sdimy_stepsize = 400,
#' minimum_padding = 0)
#'
#' my_spatial_grid <- getSpatialGrid(g)
#'
#' plotly_grid(my_spatial_grid)
#'
#' @export
plotly_grid <- function(
        spatial_grid,
        x_start = "x_start",
        y_start = "y_start",
        x_end = "x_end",
        y_end = "y_end") {
    edge_num <- length(unique(spatial_grid[[x_start]])) +
        length(unique(spatial_grid[[y_start]])) + 2
    x_line <- unique(as.numeric(unlist(spatial_grid[, c(x_start, x_end)])))
    y_line <- unique(as.numeric(unlist(spatial_grid[, c(y_start, y_end)])))

    x_min <- min(spatial_grid[[x_start]])
    x_max <- max(spatial_grid[[x_end]])

    y_min <- min(spatial_grid[[y_start]])
    y_max <- max(spatial_grid[[y_end]])

    edges <- data.table::data.table(
        edge_id = seq_len(edge_num),
        x = 0, y = 0, x_end = 0, y_end = 0
    )

    edges[seq_len(length(x_line)), ]$x <- x_line
    edges[seq_len(length(x_line)), ]$x_end <- x_line
    edges[seq_len(length(x_line)), ]$y <- y_min
    edges[seq_len(length(x_line)), ]$y_end <- y_max

    edges[(length(x_line) + 1):edge_num, ]$x <- x_min
    edges[(length(x_line) + 1):edge_num, ]$x_end <- x_max
    edges[(length(x_line) + 1):edge_num, ]$y <- y_line
    edges[(length(x_line) + 1):edge_num, ]$y_end <- y_line

    return(edges)
}


#' @title plotly_axis_scale_3D
#' @name plotly_axis_scale_3D
#' @description adjust the axis scale in 3D plotly plot
#' @param cell_locations spatial_loc in giotto object
#' @param sdimx x axis of cell spatial location
#' @param sdimy y axis of cell spatial location
#' @param sdimz z axis of cell spatial location
#' @param mode axis adjustment mode
#' @param custom_ratio set the ratio artificially
#' @returns edges in spatial grid as data.table()
#' @examples
#' my_cell_locations <- data.frame(x = sample(10), y = sample(10),
#' z = sample(10))
#' plotly_axis_scale_3D(my_cell_locations)
#'
#' @export
plotly_axis_scale_3D <- function(
        cell_locations,
        sdimx = NULL,
        sdimy = NULL,
        sdimz = NULL,
        mode = c("cube", "real", "custom"),
        custom_ratio = NULL) {
    mode <- match.arg(mode, c("cube", "real", "custom"))
    if (mode == "real") {
        x_ratio <- max(cell_locations[[sdimx]]) - min(cell_locations[[sdimx]])
        y_ratio <- max(cell_locations[[sdimy]]) - min(cell_locations[[sdimy]])
        z_ratio <- max(cell_locations[[sdimz]]) - min(cell_locations[[sdimz]])

        min_size <- min(x_ratio, y_ratio, z_ratio)
        x_ratio <- round(x_ratio / min_size)
        y_ratio <- round(y_ratio / min_size)
        z_ratio <- round(z_ratio / min_size)
    } else if (mode == "cube") {
        x_ratio <- 1
        y_ratio <- 1
        z_ratio <- 1
    } else {
        if (is.null(custom_ratio) | length(custom_ratio) < 3) {
            stop("\n Please specify your costom axis scale,
                or choose axis_scale = \"real\"/\"cube\"\n")
        } else {
            x_ratio <- custom_ratio[1]
            y_ratio <- custom_ratio[2]
            z_ratio <- custom_ratio[3]
        }
    }
    ratio <- list(x_ratio, y_ratio, z_ratio)
    return(ratio)
}


#' @title plotly_axis_scale_2D
#' @name plotly_axis_scale_2D
#' @description adjust the axis scale in 2D plotly plot
#' @param cell_locations spatial_loc in giotto object
#' @param sdimx x axis of cell spatial location
#' @param sdimy y axis of cell spatial location
#' @param mode axis adjustment mode
#' @param custom_ratio set the ratio artificially
#' @returns edges in spatial grid as data.table()
#' @examples
#' my_cell_locations <- data.frame(x = sample(10), y = sample(10))
#' plotly_axis_scale_2D(my_cell_locations)
#'
#' @export
plotly_axis_scale_2D <- function(
        cell_locations,
        sdimx = NULL,
        sdimy = NULL,
        mode = c("cube", "real", "custom"),
        custom_ratio = NULL) {
    mode <- match.arg(mode, c("cube", "real", "custom"))
    if (mode == "real") {
        x_ratio <- max(cell_locations[[sdimx]]) - min(cell_locations[[sdimx]])
        y_ratio <- max(cell_locations[[sdimy]]) - min(cell_locations[[sdimy]])

        min_size <- min(x_ratio, y_ratio)
        x_ratio <- round(x_ratio / min_size)
        y_ratio <- round(y_ratio / min_size)
    } else if (mode == "cube") {
        x_ratio <- 1
        y_ratio <- 1
    } else {
        if (is.null(custom_ratio) | length(custom_ratio) < 2) {
            stop("\n Please specify your costom axis scale,
                or choose axis_scale = \"real\"/\"cube\"\n")
        } else {
            x_ratio <- custom_ratio[1]
            y_ratio <- custom_ratio[2]
        }
    }
    ratio <- list(x_ratio, y_ratio)
    return(ratio)
}
