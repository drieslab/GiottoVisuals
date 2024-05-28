#' @title FSV_show
#' @name FSV_show
#' @description Visualize spatial variable genes calculated by spatial_DE
#' @param results results calculated by spatial_DE
#' @param ms_results ms_results calculated by spatial_DE
#' @param size indicate different levels of qval
#' @param color indicate different SV features
#' @param sig_alpha transparency of significant genes
#' @param unsig_alpha transparency of non-significant genes
#' @details Description of parameters.
#' @keywords internal
#' @returns ggplot object
#' 
#' @export
FSV_show <- function(
        results,
        ms_results = NULL,
        size = c(4, 2, 1),
        color = c("blue", "green", "red"),
        sig_alpha = 0.5,
        unsig_alpha = 0.5) {
    results$FSV95conf <- 2 * sqrt(results$s2_FSV)
    results$intervals <- cut(results$FSV95conf, c(0, 1e-1, 1e0, Inf), 
                            label = FALSE)
    results$log_pval <- log10(results$pval)

    if (is.null(ms_results)) {
        results$model_bic <- results$model
    } else {
        results <- merge(results, ms_results[, c("g", "model")],
            by.x = "g", by.y = "g", all.x = TRUE,
            suffixes = (c(" ", "_bic"))
        )
    }

    results$model_bic <- factor(results$model_bic)
    results$intervals <- factor(results$intervals)


    pl <- ggplot2::ggplot()
    pl <- pl + ggplot2::theme_bw()
    pl <- pl + ggplot2::geom_point(
        data = results[results$qval < 0.05, ],
        ggplot2::aes_string(
            x = "FSV", y = "log_pval",
            fill = "model_bic", size = "intervals"
        ),
        show.legend = TRUE, shape = 21, alpha = sig_alpha,
        # size = size[results_cp_s$inftervals],
        stroke = 0.1, color = "black"
    ) +
        ggplot2::geom_point(
            data = results[results$qval > 0.05, ],
            ggplot2::aes_string(x = "FSV", y = "log_pval", size = "intervals"),
            show.legend = TRUE, shape = 21, alpha = unsig_alpha,
            fill = "black", # size = size[results_cp_ns$inftervals],
            stroke = 0.1, color = "black"
        ) +
        ggplot2::scale_size_manual(values = size, guide = FALSE) +
        ggplot2::scale_color_manual(values = color) +
        ggplot2::scale_fill_discrete(
            name = "Spatial Patterns",
            breaks = c("linear", "PER", "SE"),
            labels = c("linear", "periodical", "general")
        ) +
        ggplot2::geom_hline(
            yintercept = max(results[results$qval < 0.05, ]$log_pval),
            linetype = "dashed"
        ) +
        ggplot2::geom_text(
            ggplot2::aes(0.9, max(results[results$qval < 0.05, ]$log_pval),
                label = "FDR = 0.05", vjust = -1
            )
        ) +
        ggplot2::scale_y_reverse()

    print(pl)
}
