
<!-- README.md is generated from README.Rmd. Please edit that file -->

# hapiverse

<!-- badges: start -->
<!-- badges: end -->

The hapiverse (human API universe) is an ongoing effort to embrace a
collection of R packages that work together to provide programmatic
access to the European Bioinformatics Institute (EMBL-EBI) REST API
services, namely those related with human genetic variation and
phenotypes. Currently, this meta-package provides easy installation and
loading of two packages:

-   [gwasrapidd](https://github.com/ramiromagno/gwasrapidd) that
    provides access to the [GWAS Catalog](https://www.ebi.ac.uk/gwas/)
-   [quincunx](https://github.com/maialab/quincunx) that provides access
    to the [PGS Catalog](https://www.pgscatalog.org/)

## Installation

You can install the current version of hapiverse with:

``` r
# install.packages("remotes")
remotes::install_github("maialab/hapiverse")
```

## Usage

After installing hapiverse, you also get
[gwasrapidd](https://github.com/ramiromagno/gwasrapidd) and
[quincunx](https://github.com/maialab/quincunx) installed.

To load and attach concomitantly
[gwasrapidd](https://github.com/ramiromagno/gwasrapidd) and
[quincunx](https://github.com/maialab/quincunx) simply run:

``` r
library(hapiverse)
#> ── Attaching packages ─────────────────────────────────────── hapiverse 0.1.0 ──
#> ✓ gwasrapidd 0.99.11     ✓ quincunx   0.1.0
#> ── Conflicts ────────────────────────────────────────── hapiverse_conflicts() ──
#> x quincunx::bind()           masks gwasrapidd::bind()
#> x quincunx::get_traits()     masks gwasrapidd::get_traits()
#> x quincunx::intersect()      masks gwasrapidd::intersect(), base::intersect()
#> x quincunx::n()              masks gwasrapidd::n()
#> x quincunx::open_in_dbsnp()  masks gwasrapidd::open_in_dbsnp()
#> x quincunx::open_in_pubmed() masks gwasrapidd::open_in_pubmed()
#> x quincunx::setdiff()        masks gwasrapidd::setdiff(), base::setdiff()
#> x quincunx::setequal()       masks gwasrapidd::setequal(), base::setequal()
#> x quincunx::union()          masks gwasrapidd::union(), base::union()
```

During the attaching of hapiverse, you will get notified of those
functions that have clashing names. Behind the scenes we use the package
[conflicted](https://github.com/r-lib/conflicted) to avoid misuse of
functions with the same name. In these cases you will be required to
choose one of the functions by using the double colon operator (`::`).

As an example, both gwasrapidd and quincunx provide a function named
`get_traits()`. If you try to use it directly, R will throw an error and
ask that you specify either `gwasrapidd::get_traits()` or
`quincunx::get_traits()`.

Trying to use `get_traits()` will return an error because of the
ambiguity arising from the two definitions:

``` r
get_traits()
#> Error: [conflicted] `get_traits` found in 2 packages.
#> Either pick the one you want with `::` 
#> * quincunx::get_traits
#> * gwasrapidd::get_traits
#> Or declare a preference with `conflict_prefer()`
#> * conflict_prefer("get_traits", "quincunx")
#> * conflict_prefer("get_traits", "gwasrapidd")
```

Note that you can use the function `hapiverse_conflicts()` at any time
to revise the list of clashing function names:

``` r
hapiverse_conflicts()
#> ── Conflicts ────────────────────────────────────────── hapiverse_conflicts() ──
#> x quincunx::bind()           masks gwasrapidd::bind()
#> x quincunx::get_traits()     masks gwasrapidd::get_traits()
#> x quincunx::intersect()      masks gwasrapidd::intersect(), base::intersect()
#> x quincunx::n()              masks gwasrapidd::n()
#> x quincunx::open_in_dbsnp()  masks gwasrapidd::open_in_dbsnp()
#> x quincunx::open_in_pubmed() masks gwasrapidd::open_in_pubmed()
#> x quincunx::setdiff()        masks gwasrapidd::setdiff(), base::setdiff()
#> x quincunx::setequal()       masks gwasrapidd::setequal(), base::setequal()
#> x quincunx::union()          masks gwasrapidd::union(), base::union()
```

If you specify the package name with the double colon operator (`::`),
then the ambiguity is resolved and execution proceeds normally. Using
`get_traits()` from gwasrapidd:

``` r
gwasrapidd::get_traits(efo_id = 'EFO_0005537')
#> An object of class "traits" (from package "gwasrapidd")
#> Slot "traits":
#> # A tibble: 1 x 3
#>   efo_id      trait                         uri                                 
#>   <chr>       <chr>                         <chr>                               
#> 1 EFO_0005537 triple-negative breast cancer http://www.ebi.ac.uk/efo/EFO_0005537
```

Or using `get_traits()` provided by quincunx:

``` r
quincunx::get_traits(efo_id = 'EFO_0005537')
#> An object of class "traits" (from package "quincunx")
#> Slot "traits":
#> # A tibble: 1 x 6
#>   efo_id  parent_efo_id is_child trait      description              url        
#>   <chr>   <chr>         <lgl>    <chr>      <chr>                    <chr>      
#> 1 EFO_00… <NA>          FALSE    triple-ne… An invasive breast carc… http://www…
#> 
#> Slot "pgs_ids":
#> # A tibble: 1 x 4
#>   efo_id      parent_efo_id is_child pgs_id   
#>   <chr>       <chr>         <lgl>    <chr>    
#> 1 EFO_0005537 <NA>          FALSE    PGS000216
#> 
#> Slot "child_pgs_ids":
#> # A tibble: 0 x 4
#> # … with 4 variables: efo_id <chr>, parent_efo_id <chr>, is_child <lgl>,
#> #   child_pgs_id <chr>
#> 
#> Slot "trait_categories":
#> # A tibble: 1 x 4
#>   efo_id      parent_efo_id is_child trait_categories
#>   <chr>       <chr>         <lgl>    <chr>           
#> 1 EFO_0005537 <NA>          FALSE    Cancer          
#> 
#> Slot "trait_synonyms":
#> # A tibble: 5 x 4
#>   efo_id      parent_efo_id is_child trait_synonyms                        
#>   <chr>       <chr>         <lgl>    <chr>                                 
#> 1 EFO_0005537 <NA>          FALSE    TN breast cancer                      
#> 2 EFO_0005537 <NA>          FALSE    Triple-Negative Breast Carcinoma      
#> 3 EFO_0005537 <NA>          FALSE    triple-negative breast cancer         
#> 4 EFO_0005537 <NA>          FALSE    triple-negative breast carcinoma      
#> 5 EFO_0005537 <NA>          FALSE    triple-receptor negative breast cancer
#> 
#> Slot "trait_mapped_terms":
#> # A tibble: 7 x 4
#>   efo_id      parent_efo_id is_child trait_mapped_terms
#>   <chr>       <chr>         <lgl>    <chr>             
#> 1 EFO_0005537 <NA>          FALSE    DOID:0060081      
#> 2 EFO_0005537 <NA>          FALSE    MESH:D064726      
#> 3 EFO_0005537 <NA>          FALSE    MONDO:0005494     
#> 4 EFO_0005537 <NA>          FALSE    NCIT:C71732       
#> 5 EFO_0005537 <NA>          FALSE    SCTID:706970001   
#> 6 EFO_0005537 <NA>          FALSE    SNOMEDCT:706970001
#> 7 EFO_0005537 <NA>          FALSE    UMLS:C3539878
```
