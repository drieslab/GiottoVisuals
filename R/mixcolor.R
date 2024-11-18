# multi color support


#' @name mixHSV
#' @title Colormixing in HSV space
#' @description
#' Vectorized approximation of additive-type color mixing using the HSV
#' colorspace.
#' Intended for helping in plotting more than one variable at the same time and
#' showing how they overlap.\cr
#' Since the mixing is performed using HSV, this function interpolates hue
#' mixtures, however due to the orthogonal nature of HSV, it does not imitate
#' the ability to generate white from red, green, and blue which the RGB
#' colorspace would be better at. However, this limitation is fine for this
#' use case which prioritizes clearly understandable mixtures of 2 or more
#' colors. Additionally, the orthogonal nature of saturation and value to hue
#' allows either of them to be treated as the absence of signal or alpha when
#' mixing to match with plotting backgrounds.
#' Treating either white or black as the base color makes it so that either
#' saturation or black, respectively, are treated as alpha, applying a weighting
#' to `c1` or `c2` values during mixing.
#' @param c1,c2 Colors 1 and 2. Accepts vector of hex color codes or an hsv
#' matrix
#' @param base_color either "white" (default) or "black". Which color to treat
#' as the absence of signal in `c1` and `c2`
#' @param output either "hex" or "hsv". "hex" produces a vector of hex codes
#' for color mixtures. "hsv" returns the hsv matrix.
#' @returns a vector of hex codes or an hsv matrix
#' @examples
#' # with black background
#' a <- GiottoVisuals::simple_palette_factory(c("green", "black"))(255)
#' b <- GiottoVisuals::simple_palette_factory(c("red", "black", "blue"))(255)
#' x <- mixHSV(a, b, base_color = "black")
#'
#' op <- par(no.readonly = TRUE)
#' par(bg = "black")
#'
#' # plot input color vectors
#' plot(seq(255),
#'     y = rep(2, 255), col = a, pch = 15, ylim = c(0, 3),
#'     bg = "black"
#' )
#' points(seq(255), y = rep(1.5, 255), col = b, pch = 15)
#' # plot mixture
#' points(seq(255), y = rep(1, 255), col = x, pch = 15)
#'
#' par(op)
#'
#' # with white background
#' a <- GiottoVisuals::simple_palette_factory(c("green", "white"))(255)
#' b <- GiottoVisuals::simple_palette_factory(c("red", "white", "blue"))(255)
#' x <- mixHSV(a, b, base_color = "white")
#'
#' plot(seq(255),
#'     y = rep(2, 255), col = a, pch = 15, ylim = c(0, 3),
#'     bg = "black"
#' )
#' points(seq(255), y = rep(1.5, 255), col = b, pch = 15)
#' points(seq(255), y = rep(1, 255), col = x, pch = 15)
#' @family colormixing functions
NULL

#' @name mixRGB
#' @title Colormixing in RGB space
#' @description
#' Vectorized additive mixing of colors in RGB space.
#' @param c1,c2 Colors 1 and 2. Accepts vector of hex color codes or an
#' rgb matrix
#' @param output either "hex" or "rgb". "hex" produces a vector of hex codes
#' for color mixtures. "rgb" returns the rgb matrix.
#' @family colormixing functions
#' @returns a vector of hex codes or an rgb matrix
#' @examples
#' # with black background
#' a <- GiottoVisuals::simple_palette_factory(c("green", "black"))(255)
#' b <- GiottoVisuals::simple_palette_factory(c("red", "black", "blue"))(255)
#' x <- mixRGB(a, b)
#'
#' op <- par(no.readonly = TRUE)
#' par(bg = "black")
#'
#' # plot input color vectors
#' plot(seq(255),
#'     y = rep(2, 255), col = a, pch = 15, ylim = c(0, 3),
#'     bg = "black"
#' )
#' points(seq(255), y = rep(1.5, 255), col = b, pch = 15)
#' # plot mixture
#' points(seq(255), y = rep(1, 255), col = x, pch = 15)
#'
#' par(op)
NULL


