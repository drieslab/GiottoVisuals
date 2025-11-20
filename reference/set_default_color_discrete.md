# Set a discrete coloring scheme

Provides a palette function that will generate 'n' hexadecimal color
codes for discrete colors. Sets a default coloring palette if `NULL` is
passed to `colors` param.  
  

Supports colors setting at three levels:

- **global options** (general session setting with blanket color palette
  type effects)

  - options('giotto.color_d_pal) - palette to use

  - options('giotto.color_d_rev) - whether colors should be reversed

  - options('giotto.color_d_strategy) - strategy to use when making
    colors continuous. See
    [`get_continuous_colors()`](https://drieslab.github.io/GiottoVisuals/reference/get_continuous_colors.md)

- **giotto instructions** (gobject specific and effects specific types
  of plots)

  - run
    [`showColorInstructions()`](https://drieslab.github.io/GiottoVisuals/reference/showColorInstructions.md)
    for details on options/params to set in the `giottoInstructions`
    object

- **function specific** (directly pass desired colors to plotting
  function)  
    

If a character vector of length 1 input is provided then it will be
assumed that a known color palette is being requested from
[`pal_names()`](https://drieslab.github.io/GiottoVisuals/reference/pal_names.md).  
If a longer character input is provided then they will be expected to be
a vector of colors to use. These values will be passed to
[simple_palette_factory](https://drieslab.github.io/GiottoVisuals/reference/simple_palette_factory.md)
which will generate a palette function that interpolates between the
colors provided by default and has a `n` param for number of requested
colors.  
Custom function inputs to `colors` is also supported but these custom
functions should have a `n` param for number of requested colors.

## Usage

``` r
set_default_color_discrete(
  colors = NULL,
  ...,
  instr_pal,
  instr_rev,
  instr_strategy
)

set_default_color_discrete_cell(colors = NULL, instrs, ...)

set_default_color_discrete_poly(colors = NULL, instrs, ...)

set_default_color_discrete_feat(colors = NULL, instrs, ...)

set_default_color_discrete_heatmap_clus(colors = NULL, instrs, ...)
```

## Arguments

- colors:

  accepts color inputs

- ...:

  additional params to pass

- instr_pal, instr_rev, instr_strategy:

  used by upstream function to pass specific `giottoInstructions` params

- instrs:

  `giottoInstructions` object (output of `instructions(gobject)`)

## Value

a palette function

vector of color ids

## Functions

- `set_default_color_discrete()`: Framework function. Direct use should
  be minimal. Wrap this for specific things (plots or types of features)
  that need defaults setting.

## Examples

``` r
set_default_color_discrete(
    colors = "#eb4034",
    instr_rev = NULL, instr_strategy = NULL
)
#> function (n) 
#> {
#>     col <- getColors(pal = pal, n = n, rev = rev, strategy = "cutoff")
#>     get_continuous_colors(col = col, n = n, strategy = strategy)
#> }
#> <bytecode: 0x557a544e91d0>
#> <environment: 0x557a39536720>
```
