# TODO rev for discrete
#' @title getColors
#' @name getColors
#' @description
#' Generate hexadecimal color vectors for use in plotting based on popular color
#' palettes and packages. Default is 100 viridis colors.\cr
#' \[**continuous palettes**\] n colors are pulled from the desired palette\cr
#' \[**discrete palettes**\] pulls n colors from discrete palette. If the
#' number of colors requested is within the number of discrete colors,
#' the values will be pulled without modification starting from the first
#' value. If more are requested than exist then the palette will be made
#' continuous\cr
#' @param n numeric. number of colors wanted
#' @param pal character. palette to use. Partial matching with ignored
#' capitalization
#' @param rev whether to reverse the palette
#' @param src specific palette package to check
#' @param strategy one of 'interpolate', 'recycle', or 'cutoff', what
#' strategy to use when more colors are requested than exist for the palette
#' @returns vector of color ids
#' @examples
#' f <- system.file("ex/elev.tif", package = "terra")
#' r <- terra::rast(f)
#' terra::plot(r, col = getColors(pal = "Spectral", n = 100))
#' @export
getColors <- function(
        pal = "viridis",
        n = 100,
        rev = FALSE,
        src = NULL,
        strategy = c("interpolate")) {
    checkmate::assert_numeric(n, len = 1L)
    checkmate::assert_character(pal, len = 1L)
    checkmate::assert_logical(rev, len = 1L)
    if (!is.null(src)) checkmate::assert_character(src, len = 1L)
    if (n < 1) stop("colors wanted must be at least 1")
    n <- as.integer(n) # force integer

    if (pal == "distinct") {
        return(getDistinctColors(n = n))
    }

    # check palettes
    pkg_to_use <- NULL
    if (!is.null(src)) pkg_to_use <- g_match_arg(src, names(pal_names))
    if (!is.null(pkg_to_use)) {
        pal <- g_match_arg(pal, pal_names[[pkg_to_use]])
    } else {
        try_val <- try(g_match_arg(pal, pal_names[["base"]]),
            silent = TRUE
        )
        pkg_to_use <- "base"
        if (inherits(try_val, "try-error")) {
            try_val <- try(g_match_arg(pal, pal_names[["hcl"]]),
                silent = TRUE
            )
            pkg_to_use <- "hcl"
        }
        if (inherits(try_val, "try-error")) {
            try_val <- try(g_match_arg(pal, pal_names[["RColorBrewer"]]),
                silent = TRUE
            )
            pkg_to_use <- "RColorBrewer"
        }
        if (inherits(try_val, "try-error")) {
            try_val <- try(g_match_arg(pal, pal_names[["viridis"]]),
                silent = TRUE
            )
            pkg_to_use <- "viridis"
        }
        if (inherits(try_val, "try-error")) {
            try_val <- try(g_match_arg(pal, pal_names[["rcartocolor"]]),
                silent = TRUE
            )
            pkg_to_use <- "rcartocolor"
        }
        if (inherits(try_val, "try-error")) {
            try_val <- try(g_match_arg(pal, pal_names[["wesanderson"]]),
                silent = TRUE
            )
            pkg_to_use <- "wesanderson"
        }
        if (inherits(try_val, "try-error")) {
            try_val <- try(g_match_arg(pal, pal_names[["ggsci"]]),
                silent = TRUE
            )
            pkg_to_use <- "ggsci"
        }
        if (inherits(try_val, "try-error")) {
            try_val <- try(g_match_arg(pal, pal_names[["nord"]]), silent = TRUE)
            pkg_to_use <- "nord"
        }
        if (inherits(try_val, "try-error")) {
            try_val <- try(g_match_arg(pal, pal_names[["NineteenEightyR"]]),
                silent = TRUE
            )
            pkg_to_use <- "NineteenEightyR"
        }
        if (inherits(try_val, "try-error")) {
            try_val <- try(g_match_arg(pal, pal_names[["palettetown"]]),
                silent = TRUE
            )
            pkg_to_use <- "palettetown"
        }
        if (inherits(try_val, "try-error")) {
            try_val <- try(g_match_arg(pal, pal_names[["palr"]]), silent = TRUE)
            pkg_to_use <- "palr"
        }
        if (inherits(try_val, "try-error")) {
            .gstop(
                pal, "not discovered in supported palette packages:",
                names(pal_names)
            )
        }
        pal <- try_val
    }

    out <- switch(pkg_to_use,
        "hcl" = grDevices::hcl.colors(n = n, palette = pal),
        "base" = .get_base_colors(n = n, pal = pal),
        "RColorBrewer" = .get_rcolorbrewer_colors(
            n = n, pal = pal,
            strategy = strategy
        ),
        "viridis" = .get_viridis_colors(n = n, pal = pal),
        "wesanderson" = .get_wes_anderson_colors(n = n, pal = pal),
        "ggsci" = .get_ggsci_colors(n = n, pal = pal, strategy = strategy),
        "nord" = .get_nord_colors(n = n, pal = pal),
        "palettetown" = .get_palettetown_colors(
            n = n, pal = pal,
            strategy = strategy
        ),
        "palr" = .get_palr_colors(n = n, pal = pal),
        "NineteenEightyR" = .get_ninteeneightyr_colors(
            n = n, pal = pal,
            strategy = strategy
        ),
        "rcartocolor" = .get_rcarto_colors(
            n = n, pal = pal,
            strategy = strategy
        )
    )

    if (rev) {
        return(rev(out))
    } else {
        return(out)
    }
}







