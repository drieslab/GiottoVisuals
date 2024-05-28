

# wrapper for ggplot2 with some adapters for Giotto settings
# ggplot2-native arg inputs are preferred
#
.gg_theme <- function(
        legend_text = 8,
        axis_title = 8,
        axis_text = 8,
        background_color = "white",
        ...
) {
    a <- list(...)

    # giotto masked args
    a$legend.text <- a$legend.text %null% element_text(size = legend_text)
    a$axis.title <- a$axis.title %null% element_text(size = axis_title)
    a$axis.text <- a$axis.text %null% element_text(size = axis_text)
    a$panel.background <- a$panel.background %null%
        element_rect(fill = background_color)

    # defaults
    a$plot.title <- a$plot.title %null% element_text(hjust = 0.5)
    a$axis.text.y <- a$axis.text.y %null% element_text(angle = 90, hjust = 0.5)
    a$legend.title <- a$legend.title %null% element_blank()
    a$panel.grid <- a$panel.grid %null% element_blank()

    do.call(ggplot2::theme, args = a)
}





