# Run on library loading


.onAttach <- function(libname, pkgname) {
    ## print version number ##

    check_ver <- getOption("giotto.check_version", TRUE)
    if (isTRUE(check_ver)) {
        GiottoUtils::check_github_suite_ver("GiottoVisuals")
        options("giotto.check_version" = FALSE)
    }

    ## set defaults ##
    ## ------------ ##

    # colors continuous
    init_option("giotto.color_cd_pal", c("blue", "white", "red"))
    init_option("giotto.color_cs_pal", "viridis")
    init_option("giotto.color_c_rev", FALSE)

    # colors discrete
    init_option("giotto.color_d_pal", "distinct")
    init_option("giotto.color_d_rev", FALSE)
    init_option("giotto.color_d_strategy", "interpolate")

    # image resampling
    init_option("giotto.plot_img_max_sample", 5e5)
    init_option("giotto.plot_img_max_crop", 1e8)
    init_option("giotto.plot_img_max_resample_scale", 100)

    # point rasterization
    init_option("giotto.plot_point_raster", 5e5)
}