# get palettes ####
.get_rcolorbrewer_colors <- function(n, pal, strategy) {
    # DT vars
    rn <- maxcolors <- NULL

    # setDT() does not work well for this
    col_DT <- data.table::as.data.table(RColorBrewer::brewer.pal.info,
        keep.rownames = TRUE
    )
    max_col <- col_DT[rn == pal, maxcolors]
    out <- get_continuous_colors(
        col = RColorBrewer::brewer.pal(n = max_col, name = pal),
        n = n,
        strategy = strategy
    )
    return(out)
}

.get_ggsci_colors <- function(n, pal, strategy) {
    package_check("ggsci")

    pal_fullname <- paste0("ggsci::pal_", pal, "()")
    
    # get first 100 colors
    pal_cols <- eval(parse(text = pal_fullname))(100)
    
    get_continuous_colors(
        col = pal_cols[!is.na(pal_cols)],
        n = n,
        strategy = strategy
    )
}

.get_viridis_colors <- function(n, pal = "viridis") {
    # viridisLite should always be installed if viridis is there
    package_check("viridisLite")
    return(
        switch(pal,
            "viridis" = viridisLite::viridis(n = n),
            "magma" = viridisLite::magma(n = n),
            "cividis" = viridisLite::cividis(n = n),
            "inferno" = viridisLite::inferno(n = n),
            "mako" = viridisLite::mako(n = n),
            "plasma" = viridisLite::plasma(n = n),
            "rocket" = viridisLite::rocket(n = n),
            "turbo" = viridisLite::turbo(n = n)
        )
    )
}

.get_base_colors <- function(n, pal = "rainbow") {
    return(
        switch(pal,
            "rainbow" = grDevices::rainbow(n),
            "heat" = grDevices::heat.colors(n),
            "terrain.colors" = grDevices::terrain.colors(n),
            "topo.colors" = grDevices::topo.colors(n),
            "cm.colors" = grDevices::cm.colors(n),
            "grey" = grDevices::grey.colors(
                n = n, start = 0, end = 1,
                gamma = 1
            ),
            "gray" = grDevices::gray.colors(
                n = n, start = 0, end = 1,
                gamma = 1
            )
        )
    )
}

.get_wes_anderson_colors <- function(n, pal) {
    package_check("wesanderson")
    out <- wesanderson::wes_palette(name = pal, n = n, type = "continuous")
    return(out)
}

.get_nord_colors <- function(n, pal) {
    package_check("nord")
    return(nord::nord(palette = pal, n = n))
}

.get_palettetown_colors <- function(n, pal, strategy) {
    package_check("palettetown")
    colors <- get_continuous_colors(
        palettetown::ichooseyou(pokemon = pal),
        n = n,
        strategy = strategy
    )
}

