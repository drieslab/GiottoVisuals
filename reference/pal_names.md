# Color palette names

Known color palettes info provided as named list of character vectors.
List names correspond to the name of the palette package. The character
vectors list the palettes that are available within. These palettes can
be passed to the default color setting functions

## Usage

``` r
pal_names
```

## Format

An object of class `list` of length 11.

## Value

palette colors

## Examples

``` r
pal_names
#> $hcl
#>   [1] "Pastel 1"      "Dark 2"        "Dark 3"        "Set 2"        
#>   [5] "Set 3"         "Warm"          "Cold"          "Harmonic"     
#>   [9] "Dynamic"       "Grays"         "Light Grays"   "Blues 2"      
#>  [13] "Blues 3"       "Purples 2"     "Purples 3"     "Reds 2"       
#>  [17] "Reds 3"        "Greens 2"      "Greens 3"      "Oslo"         
#>  [21] "Purple-Blue"   "Red-Purple"    "Red-Blue"      "Purple-Orange"
#>  [25] "Purple-Yellow" "Blue-Yellow"   "Green-Yellow"  "Red-Yellow"   
#>  [29] "Heat"          "Heat 2"        "Terrain"       "Terrain 2"    
#>  [33] "Viridis"       "Plasma"        "Inferno"       "Rocket"       
#>  [37] "Mako"          "Dark Mint"     "Mint"          "BluGrn"       
#>  [41] "Teal"          "TealGrn"       "Emrld"         "BluYl"        
#>  [45] "ag_GrnYl"      "Peach"         "PinkYl"        "Burg"         
#>  [49] "BurgYl"        "RedOr"         "OrYel"         "Purp"         
#>  [53] "PurpOr"        "Sunset"        "Magenta"       "SunsetDark"   
#>  [57] "ag_Sunset"     "BrwnYl"        "YlOrRd"        "YlOrBr"       
#>  [61] "OrRd"          "Oranges"       "YlGn"          "YlGnBu"       
#>  [65] "Reds"          "RdPu"          "PuRd"          "Purples"      
#>  [69] "PuBuGn"        "PuBu"          "Greens"        "BuGn"         
#>  [73] "GnBu"          "BuPu"          "Blues"         "Lajolla"      
#>  [77] "Turku"         "Hawaii"        "Batlow"        "Blue-Red"     
#>  [81] "Blue-Red 2"    "Blue-Red 3"    "Red-Green"     "Purple-Green" 
#>  [85] "Purple-Brown"  "Green-Brown"   "Blue-Yellow 2" "Blue-Yellow 3"
#>  [89] "Green-Orange"  "Cyan-Magenta"  "Tropic"        "Broc"         
#>  [93] "Cork"          "Vik"           "Berlin"        "Lisbon"       
#>  [97] "Tofino"        "ArmyRose"      "Earth"         "Fall"         
#> [101] "Geyser"        "TealRose"      "Temps"         "PuOr"         
#> [105] "RdBu"          "RdGy"          "PiYG"          "PRGn"         
#> [109] "BrBG"          "RdYlBu"        "RdYlGn"        "Spectral"     
#> [113] "Zissou 1"      "Cividis"       "Roma"         
#> 
#> $base
#> [1] "rainbow"        "heat"           "terrain.colors" "topo.colors"   
#> [5] "cm.colors"      "grey"           "gray"          
#> 
#> $RColorBrewer
#>  [1] "BrBG"     "PiYG"     "PRGn"     "PuOr"     "RdBu"     "RdGy"    
#>  [7] "RdYlBu"   "RdYlGn"   "Spectral" "Accent"   "Dark2"    "Paired"  
#> [13] "Pastel1"  "Pastel2"  "Set1"     "Set2"     "Set3"     "Blues"   
#> [19] "BuGn"     "BuPu"     "GnBu"     "Greens"   "Oranges"  "OrRd"    
#> [25] "PuBu"     "PuBuGn"   "PuRd"     "Purples"  "RdPu"     "Reds"    
#> [31] "YlGn"     "YlGnBu"   "YlOrBr"   "YlOrRd"  
#> 
#> $viridis
#> [1] "viridis" "magma"   "cividis" "inferno" "mako"    "plasma"  "rocket" 
#> [8] "turbo"  
#> 
#> $wesanderson
#>  [1] "BottleRocket1"  "BottleRocket2"  "Rushmore1"      "Rushmore"      
#>  [5] "Royal1"         "Royal2"         "Zissou1"        "Darjeeling1"   
#>  [9] "Darjeeling2"    "Chevalier1"     "FantasticFox1"  "Moonrise1"     
#> [13] "Moonrise2"      "Moonrise3"      "Cavalcanti1"    "GrandBudapest1"
#> [17] "GrandBudapest2" "IsleofDogs1"    "IsleofDogs2"   
#> 
#> $ggsci
#>  [1] "aaas"         "cosmic"       "d3"           "flatui"       "frontiers"   
#>  [6] "futurama"     "gsea"         "igv"          "jama"         "jco"         
#> [11] "lancet"       "locuszoom"    "material"     "nejm"         "npg"         
#> [16] "rickandmorty" "simpsons"     "startrek"     "tron"         "uchicago"    
#> [21] "ucscgb"      
#> 
#> $nord
#>  [1] "polarnight"       "snowstorm"        "frost"            "aurora"          
#>  [5] "lumina"           "mountain_forms"   "silver_mine"      "lake_superior"   
#>  [9] "victory_bonds"    "halifax_harbor"   "moose_pond"       "algoma_forest"   
#> [13] "rocky_mountain"   "red_mountain"     "baie_mouton"      "afternoon_prarie"
#> 
#> $palettetown
#>  [1] "charizard" "pidgeotto" "tangela"   "porygon"   "quilava"   "sunkern"  
#>  [7] "yanma"     "surskit"   "plusle"    "carvanha" 
#> 
#> $palr
#> [1] "bathy_deep_pal" "bathyDeepPal"   "chl_pal"        "chlPal"        
#> [5] "ice_pal"        "icePal"         "sst_pal"        "sstPal"        
#> 
#> $NineteenEightyR
#>  [1] "cobra"                   "electronic_night"       
#>  [3] "hotpink"                 "malibu"                 
#>  [5] "miami1"                  "miami2"                 
#>  [7] "seventies_aint_done_yet" "sonny"                  
#>  [9] "sunset1"                 "sunset2"                
#> [11] "sunset3"                 "youngturqs"             
#> 
#> $rcartocolor
#>  [1] "ag_GrnYl"   "ag_Sunset"  "ArmyRose"   "Earth"      "Fall"      
#>  [6] "Geyser"     "TealRose"   "Temps"      "Tropic"     "Antique"   
#> [11] "Bold"       "Pastel"     "Prism"      "Safe"       "Vivid"     
#> [16] "BluGrn"     "BluYl"      "BrwnYl"     "Burg"       "BurgYl"    
#> [21] "DarkMint"   "Emrld"      "Magenta"    "Mint"       "OrYel"     
#> [26] "Peach"      "PinkYl"     "Purp"       "PurpOr"     "RedOr"     
#> [31] "Sunset"     "SunsetDark" "Teal"       "TealGrn"   
#> 
```
