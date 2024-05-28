# Sankey plotting functionality with networkD3
# node values are 0 indexed


# giottoSankeyPlan class ####


#' @title S4 giottoSankeyPlan class
#' @name giottoSankeyPlan
#' @aliases giottoSankeyPlan-class
#' @description
#' Object to organize the sets of information to select from a Giotto object's
#' metadata to compare across annotations from the same or across spatial
#' units and feature types.
#' @slot set_address subnesting location within Giotto object of metadata info
#' stored as a data.table
#' @slot set_subset a subset to apply upon the metadata info for a set
#' @slot set_label character label to apply to a set
#' @slot data_type whether the metadata is cell or feat
#' @slot relations data.table of from and to comparisons between sets. The sets
#' are referred to as zero indexed integers.
#' @returns giottoSankeyPlan
#' @export giottoSankeyPlan
#' @exportClass giottoSankeyPlan
giottoSankeyPlan <- setClass(
    "giottoSankeyPlan",
    slots = list(
        set_address = "data.table", # spat_unit, feat_type, col
        set_subset = "list", # subset vector for node
        set_label = "character",
        data_type = "character", # type of info (cell or feat)
        relations = "data.table" # from, to
    ),
    prototype = list(
        set_address = data.table::data.table(),
        relations = data.table::data.table()
    )
)


setMethod("show", signature = "giottoSankeyPlan", function(object) {
    cat(
        "giottoSankeyPlan --",
        paste("N:", nrow(object@set_address)), # nodes
        paste("R:", nrow(object@relations))
    ) # relations/links
    cat("\n")
    if (nrow(object@set_address) > 0L) {
        print(sankeySetAddresses(object))
    }
    if (nrow(object@relations) > 0L) {
        rels <- head(object@relations)
        if (nrow(object@relations) > 6L) cat("first 6 relations...")
        print(rels)
    }
    cat("\n")
})

# generics ####
setGeneric(
    "sankeyRelate",
    function(x, ...) standardGeneric("sankeyRelate")
)
setGeneric(
    "sankeyRelate<-",
    function(x, add, value) standardGeneric("sankeyRelate<-")
)
setGeneric(
    "sankeyPlot",
    function(x, y, ...) standardGeneric("sankeyPlot")
)


# methods ####

# * sankeyRelate ####

#' @name sankeyRelate
#' @title Set a relation between two sankey sets
#' @aliases sankeyRelate<-
#' @description
#' Set a relation to be compared across two sets of metadata annotations in the
#' Giotto object.
#' @param x giottoSankeyPlan object
#' @param add logical. whether relation to add through `value` should be
#' appended or replace all existing relations
#' @param \dots additional params to pass
#' @param value numerical vector (zero indexed) of sets to compare
#' @returns giottoSankeyPlan
NULL


# ** get relations ####
#' @rdname sankeyRelate
#' @export
setMethod("sankeyRelate", signature("giottoSankeyPlan"), function(x, ...) {
    return(x@relations)
})

# ** replace relations ####
#' @rdname sankeyRelate
#' @export
setMethod(
    "sankeyRelate<-",
    signature(x = "giottoSankeyPlan", add = "logical", value = "data.frame"),
    function(x, add, value) {
        if (nrow(x@relations) == 0L || # no entries
            !add) {
            if (ncol(value) != 2) stop("2 columns expected")
            if (!all(colnames(value) == c("from", "to"))) {
                stop("Cols 'from' and 'to' expected")
            }
            dt <- data.table::as.data.table(value)
            x@relations <- value # direct replacement
        } else {
            x@relations <- rbind(x@relations, value) %>%
                unique()
        }

        return(x)
    }
)

#' @rdname sankeyRelate
#' @export
setMethod(
    "sankeyRelate<-",
    signature(x = "giottoSankeyPlan", add = "logical", value = "numeric"),
    function(x, add, value) {
        if (length(value) != 2L) {
            .gstop(
                "When value is provided as numeric/integer,
                input must be length of 2,",
                "designating nodes 'from' and 'to'"
            )
        }
        value <- as.integer(value)

        if (add) {
            # rbind to append
            x@relations <- rbind(
                x@relations,
                data.table::data.table(
                    from = value[1],
                    to = value[2]
                )
            )
            x@relations <- unique(x@relations)
        } else {
            # replace
            x@relations <- data.table::data.table(
                from = value[1],
                to = value[2]
            )
        }

        return(x)
    }
)

