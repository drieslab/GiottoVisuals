% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/gg_info_layers.R
\name{addGiottoImageToSpatPlot}
\alias{addGiottoImageToSpatPlot}
\title{addGiottoImageToSpatPlot}
\usage{
addGiottoImageToSpatPlot(
  spatpl = NULL,
  gimage = NULL,
  layer = c("bg", "overlay"),
  alpha = NULL
)
}
\arguments{
\item{spatpl}{a spatial ggplot object}

\item{gimage}{a giotto image, see \code{\link{createGiottoImage}}}

\item{layer}{numeric layer on which to add the giotto image. OR takes 'bg' or
'overlay' as input to designate last (bottom/background) or first
(top/overlay)}

\item{alpha}{(optional) add giotto image to plot with transparency.
Numeric. From 0 (transparent) to 1 (fully visible)}
}
\value{
an updated spatial ggplot object
}
\description{
Add a giotto image to a spatial ggplot object post creation
}
\examples{
g <- GiottoData::loadGiottoMini("visium", verbose = FALSE)

my_giottoimage <- GiottoClass::createGiottoImage(g,
    mg_object = system.file("image.png", package = "GiottoVisuals"),
    name = "image"
)

my_spatplot <- spatPlot2D(g, return_plot = TRUE)

addGiottoImageToSpatPlot(spatpl = my_spatplot, gimage = my_giottoimage)

}
