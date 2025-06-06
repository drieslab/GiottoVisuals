# Use this function internal to this package
# .n should be increased when called from a nested location if capturing the
# original call is desired.
# .n should be increased to 2L when within a generic method
.gstop <- function(
        ...,
        sep = " ",
        strWidth = 100,
        errWidth = FALSE,
        .prefix = " ",
        .initial = "",
        .n = 1L,
        .call = TRUE) {
    GiottoUtils::gstop(
        ...,
        sep = sep,
        strWidth = strWidth,
        errWidth = errWidth,
        .module = "GiottoVisuals",
        .prefix = .prefix,
        .initial = .initial,
        .n = .n + 1L,
        .call = .call
    )
}