#' @rdname sankeyRelate
#' @export
setMethod(
    "sankeyRelate<-",
    signature(x = "giottoSankeyPlan", add = "logical", value = "character"),
    function(x, add, value) {
        if (length(x@set_label) == 0L) stop("No node labels found.")
        # match to node names
        node_ids <- match(c(value[1], value[2]), x@set_label)
        sankeyRelate(x, add) <- node_ids # pass to numeric
        return(x)
    }
)

#' @rdname sankeyRelate
#' @export
setMethod( # provide default add behavior if missing
    "sankeyRelate<-",
    signature(x = "giottoSankeyPlan", add = "missing", value = "ANY"),
    function(x, value) {
        sankeyRelate(x, add = TRUE) <- value
        return(x)
    }
)

#' @rdname sankeyRelate
#' @export
setMethod( # remove all
    "sankeyRelate<-",
    signature(x = "giottoSankeyPlan", add = "missing", value = "NULL"),
    function(x, value) {
        x@relations <- NULL
        x
    }
)

# sankeyLabel ####

#' @title Get and set the sankey labels information
#' @name sankeyLabel
#' @param x giottoSankeyPlan
#' @returns character
#' @examples
#' my_sankeyplan <- sankeySet(spat_unit = "cell", 
#' feat_type = "rna", col = "leiden_clus")
#' my_sankeyplan <- `sankeyLabel<-`(my_sankeyplan, value = "my_label")
#' sankeyLabel(my_sankeyplan)
#' 
#' @export
sankeyLabel <- function(x) {
    return(x@set_label)
}

#' @rdname sankeyLabel
#' @param value values to set
#' @returns a `giottoSankeyPlan`
#' @examples
#' my_sankeyplan <- sankeySet(spat_unit = "cell", 
#' feat_type = "rna", col = "leiden_clus")
#' my_sankeyplan <- `sankeyLabel<-`(my_sankeyplan, value = "my_label")
#' @export
`sankeyLabel<-` <- function(x, value) {
    x@set_label <- value
    return(x)
}



# + giottoSankeyPlan combining ####

#' @rdname hidden_aliases
#' @export
# Multiple references to the same address are not allowed
# e1 values will be taken in all such cases
#' @param e1,e2 giottoSankeyPlan
setMethod(
    "+", signature("giottoSankeyPlan", "giottoSankeyPlan"),
    function(e1, e2) {
        # DT vars
        from <- to <- NULL

        # update addresses
        e1@set_address <- rbind(e1@set_address, e2@set_address)
        if (any(duplicated(
            e1@set_address[, c("spat_unit", "feat_type", "col")]))) {
            stop(
            "Not possible to append more than one reference to the same node")
            # TODO try to recover
        }

        # update relations
        if (nrow(e2@relations) > 0L) {
            e1_n_nodes <- nrow(e1@set_address)
            e2_rels <- data.table::copy(e2@relations)
            e2_rels[, from := from + e1_n_nodes]
            e2_rels[, to := to + e1_n_nodes]

            e1@relations <- rbind(e1@relations, e2_rels)
        }


        # update labels
        e1@set_label <- c(e1@set_label, e2@set_label)

        # update subsets
        e1@set_subset <- c(e1@set_subset, e2@set_subset)

        e1
    }
)




# functions ####



#' @name sankeySet
#' @title Create a `giottoSankeyPlan` with one set of annotations
#' @param spat_unit spatial unit of the metadata
#' @param feat_type feature type of the metadata
#' @param col which column of metadata to pull from. Must be data that
#' can be treated categorically.
#' @param index character, integer, or logical vector to subset metadata table
#' @param label (optional) character label for a set
#' @returns a `giottoSankeyPlan`
#' @examples
#' my_sankeyplan <- sankeySet(spat_unit = "cell", 
#' feat_type = "rna", col = "leiden_clus")
#' 
#' @keywords plotting sankey
#' @export
sankeySet <- function(spat_unit = NULL,
    feat_type = NULL,
    col, index = NULL,
    label = NA_character_) {
    x <- giottoSankeyPlan(
        set_address = data.table::data.table(
            spat_unit = spat_unit,
            feat_type = feat_type,
            col = col
        ),
        set_subset = list(index)
    )
    x@set_label <- label
    x
}