# in HSV, hue can be thought of as a circular set of values from 0 to 1.
# This function calculates the smaller angle drawn out between the two
# input hues and some other values needed for hue mixture calculation.
# Values are returned as a list the starting angle and the angle between
# hues 1 and 2.
.calc_h_angle <- function(h1, h2) {
    hdiff <- abs(h1 - h2)
    angle <- c()
    h1_start <- c()

    # logical vectors
    is_inner_angle <- hdiff <= 0.5
    h1_smaller <- (h1 - h2) < 0

    # output vectors
    h1_start[is_inner_angle & h1_smaller] <- TRUE
    h1_start[is_inner_angle & !h1_smaller] <- FALSE
    h1_start[!is_inner_angle & h1_smaller] <- FALSE
    h1_start[!is_inner_angle & !h1_smaller] <- TRUE

    angle[is_inner_angle] <- hdiff[is_inner_angle]
    angle[!is_inner_angle] <- 1 - hdiff[!is_inner_angle]

    res <- list(
        h1_start = h1_start,
        angle = angle
    )

    return(res)
}


# mod is a value that defines weighting between values from colors 1 and 2
# mod should be between 0 (1 only) and 1 (2 only), with 0.5 meaning equal
# contributions
# modulate based on saturation (s1, s2) for white
# modulate based on value (v1, v2) for black

# Perform the interpolation of hue values. The mixture is modulated by the
# mod param which is a value between 0 and 1 that informs the weighting to
# apply to h1 (0) vs h2 (1) when mixing.
.interp_h <- function(h1, h2, mod = 0.5) {
    h_angle <- .calc_h_angle(h1, h2)

    a_start <- c()
    a_start[h_angle$h1_start] <- h1[h_angle$h1_start]
    a_start[!h_angle$h1_start] <- h2[!h_angle$h1_start]

    mod[!h_angle$h1_start] <- 1 - mod[!h_angle$h1_start]

    h_angle_mod <- (h_angle$angle * mod) + a_start
    h_angle_final <- h_angle_mod %% 1

    return(h_angle_final)
}
# interpolation of saturation values
.interp_s <- function(s1, s2, mod = 0.5, base_color = "white") {
    if (base_color == "white") {
        # lock to max of the two when white is treated as the intensity
        s <- pmax(s1, s2)
    } else {
        s <- s1 * (1 - mod) + s2 * (mod)
    }
    return(s)
}
# interpolation of values
.interp_v <- function(v1, v2, mod = 0.5, base_color = "white") {
    if (base_color == "white") {
        v <- v1 * (1 - mod) + v2 * (mod)
    } else {
        v <- pmax(v1, v2)
    }
    return(v)
}

# vectorized hex 2 rgb matrix
hex2rgb <- function(x) {
    vapply(x, grDevices::col2rgb, USE.NAMES = FALSE, FUN.VALUE = numeric(3))
}

hex2hsv <- function(x) {
    grDevices::rgb2hsv(hex2rgb(x))
}

#' @rdname mixHSV
#' @export
mixHSV <- function(
        c1, c2, base_color = c("white", "black"),
        output = c("hex", "hsv")) {
    base_color <- match.arg(base_color, choices = c("white", "black"))
    output <- match.arg(output, c("hex", "hsv"))

    if (is.character(c1)) c1 <- hex2hsv(c1)
    if (is.character(c2)) c2 <- hex2hsv(c2)

    # matrix is expected
    if (!is.matrix(c1) || !is.matrix(c2)) {
        .gstop("c1 and c2 are expected to be 3 x n hsv matrices")
    }

    mod_vec <- switch(base_color,
        "white" = c2[2, ] / (c1[2, ] + c2[2, ]),
        "black" = c2[3, ] / (c1[3, ] + c2[3, ]),
    )

    # div by 0 happens for situations where color1 and color2 have a 0 value for
    # s or v. Simply assign 0.5 for these situations
    mod_vec[is.nan(mod_vec)] <- 0.5

    i_h <- .interp_h(c1[1, ], c2[1, ], mod = mod_vec)
    i_s <- .interp_s(c1[2, ], c2[2, ], mod = mod_vec, base_color = base_color)
    i_v <- .interp_v(c1[3, ], c2[3, ], mod = mod_vec, base_color = base_color)

    switch(output,
        "hex" = return(grDevices::hsv(i_h, i_s, i_v)),
        "hsv" = return(rbind(i_h, i_s, i_v))
    )
}



#' @rdname mixRGB
#' @export
mixRGB <- function(c1, c2, output = c("hex", "rgb")) {
    output <- match.arg(output, c("hex", "rgb"))

    if (is.character(c1)) c1 <- hex2rgb(c1)
    if (is.character(c2)) c2 <- hex2rgb(c2)

    # matrix is expected
    if (!is.matrix(c1) || !is.matrix(c2)) {
        .gstop("c1 and c2 are expected to be 3 x n rgb matrices")
    }

    rgbm <- c1 + c2
    rgbm_adj <- rgbm / max(rgbm)

    grDevices::rgb(t(rgbm_adj))
}
