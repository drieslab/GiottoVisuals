# internals
setOldClass("gg")
setOldClass("ggplot2::ggplot")
setGeneric(
    "gg_annotation_raster",
    function(ggobj, gimage, ...) standardGeneric("gg_annotation_raster")
)
setClassUnion("ggUnionClass", c("ggplot2::ggplot", "gg"))