#' @title Apply subset index on a sankey set
#' @name subsetSankeySet
#' @param x giottoSankeyPlan object
#' @param set_id set index or node label
#' @param index new index subset, provided in the same order as the set_id
#' @returns a `giottoSankeyPlan`
#' @keywords plotting sankey
#' 
#' @export
subsetSankeySet <- function(x, set_id, index = list()) {
    if (!is.list(index)) index <- list(index)
    if (is.character(set_id)) set_id <- match(set_id, x@set_label)

    if (!set_id %in% seq(nrow(x@set_address))) {
        stop("provided set id is not in the giottoSankeyPlan object")
    }

    for (i in seq_along(set_id)) {
        x@set_subset[i] <- index[i]
    }
    x
}


#' @title Data.table of sankey set locations
#' @name sankeySetAddresses
#' @description Return a data.table containing where the sets of metadata to
#' relate to each other exists inside the Giotto object.
#' @param x giottoSankeyPlan object
#' @returns a `giottoSankeyPlan`
#' @examples
#' my_sankeyplan <- sankeySet(spat_unit = "cell", 
#' feat_type = "rna", col = "leiden_clus")
#' my_sankeyplan <- sankeySetAddresses(my_sankeyplan)
#' 
#' @export
#' @keywords plotting sankey
sankeySetAddresses <- function(x) {
    combined_dt <- cbind(x@set_address, x@set_subset)
    colnames(combined_dt)[4] <- "index"
    combined_dt
}




#' @title Calculations for a sankey relationship pair
#' @name .sankey_compare
#' @description
#' Generate the data.table of source, target, and value for a relation pair as
#' well as the list of node names to be used with sankey plotting.
#' @param data_dt data.table with two columns. Each should contain
#' categorical data.
#' @param idx_start starting index of nodes
#' @keywords internal
#' @return list with 1. node names and 2. data.table with cols source, target,
#' and value
.sankey_compare <- function(data_dt, idx_start = 0) {
    # DT vars
    source <- target <- value <- NULL

    # Produce data.table of source, target, and value for the relation pair
    # This is a table of [links] between nodes
    c_names <- colnames(data_dt)
    links <- data.table::as.data.table(
        data_dt[, table(get(c_names[1]), get(c_names[2]))]
    )
    data.table::setnames(links, new = c("source", "target", "value"))

    # Remove any rows where value is 0. No need to include links between groups
    # that are not substantiated
    links <- links[value > 0L]

    # Collect node names
    # These node names now define [nodes] to map the data.table source and
    # target column values to.
    source_names <- links[, source]
    target_names <- links[, target]

    # combine unique node values into single character vector, starting with
    # source nodes. Additionally, ensure nodes are of type character.
    nodes <- c(source_names, target_names) %>%
        unique() %>%
        as.character()

    # Convert source and target columns to integer mappings to unique names.
    # !These integer mappings are zero indexed!
    links[, source := match(source, nodes) - 1 + idx_start]
    links[, target := match(target, nodes) - 1 + idx_start]

    # return data.table of links and the character vector of nodes
    return_list <- list(
        links = links,
        nodes = nodes
    )

    return(return_list)
}