.get_palr_colors <- function(n, pal) {
    package_check("palr")
    return(
        switch(pal,
            "bathy_deep_pal" = palr::bathy_deep_pal(n),
            "bathyDeepPal" = palr::bathy_deep_pal(n),
            "chl_pal" = palr::chl_pal(n),
            "chlPal" = palr::chl_pal(n),
            "ice_pal" = palr::ice_pal(n),
            "icePal" = palr::ice_pal(n),
            "sst_pal" = palr::sst_pal(n),
            "sstPal" = palr::sst_pal(n)
        )
    )
}

.get_ninteeneightyr_colors <- function(n, pal, strategy) {
    package_check("NineteenEightyR",
        repository = "github",
        github_repo = "m-clark/NineteenEightyR"
    )

    pal_col <- switch(pal,
        "cobra" = NineteenEightyR::cobra(),
        "electronic_night" = NineteenEightyR::electronic_night(),
        "hotpink" = NineteenEightyR::hotpink(),
        "malibu" = NineteenEightyR::malibu(),
        "miami1" = NineteenEightyR::miami1(),
        "miami2" = NineteenEightyR::miami2(),
        "seventies_aint_done_yet" = NineteenEightyR::seventies_aint_done_yet(),
        "sonny" = NineteenEightyR::sonny(),
        "sunset1" = NineteenEightyR::sunset1(),
        "sunset2" = NineteenEightyR::sunset2(),
        "sunset3" = NineteenEightyR::sunset3(),
        "youngturqs" = NineteenEightyR::youngturqs()
    )

    return(get_continuous_colors(col = pal_col, n = n, strategy))
}

.get_rcarto_colors <- function(n, pal, strategy) {
    package_check("rcartocolor", repository = "CRAN")

    pal_col <- rcartocolor::carto_pal(n = n, name = pal)


    return(get_continuous_colors(
        col = pal_col,
        n = n,
        strategy = strategy
    ))
}




# helpers ####

#' @name get_continuous_colors
#' @title Generate a continuous set of colors
#' @description
#' Based on a vector of colors provided to `col`, make these colors continuous
#' (i.e. make it possible for an arbitrary `n` number of colors to be requested)
#' then return those `n` colors.\cr
#' `strategy` describes how to make these colors continuous:
#' - **'interpolate'** interpolates provided colors using
#' [grDevices::colorRampPalette()]
#' - **'recycle'** - recycles the input color vector across the `n` requested.
#' - **'cutoff'** - supply only a maximum of as many colors as exist within the
#' originally supplied vector.
#' @param col character vector. colors to make continuous
#' @param n integer. number of colors to get
#' @param strategy one of 'cutoff', 'recycle', or 'interpolate'.
#' strategy to use when more colors are requested than exist
#' @returns a vector of colors
#' @examples
#' get_continuous_colors(col = "#eb4034", n = 10, strategy = "interpolate")
#' 
#' @export
get_continuous_colors <- function(col, n, strategy) {
    strategy <- g_match_arg(strategy,
        choices = c("interpolate", "recycle", "cutoff")
    )

    if (n < length(col)) {
        return(col[seq_len(n)])
    }
    switch(strategy,
        "cutoff" = return(col),
        "recycle" = return(rep(col, length.out = n)),
        "interpolate" = return(grDevices::colorRampPalette(col)(n))
    )
}



#' @name simple_palette_factory
#' @title Generate a simple palette function
#' @seealso [set_default_color_discrete()]
#' @description
#' Simple palette function generator. Creates a function with param n that
#' dictates how many colors to return from the provided vector of hexadecimal
#' color values. Generated functions send warning if there are not enough colors
#' to use and it needs to recycle values.
#' @param col character vector. Hexadecimal color codes
#' @param rev whether to reverse order of vector
#' @param strategy policy when insufficient colors are available
#' @returns a function
#' @examples
#' simple_palette_factory(col = "#eb4034")
#' 
#' @export
simple_palette_factory <- function(col, rev = FALSE, strategy = "interpolate") {
    checkmate::assert_character(col)
    checkmate::assert_logical(rev)

    if (rev) col <- rev(col)

    function(n) {
        get_continuous_colors(col = col, n = n, strategy = strategy)
    }
}

