# GiottoVisuals

GiottoVisuals contains the main plotting functions of Giotto Suite

## Installation

You can install GiottoVisuals like:

``` r
if (!requireNamespace("pak", quietly = TRUE)) install.packages("pak")
pak::pak("drieslab/GiottoVisuals")
```

## Script Organization by Prefixes:

`aux_` - auxilliary and meta functionality  
- `aux_output.R` - plot output handling  
- `aux_save.R` - plot saving  
- `aux_defaults.R` - set plotting defaults  
- `aux_visuals.R` - general auxilliary plotting functions

`plot_` - general plotting functions organized by type of plot  
- `plot_scatter.R` - scatter plots  
- `plot_violin.R` - violin plots  
- `plot_heatmap.R` - heatmaps  
- `plot_dendrogram.R` - dendrograms

`vis_` - specific plotting functions organized by topic - `vis_hvf.R` -
highly variable features plots  
- `vis_pc.R` - principle components plots  
- `vis_spatial.R` - - `vis_spatial_in_situ.R` -

`gg_` - ggplot2 related  
- `gg_info_layers.R` - modular internals for plotting the different
layers of information  
- \`\`

Other:  
- `color_palettes.R` - color palettes and factory functions

- `vis_spatialDE.R` -

Package:  
- `package_imports.R` - all imports  
- `globals.R` - global variables  
- `dd.R` - dummy documentation for inheriting  
- `zzz.R` - onloads