#' @name .sankey_relation_pair
#' @title Calculations for a sankey relationship pair
#' @description
#' Get matched values to compare from the giotto object. Comparison columns
#' are then passed as a data.table to `.sankey_compare` to be calculated.
#' @param g giotto object
#' @param gsp giottoSankeyPlan object
#' @param rel_idx index of relation pair in `gsp`
#' @param node_idx_start starting index to assign new nodes
#' @returns list with 1. node names and 2. data.table with cols source, target,
#' and value
#' @keywords internal
.sankey_relation_pair <- function(g, gsp, rel_idx, node_idx_start = 0) {
    rel <- gsp@relations[rel_idx]
    from_address <- sankeySetAddresses(gsp)[rel$from + 1]
    to_address <- sankeySetAddresses(gsp)[rel$to + 1]

    # Data type being compared. Either cell or feat
    data_type <- gsp@data_type
    if (is.null(data_type)) data_type <- "cell"
    # Determines which type of metadata to get
    meta_get_fun <- switch(data_type,
        "cell" = getCellMetadata,
        "feat" = getFeatureMetadata
    )
    id_col <- switch(data_type,
        "cell" = "cell_ID",
        "feat" = "feat_ID"
    )

    # get metadata
    # Defaults for spat_unit and feat_type are set inside of the getter if they
    # are provided as NULL
    meta_from <- meta_get_fun(
        gobject = g,
        spat_unit = from_address$spat_unit,
        feat_type = from_address$feat_type,
        output = "cellMetaObj",
        copy_obj = TRUE,
        set_defaults = TRUE
    )
    meta_to <- meta_get_fun(
        gobject = g,
        spat_unit = to_address$spat_unit,
        feat_type = to_address$feat_type,
        output = "cellMetaObj",
        copy_obj = TRUE,
        set_defaults = TRUE
    )

    # perform subset
    # 1. subobject subsetting does not drop ID col
    # 2. drop to data.table
    # 3. DT key on id col so that join is easier to perform
    idx_from <- unlist(from_address$index)
    idx_to <- unlist(to_address$index)
    if (!is.null(idx_from)) {
        meta_from <- meta_from[idx_from]
    }
    if (!is.null(idx_to)) {
        meta_to <- meta_to[idx_to]
    }
    meta_from <- meta_from[, from_address$col][]
    meta_to <- meta_to[, to_address$col][]
    data.table::setkeyv(meta_from, id_col)
    data.table::setkeyv(meta_to, id_col)

    # DT join on ids, then remove ids
    test_dt <- meta_from[meta_to]
    test_dt[, (id_col) := NULL]

    res <- .sankey_compare(
        data_dt = test_dt,
        idx_start = node_idx_start
    )

    return(res)
}







# sankeyPlot methods ####


#' @title Create a sankey plot
#' @name sankeyPlot
#' @description
#' Create a sankey plot. Pulls from information metadata if giotto object is
#' provided. Simple 1 to 1 sankeys can be generated from a single spatial unit
#' and feature type using the `spat_unit`, `feat_type`, `meta_type`, `cols`,
#' and (optionally) `idx` params. More complex and cross spatial unit/feature
#' type sankeys can be set up using the `sankey_plan` param which accepts a
#' `giottoSankeyPlan` object.\cr
#' Also possible to directly use data.frames or lists of data.frames and
#' giottoPolygon objects. See usage section and examples.
#' @param x data source (gobject, data.frame-like object with relations
#' between the first two cols provided, or giottoPolygon)
#' @param y giottoSankeyPlan object or character vector referring to source and
#' target columns in metadata if x is a gobject. Can also be missing or a
#' second giottoPolygon (see usage section)
#' @param meta_type build sankey on cell or feature metadata
#' @param spat_unit spatial unit of metadata
#' @param feat_type feature type of metadata
#' @param meta_type whether to use 'cell' (cell) or 'feat' (feature) metadata
#' @param idx table subset index for 1 to 1 comparisons
#' @param focus_names character vector of node names to display. Others will be
#' omitted.
#' @param unfocused_color whether to color nodes that are not focused on.
#' @inheritDotParams networkD3::sankeyNetwork -Links -Nodes -Source -Target
#' -Value -NodeID
#' @returns sankey plot
#' @examples
#' x <- data.frame(
#'     col1 = c("a", "a", "b"),
#'     col2 = c("1", "2", "2")
#' )
#' sankeyPlot(x)
#'
#' y <- data.frame(
#'     col1 = "1",
#'     col2 = c("A", "B", "C")
#' )
#'
#' # combine data.frames of relations
#' # rbind: note that node "1" is mapped the same for x and y
#' sankeyPlot(rbind(x, y), fontSize = 20)
#'
#' # list: note that node "1" is now considered a different node between x and y
#' sankeyPlot(list(x, y), fontSize = 20)
#'
#' # focus on specific nodes/names
#' sankeyPlot(rbind(x, y), fontSize = 20, focus_names = c("a", "1", "B"))
#'
#' g <- GiottoData::loadGiottoMini("vizgen")
#' # with giottoSankeyPlan
#' leiden <- sankeySet(
#'     spat_unit = "aggregate",
#'     feat_type = "rna",
#'     col = "leiden_clus"
#' )
#' louvain <- sankeySet(
#'     spat_unit = "aggregate",
#'     feat_type = "rna",
#'     col = "louvain_clus"
#' )
#' # place defined sets into same object
#' plan <- leiden + louvain
#' # assign relationships to compare
#' sankeyRelate(plan) <- c(0, 1)
#' sankeyPlot(g, plan)
#'
#' # with single set of metadata
#' GiottoClass::activeSpatUnit(g) <- "aggregate"
#' sankeyPlot(g, c("louvain_clus", "leiden_clus"))
#' @keywords plotting sankey
NULL