#' @noRd
#' @param pal palette from getColors() to use
#' @param rev whether to reverse order of vector
#' @param strategy policy when insufficient colors are available
#' @param strategy strategy to use
#' @seealso [set_default_color_discrete()]
.get_palette_factory <- function(pal, rev = FALSE, strategy = "interpolate") {
    function(n) {
        col <- getColors(pal = pal, n = n, rev = rev, strategy = "cutoff")
        get_continuous_colors(col = col, n = n, strategy = strategy)
    }
}


# * palette names list ####

#' @title Color palette names
#' @name pal_names
#' @description
#' Known color palettes info provided as named list of character vectors.
#' List names correspond to the name of the palette package.
#' The character vectors list the palettes that are available within.
#' These palettes can be passed to the default color setting functions
#' @returns palette colors
#' @examples
#' pal_names
#' 
#' @export
pal_names <- list(
    hcl = grDevices::hcl.pals(),
    base = c(
        "rainbow", "heat", "terrain.colors", "topo.colors",
        "cm.colors", "grey", "gray"
    ),
    RColorBrewer = c(
        # Greys removed to ensure the it goes to base
        "BrBG", "PiYG", "PRGn", "PuOr", "RdBu", "RdGy", "RdYlBu",
        "RdYlGn", "Spectral", "Accent", "Dark2", "Paired", "Pastel1", "Pastel2",
        "Set1", "Set2", "Set3", "Blues", "BuGn", "BuPu", "GnBu",
        "Greens", "Oranges", "OrRd", "PuBu", "PuBuGn", "PuRd",
        "Purples", "RdPu", "Reds", "YlGn", "YlGnBu", "YlOrBr", "YlOrRd"
    ),
    viridis = c(
        "viridis", "magma", "cividis", "inferno", "mako", "plasma", "rocket",
        "turbo"
    ),
    wesanderson = c(
        "BottleRocket1", "BottleRocket2", "Rushmore1", "Rushmore",
        "Royal1", "Royal2", "Zissou1", "Darjeeling1",
        "Darjeeling2", "Chevalier1", "FantasticFox1", "Moonrise1",
        "Moonrise2", "Moonrise3", "Cavalcanti1", "GrandBudapest1",
        "GrandBudapest2", "IsleofDogs1", "IsleofDogs2"
    ),
    ggsci = c(
        "aaas", "cosmic", "d3", "flatui", "frontiers", "futurama", "gsea",
        "igv", "jama",
        "jco", "lancet", "locuszoom", "material", "nejm", "npg", "rickandmorty",
        "simpsons", "startrek", "tron", "uchicago", "ucscgb"
    ),
    nord = c(
        "polarnight", "snowstorm", "frost", "aurora",
        "lumina", "mountain_forms", "silver_mine", "lake_superior",
        "victory_bonds", "halifax_harbor", "moose_pond", "algoma_forest",
        "rocky_mountain", "red_mountain", "baie_mouton", "afternoon_prarie"
    ),
    palettetown = c(
        "charizard", "pidgeotto", "tangela", "porygon", "quilava", "sunkern",
        "yanma", "surskit", "plusle", "carvanha"
    ),
    palr = c(
        "bathy_deep_pal", "bathyDeepPal",
        "chl_pal", "chlPal",
        "ice_pal", "icePal",
        "sst_pal", "sstPal"
    ),
    NineteenEightyR = c(
        "cobra", "electronic_night", "hotpink", "malibu", "miami1", "miami2",
        "seventies_aint_done_yet", "sonny", "sunset1", "sunset2", "sunset3",
        "youngturqs"
    ),
    rcartocolor = c(
        "ag_GrnYl",   "ag_Sunset",  "ArmyRose",   "Earth",      "Fall",
        "Geyser",     "TealRose",   "Temps",      "Tropic",     "Antique",
        "Bold",       "Pastel",     "Prism",      "Safe",       "Vivid",
        "BluGrn",     "BluYl",      "BrwnYl",     "Burg",       "BurgYl",
        "DarkMint",   "Emrld",      "Magenta",    "Mint",       "OrYel",
        "Peach",      "PinkYl",     "Purp",       "PurpOr",     "RedOr",
        "Sunset",     "SunsetDark", "Teal",       "TealGrn"
    )
)
