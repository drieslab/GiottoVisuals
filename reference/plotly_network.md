# plotly_network

provide network segment to draw in 3D plot_ly()

## Usage

``` r
plotly_network(
  network,
  x = "sdimx_begin",
  y = "sdimy_begin",
  z = "sdimz_begin",
  x_end = "sdimx_end",
  y_end = "sdimy_end",
  z_end = "sdimz_end"
)
```

## Arguments

- network:

  network object

- x:

  default to "sdimx_begin"

- y:

  default to "sdimy_begin"

- z:

  default to "sdimz_begin"

- x_end:

  default to "sdimx_end"

- y_end:

  default to "sdimy_end"

- z_end:

  default to "sdimz_end"

## Value

edges in network as data.table