#' @rdname sankeyPlot
#' @export
setMethod(
    "sankeyPlot",
    signature(
        x = "giotto",
        y = "giottoSankeyPlan"
    ),
    function(x,
    y,
    meta_type = c("cell", "feat"),
    focus_names = NULL,
    unfocused_color = FALSE,
    ...) {
        GiottoUtils::package_check("networkD3")
        meta_type <- match.arg(meta_type, choices = c("cell", "feat"))
        y@data_type <- meta_type

        # DT vars
        source <- target <- NULL

        # iterate through sankey relations in the giottoSankeyPlan
        node_idx_start <- 0
        links_dt <- data.table::data.table()
        nodes <- c()

        for (rel_i in seq(nrow(sankeyRelate(y)))) {
            rel_data <- .sankey_relation_pair(
                g = x,
                gsp = y,
                rel_idx = rel_i,
                node_idx_start = node_idx_start
            )

            # append data
            links_dt <- rbind(links_dt, rel_data$links)
            nodes <- c(nodes, rel_data$nodes)

            # update start index
            node_idx_start <- links_dt[, max(source, target)] + 1
        }

        # create nodes table
        nodes <- data.table::data.table(name = nodes)

        .sankey_networkd3(
            Links = links_dt,
            Nodes = nodes,
            Source = "source",
            Target = "target",
            Value = "value",
            NodeID = "name",
            focus_names = focus_names,
            unfocused_color = unfocused_color,
            ...
        )
    }
)



#' @rdname sankeyPlot
#' @export
setMethod(
    "sankeyPlot",
    signature(
        x = "giotto",
        y = "character"
    ),
    function(
        x,
        y,
        spat_unit = NULL,
        feat_type = NULL,
        meta_type = c("cell", "feat"),
        idx = NULL,
        focus_names = NULL,
        unfocused_color = FALSE,
        ...) {
        GiottoUtils::package_check("networkD3")
        checkmate::assert_character(y, len = 2L)

        # Data type being compared. Either cell or feat
        meta_type <- match.arg(meta_type, choices = c("cell", "feat"))
        # Determines which type of metadata to get
        meta_get_fun <- switch(meta_type,
            "cell" = getCellMetadata,
            "feat" = getFeatureMetadata
        )
        id_col <- switch(meta_type,
            "cell" = "cell_ID",
            "feat" = "feat_ID"
        )

        # get metadata
        # Defaults for spat_unit and feat_type are set inside of the getter
        # if they are provided as NULL
        meta_cm <- meta_get_fun(
            gobject = x,
            spat_unit = spat_unit,
            feat_type = feat_type,
            output = "cellMetaObj",
            copy_obj = TRUE,
            set_defaults = TRUE
        )

        # perform subset
        # 1. subobject subsetting does not drop ID col
        # 2. drop to data.table
        if (!is.null(idx)) {
            meta_cm <- meta_cm[idx]
        }
        test_dt <- meta_cm[][, y, with = FALSE]

        res <- .sankey_compare(data_dt = test_dt)
        links_dt <- res$links

        # create nodes table
        nodes <- data.table::data.table(name = res$nodes)

        .sankey_networkd3(
            Links = links_dt,
            Nodes = nodes,
            Source = "source",
            Target = "target",
            Value = "value",
            NodeID = "name",
            focus_names = focus_names,
            unfocused_color = unfocused_color,
            ...
        )
    }
)


