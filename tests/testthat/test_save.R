
# showSaveParameters ####

test_that("No errors when running showSaveParameters", {
    expect_no_error(showSaveParameters())
})

# plot saving and formats ####

# dummy save directory
results_folder <- file.path(
    getwd(), "testout", format(Sys.Date(), "%y%m%d")
)

# load in dummy gobject
g <- GiottoData::loadGiottoMini("vis", verbose = FALSE)
instructions(g, "save_dir") <- results_folder

# create dummy plot
df <- data.frame(x = rnorm(5), y = rnorm(5), z = rnorm(5))
g_plot <- ggplot2::ggplot(df, ggplot2::aes(x,y)) + ggplot2::geom_point()
b_plot <- plot(df$x, df$y)
p_plot <- plotly::plot_ly(df, x = ~x, y = ~y, z = ~z)


test_that("gg save works - png", {
    all_plots_save_function(g, g_plot)
    img_id <- getOption("giotto.plot_count") - 1L
    checkmate::expect_file_exists(
        file.path(results_folder,
                  sprintf("%d-giotto_plot.%s", img_id, "png"))
    )
})

test_that("gg save works - tiff", {
    instructions(g, "plot_format") <- "tiff"
    all_plots_save_function(g, g_plot)
    img_id <- getOption("giotto.plot_count") - 1L
    checkmate::expect_file_exists(
        file.path(results_folder,
                  sprintf("%d-giotto_plot.%s", img_id, "tiff"))
    )
})

test_that("gg save works - pdf", {
    instructions(g, "plot_format") <- "pdf"
    all_plots_save_function(g, g_plot)
    img_id <- getOption("giotto.plot_count") - 1L
    checkmate::expect_file_exists(
        file.path(results_folder,
                  sprintf("%d-giotto_plot.%s", img_id, "pdf"))
    )
})

test_that("gg save works - jpg", {
    instructions(g, "plot_format") <- "jpg"
    all_plots_save_function(g, g_plot)
    img_id <- getOption("giotto.plot_count") - 1L
    checkmate::expect_file_exists(
        file.path(results_folder,
                  sprintf("%d-giotto_plot.%s", img_id, "jpg"))
    )
})

test_that("gg save works - svg", {
    instructions(g, "plot_format") <- "svg"
    all_plots_save_function(g, g_plot)
    img_id <- getOption("giotto.plot_count") - 1L
    checkmate::expect_file_exists(
        file.path(results_folder,
                  sprintf("%d-giotto_plot.%s", img_id, "svg"))
    )
})


test_that("plotly save works - html", {
    # should find html default by itself
    all_plots_save_function(g, p_plot)
    img_id <- getOption("giotto.plot_count") - 1L
    checkmate::expect_file_exists(
        file.path(results_folder,
                  sprintf("%d-giotto_plot.%s", img_id, "html"))
    )
})


# plot saving and dpi ####
test_that("gg save works - dpi 10", {
    instructions(g, "dpi") <- 10
    all_plots_save_function(g, g_plot)
    img_id <- getOption("giotto.plot_count") - 1L
    checkmate::expect_file_exists(
        file.path(results_folder,
                  sprintf("%d-giotto_plot.%s", img_id, "png"))
    )
})

test_that("gg save works - dpi 300 override", {
    instructions(g, "dpi") <- 10
    all_plots_save_function(g, g_plot, dpi = 300)
    img_id <- getOption("giotto.plot_count") - 1L
    checkmate::expect_file_exists(
        file.path(results_folder,
                  sprintf("%d-giotto_plot.%s", img_id, "png"))
    )
})



