

# wrapper for ggplot2 with some adapters for Giotto settings
# ggplot2-native arg inputs are preferred
#
.gg_theme <- function(
        legend_text = 8,
        axis_title = 8,
        axis_text = 8,
        axis_text_y_angle = 90,
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
    a$axis.text.y <- a$axis.text.y %null%
        element_text(angle = axis_text_y_angle, hjust = 0.5)
    a$legend.title <- a$legend.title %null% element_blank()
    a$panel.grid <- a$panel.grid %null% element_blank()

    do.call(ggplot2::theme, args = a)
}


#' @name theme_dark
#' @title Dark plotting theme
#' @description
#' A default dark theme. It can be applied through the `theme_param`
#' @export
theme_dark <- theme(
    plot.background = element_rect(fill = "black"),
    panel.background = element_rect(fill = "black"),
    panel.grid.major = element_blank(),
    panel.grid.minor = element_blank(),
    text = element_text(color = "white"),
    axis.text = element_text(color = "white"),
    title = element_text(color = "white"),
    legend.background = element_rect(fill = "black"),
    legend.text = element_text(color = "white"),
    legend.title = element_text(color = "white")
)