#' @rdname sankeyPlot
#' @export
setMethod(
    "sankeyPlot",
    signature(x = "data.frame", y = "missing"),
    function(x, focus_names = NULL, unfocused_color = FALSE, ...) {
        GiottoUtils::package_check("networkD3")

        x <- data.table::as.data.table(x)
        res <- .sankey_compare(data_dt = x)
        links_dt <- res$links

        # create nodes table
        nodes <- data.table::data.table(name = res$nodes)

        .sankey_networkd3(
            Links = links_dt,
            Nodes = nodes,
            Source = "source",
            Target = "target",
            Value = "value",
            NodeID = "name",
            focus_names = focus_names,
            unfocused_color = unfocused_color,
            ...
        )
    }
)

#' @rdname sankeyPlot
#' @export
setMethod(
    "sankeyPlot",
    signature(x = "list", y = "missing"),
    function(x, focus_names = NULL, unfocused_color = FALSE, ...) {
        checkmate::assert_list(x, types = "data.frame")
        if (length(x) == 0L) stop("input is empty list")

        # DT vars
        target <- NULL

        # iterate through sankey relations in the list
        node_idx_start <- 0
        links_dt <- data.table::data.table()
        nodes <- c()

        for (dt_i in seq_along(x)) {
            rel_data <- .sankey_compare(
                data_dt = data.table::as.data.table(x[[dt_i]]),
                idx_start = node_idx_start
            )

            # append data
            links_dt <- rbind(links_dt, rel_data$links)
            nodes <- c(nodes, rel_data$nodes)

            # update start index
            node_idx_start <- links_dt[, max(source, target)] + 1
        }

        # create nodes table
        nodes_dt <- data.table::data.table(name = nodes)

        .sankey_networkd3(
            Links = links_dt,
            Nodes = nodes_dt,
            Source = "source",
            Target = "target",
            Value = "value",
            NodeID = "name",
            focus_names = focus_names,
            unfocused_color = unfocused_color,
            ...
        )
    }
)


#' @rdname sankeyPlot
#' @export
setMethod(
    "sankeyPlot",
    signature(
        x = "giottoPolygon",
        y = "giottoPolygon"
    ),
    function(x, y, focus_names = NULL, unfocused_color = FALSE, ...) {
        # take the poly_ID cols only from each gpoly
        # then perform intersect
        # finally, pass to sankeyPlot
        terra::intersect(x[, 1][], y[, 1][])[, seq_len(2)] %>%
            terra::values() %>%
            data.table::setDT() %>%
            data.table::setnames(new = c("a_ID", "b_ID")) %>%
            data.table::setkeyv(c("a_ID", "b_ID")) %>%
            sankeyPlot(
                focus_names = focus_names,
                unfocused_color = unfocused_color,
                ...
            )
    }
)



#' @name .sankey_networkd3
#' @title Create networkd3 sankey
#' @description Wrapper for networkd3's sankeyNetwork function. Adds some
#' additional params for controlling the plot.
#' @returns networkd3 sankey
#' @keywords internal
.sankey_networkd3 <- function(Links,
    Nodes,
    Source = "source",
    Target = "target",
    Value = "value",
    NodeID = "name",
    nodePadding = 1,
    sinksRight = FALSE,
    focus_names = NULL,
    unfocused_replacer = "",
    unfocused_color = FALSE,
    ...) {
    # NSE vars
    color <- NULL

    args_list <- list()

    if (!is.null(focus_names)) {
        Nodes[!get("name") %in% focus_names, "name" := unfocused_replacer]

        if (isTRUE(unfocused_color)) {
            Nodes[, color := as.character(seq(.N))]
            args_list$NodeGroup <- "color"
        }
    }

    args_list <- c(
        args_list,
        list(
            Links = Links,
            Nodes = Nodes,
            Source = Source,
            Target = Target,
            Value = Value,
            NodeID = NodeID,
            nodePadding = nodePadding,
            sinksRight = sinksRight
        ),
        list(...)
    )

    do.call(networkD3::sankeyNetwork, args = args_list)
}
