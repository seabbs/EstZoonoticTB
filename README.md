
# `{EstZoonoticTB}`: an R package for exploring, visualising and estimating the global zoonotic tuberculosis burden <img src="man/figures/logo.png" align="right" alt="" width="120" />

[![badge](https://img.shields.io/badge/Launch-EstZoonoticTB-green.svg)](https://mybinder.org/v2/gh/seabbs/EstZoonoticTB/master?urlpath=rstudio)
[![develVersion](https://img.shields.io/badge/devel%20version-0.2.0-lightgrey.svg?style=flat)](https://github.com/seabbs/EstZoonoticTB)
[![DOI](https://zenodo.org/badge/209318552.svg)](https://zenodo.org/badge/latestdoi/209318552)

`{EstZoonoticTB}` is an R package containing data relevant to global
zoonotic tuberculosis (TB), tools for manipulating and visualising these
data, and analysis aiming to improve country level estimates of zoonotic
TB. Packaged datasets include: cleaned data from [a recent systematic
review](https://www.ncbi.nlm.nih.gov/pmc/articles/PMC4816377/); data on
the country specific epidemiology of TB; demographic data (including
data on rural populations); animal demographic data; and data on the
presence of zoonotic TB in animal populations (both domesticated and
wild). Tooling includes functions for linking the built in datasets
(built with the aim of accommodating external data sources), data
mappping functions, and conveniance functions for manipulating the
linked datasets. The long term aim of the package is to provide a suite
of data and tools that can be used to iteratively improve the estimation
of global zoonotic TB burden. A secondary aim is to provide a user
friendly interface to zoonotic TB relevant data in order to help spread
awareness of zoonotic TB. See the package vignettes for further details.

## Installation

Install the development version from GitHub:

``` r
# install.packages("remotes")
remotes::install_github("seabbs/EstZoonoticTB")
```

## Documentation

### Overview

[![Documentation](https://img.shields.io/badge/Documentation-release-lightgrey.svg?style=flat)](https://www.samabbott.co.uk/EstZoonoticTB/)
[![Development
documentation](https://img.shields.io/badge/Documentation-development-lightblue.svg?style=flat)](https://www.samabbott.co.uk/EstZoonoticTB/dev)
[![Functions](https://img.shields.io/badge/Documentation-functions-orange.svg?style=flat)](https://www.samabbott.co.uk/EstZoonoticTB/reference/index.html)

### Vignettes

[![Data
sources](https://img.shields.io/badge/Documentation-data%20sources-lightgrey.svg?style=flat)](https://www.samabbott.co.uk/EstZoonoticTB/articles/data-sources.html)
[![Data
exploration](https://img.shields.io/badge/Documentation-data%20exploration-blue.svg?style=flat)](https://www.samabbott.co.uk/EstZoonoticTB/articles/data-exploration.html)
[![Data
mapping](https://img.shields.io/badge/Documentation-data%20mapping-green.svg?style=flat)](https://www.samabbott.co.uk/EstZoonoticTB/articles/data-mapping.html)

## Testing

[![Travis-CI Build
Status](https://travis-ci.org/seabbs/EstZoonoticTB.svg?branch=master)](https://travis-ci.org/seabbs/EstZoonoticTB)
[![AppVeyor Build
Status](https://ci.appveyor.com/api/projects/status/github/seabbs/EstZoonoticTB?branch=master&svg=true)](https://ci.appveyor.com/project/seabbs/EstZoonoticTB)
[![Coverage
Status](https://img.shields.io/codecov/c/github/seabbs/EstZoonoticTB/master.svg)](https://codecov.io/github/seabbs/EstZoonoticTB?branch=master)

## Data

The package comes prepackaged with multiple datasets that can then be
linked into a single dataset ready for analysis. This linked dataset can
be accessed using the following,

``` r
EstZoonoticTB::link_data(verbose = FALSE)
#> # A tibble: 15,061 x 26
#>    country country_code g_whoregion  year tb_cases tb_inc tb_inc_lo
#>    <fct>   <fct>        <fct>       <dbl>    <int>  <dbl>     <dbl>
#>  1 Afghan… AFG          Eastern Me…  2000    38000    190       123
#>  2 Afghan… AFG          Eastern Me…  2001    40000    189       123
#>  3 Afghan… AFG          Eastern Me…  2002    42000    189       122
#>  4 Afghan… AFG          Eastern Me…  2003    44000    189       122
#>  5 Afghan… AFG          Eastern Me…  2004    46000    189       122
#>  6 Afghan… AFG          Eastern Me…  2005    47000    189       122
#>  7 Afghan… AFG          Eastern Me…  2006    49000    189       122
#>  8 Afghan… AFG          Eastern Me…  2007    50000    189       122
#>  9 Afghan… AFG          Eastern Me…  2008    52000    189       122
#> 10 Afghan… AFG          Eastern Me…  2009    53000    189       123
#> # … with 15,051 more rows, and 19 more variables: tb_inc_hi <dbl>,
#> #   prop_tb_ep <dbl>, prop_hiv <dbl>, prop_hiv_lo <dbl>,
#> #   prop_hiv_hi <dbl>, z_tb_dom_animal <fct>, z_tb_wild_animal <fct>,
#> #   z_tb_id <int>, z_tb_geo_coverage <fct>, z_tb_study_pop <fct>,
#> #   z_tb_multi_year_study <fct>, tb_z_prop <dbl>, tb_z_prop_lo <dbl>,
#> #   tb_z_prop_hi <dbl>, tb_z_prop_se <dbl>, population <dbl>,
#> #   prop_rural <dbl>, cattle <int>, cattle_per_head <dbl>
```

See the package vignettes for details.

## Shiny dashboard

*Work in progress*

To explore the package functionality in an interactive session, or to
investigate Zoonotic TB without having to code extensively in R, a shiny
dashboard has been built into the package. This can either be used
locally using,

``` r
EstZoonoticTB::dashboard()
```

Or accessed online.

## Contributing

File an issue [here](https://github.com/seabbs/EstZoonoticTB/issues) if
there is a feature, or a dataset, that you think is missing from the
package, or better yet submit a pull request\!

Please note that the `EstZoonoticTB` project is released with a
[Contributor Code of
Conduct](https://github.com/seabbs/EstZoonoticTB/blob/master/.github/CODE_OF_CONDUCT.md).
By contributing to this project, you agree to abide by its terms.

## Citing

If using `EstZoonoticTB` please consider citing the package in the
relevant work. Citation information can be generated in R using the
following (after installing the package),

``` r
citation("EstZoonoticTB")
#> 
#> To cite EstZoonoticTB in publications use:
#> 
#>   Sam Abbott (2019). EstZoonoticTB: an R package for exploring,
#>   visualising and estimating the global zoonotic tuberculosis
#>   burden
#> 
#> A BibTeX entry for LaTeX users is
#> 
#>   @Article{,
#>     title = {EstZoonoticTB: an R package for exploring, visualising and estimating the global zoonotic tuberculosis burden},
#>     author = {Sam Abbott},
#>     journal = {-},
#>     year = {-},
#>     volume = {-},
#>     number = {-},
#>     pages = {-},
#>     doi = {-},
#>   }
```

## Docker

This package has been developed in docker based on the
`rocker/geospatial` image, to access the development environment enter
the following at the command line (with an active docker daemon
running),

``` bash
docker pull seabbs/estzoonotictb
docker run -d -p 8787:8787 -e USER=EstZoonoticTB -e PASSWORD=EstZoonoticTB --name EstZoonoticTB seabbs/estzoonotictb
```

The rstudio client can be accessed on port `8787` at `localhost` (or
your machines ip). The default username is EstZoonoticTB and the default
password is EstZoonoticTB. Alternatively, access the development
environment via
[binder](https://mybinder.org/v2/gh/seabbs/EstZoonoticTB/master?urlpath=rstudio).
