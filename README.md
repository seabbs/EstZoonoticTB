
# EstZoonoticTB: an R package for estimating and visualising zoonotic TB <img src="man/figures/logo.png" align="right" alt="" width="120" />

[![badge](https://img.shields.io/badge/Launch-EstZoonoticTB-green.svg)](https://mybinder.org/v2/gh/seabbs/EstZoonoticTB/master?urlpath=rstudio)
[![CRAN\_Release\_Badge](http://www.r-pkg.org/badges/version-ago/EstZoonoticTB)](https://CRAN.R-project.org/package=EstZoonoticTB)
[![develVersion](https://img.shields.io/badge/devel%20version-0.1.0-lightgrey.svg?style=flat)](https://github.com/seabbs/EstZoonoticTB)
[![DOI](https://zenodo.org/badge/112591837.svg)](https://zenodo.org/badge/latestdoi/112591837)

## Installation

Install the development version from GitHub:

``` r
# install.packages("remotes")
remotes::install_github("seabbs/EstZoonoticTB")
```

## Documentation

[![Documentation](https://img.shields.io/badge/Documentation-release-lightgrey.svg?style=flat)](https://www.samabbott.co.uk/EstZoonoticTB/)
[![Development
documentation](https://img.shields.io/badge/Documentation-development-lightblue.svg?style=flat)](https://www.samabbott.co.uk/EstZoonoticTB/dev)
[![Functions](https://img.shields.io/badge/Documentation-functions-orange.svg?style=flat)](https://www.samabbott.co.uk/EstZoonoticTB/reference/index.html)
[![Data
sources](https://img.shields.io/badge/Documentation-data%20sources-green.svg?style=flat)](https://www.samabbott.co.uk/EstZoonoticTB/reference/data-sources.html)

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
EstZoonoticTB::link_data()
#> Downloading data from: https://extranet.who.int/tme/generateCSV.asp?ds=estimates
#> Saving data to: /tmp/RtmpMIUSuv/tb_burden.rds
#> Downloading data from: https://extranet.who.int/tme/generateCSV.asp?ds=mdr_rr_estimates
#> Saving data to: /tmp/RtmpMIUSuv/mdr_tb.rds
#> Joining TB burden data and MDR TB data.
#> Getting additional dataset: Latent TB infection
#> Downloading data from: https://extranet.who.int/tme/generateCSV.asp?ds=ltbi_estimates
#> Saving data to: /tmp/RtmpMIUSuv/latent_tb_infection.rds
#> Getting additional dataset: Notification
#> Downloading data from: https://extranet.who.int/tme/generateCSV.asp?ds=notifications
#> Saving data to: /tmp/RtmpMIUSuv/notification.rds
#> Getting additional dataset: Drug resistance surveillance
#> Downloading data from: https://extranet.who.int/tme/generateCSV.asp?ds=dr_surveillance
#> Saving data to: /tmp/RtmpMIUSuv/drug_resistance_surveillance.rds
#> Getting additional dataset: Non-routine HIV surveillance
#> Downloading data from: https://extranet.who.int/tme/generateCSV.asp?ds=tbhivnonroutinesurv
#> Saving data to: /tmp/RtmpMIUSuv/non-routine_hiv_surveillance.rds
#> Getting additional dataset: Outcomes
#> Downloading data from: https://extranet.who.int/tme/generateCSV.asp?ds=outcomes
#> Saving data to: /tmp/RtmpMIUSuv/outcomes.rds
#> Getting additional dataset: Budget
#> Downloading data from: https://extranet.who.int/tme/generateCSV.asp?ds=budget
#> Saving data to: /tmp/RtmpMIUSuv/budget.rds
#> Getting additional dataset: Expenditure and utilisation
#> Downloading data from: https://extranet.who.int/tme/generateCSV.asp?ds=expenditure_utilisation
#> Saving data to: /tmp/RtmpMIUSuv/expenditure_and_utilisation.rds
#> Getting additional dataset: Policies and services
#> Downloading data from: https://extranet.who.int/tme/generateCSV.asp?ds=policies
#> Saving data to: /tmp/RtmpMIUSuv/policies_and_services.rds
#> Getting additional dataset: Community engagement
#> Downloading data from: https://extranet.who.int/tme/generateCSV.asp?ds=community
#> Saving data to: /tmp/RtmpMIUSuv/community_engagement.rds
#> Getting additional dataset: Laboratories
#> Downloading data from: https://extranet.who.int/tme/generateCSV.asp?ds=labs
#> Saving data to: /tmp/RtmpMIUSuv/laboratories.rds
#> Joining TB burden data and additional datasets.
#> Joining human and animal demographic data.
#> Countries with data present for demographics and not animal demographics:
#>  [1] "Andorra"                  "Anguilla"                
#>  [3] "Aruba"                    "Channel Islands"         
#>  [5] "China, Macao SAR"         "Gibraltar"               
#>  [7] "Holy See"                 "Isle of Man"             
#>  [9] "Kiribati"                 "Maldives"                
#> [11] "Marshall Islands"         "Mayotte"                 
#> [13] "Monaco"                   "Nauru"                   
#> [15] "Northern Mariana Islands" "Palau"                   
#> [17] "San Marino"               "Tokelau"                 
#> [19] "Turks and Caicos Islands" "Tuvalu"
#> Countries with data present for animal demographics and not demographics:
#> [1] "Norfolk Island"
#> Joining TB incidence in humans data and zTB presence in animals data.
#> Countries with data present for TB incidence and not zTB in animals:
#>  [1] "American Samoa"                       
#>  [2] "Anguilla"                             
#>  [3] "Antigua and Barbuda"                  
#>  [4] "Aruba"                                
#>  [5] "Bahamas"                              
#>  [6] "Benin"                                
#>  [7] "Bermuda"                              
#>  [8] "Bonaire, Saint Eustatius and Saba"    
#>  [9] "British Virgin Islands"               
#> [10] "Cameroon"                             
#> [11] "Cayman Islands"                       
#> [12] "China, Macao SAR"                     
#> [13] "Curaçao"                              
#> [14] "Democratic People's Republic of Korea"
#> [15] "Dominica"                             
#> [16] "Equatorial Guinea"                    
#> [17] "Gabon"                                
#> [18] "Grenada"                              
#> [19] "Guam"                                 
#> [20] "Guatemala"                            
#> [21] "Lebanon"                              
#> [22] "Luxembourg"                           
#> [23] "Maldives"                             
#> [24] "Monaco"                               
#> [25] "Montserrat"                           
#> [26] "Nauru"                                
#> [27] "Netherlands Antilles"                 
#> [28] "Niue"                                 
#> [29] "Northern Mariana Islands"             
#> [30] "Puerto Rico"                          
#> [31] "Rwanda"                               
#> [32] "Saint Kitts and Nevis"                
#> [33] "Serbia & Montenegro"                  
#> [34] "Seychelles"                           
#> [35] "Sint Maarten (Dutch part)"            
#> [36] "Solomon Islands"                      
#> [37] "Tajikistan"                           
#> [38] "Togo"                                 
#> [39] "Tokelau"                              
#> [40] "Turks and Caicos Islands"             
#> [41] "Tuvalu"                               
#> [42] "Wallis and Futuna Islands"            
#> [43] "Yemen"
#> Countries with data present for zTB in animals and not TB incidence:
#>  [1] "Ceuta"                          "Chinese Taipei"                
#>  [3] "Falkland Islands (Malvinas)"    "Faroe Islands"                 
#>  [5] "French Guiana"                  "Guadeloupe (France)"           
#>  [7] "Liechtenstein, Principality of" "Martinique"                    
#>  [9] "Mayotte (France)"               "Melilla"                       
#> [11] "Reunion"                        "St. Helena"
#> Joining zTB incidence in humans data and all other TB data
#> # A tibble: 4,148 x 22
#>    country country_code g_whoregion  year tb_cases tb_inc tb_inc_lo
#>    <chr>   <chr>        <chr>       <dbl>    <int>  <dbl>     <dbl>
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
#> # … with 4,138 more rows, and 15 more variables: tb_inc_hi <dbl>,
#> #   prop_tb_ep <dbl>, prop_hiv <dbl>, prop_hiv_lo <dbl>,
#> #   prop_hiv_hi <dbl>, dom <fct>, wild <fct>, z_tb_id <int>,
#> #   z_tb_geo_coverage <fct>, z_tb_study_pop <fct>,
#> #   z_tb_multi_year_study <fct>, prop_tb_z <dbl>, prop_tb_z_lo <dbl>,
#> #   prop_tb_z_hi <dbl>, prop_tb_z_se <dbl>
```

## Shiny dashboard

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
#>   Sam Abbott (2019). EstZoonoticTB: an R package for estimating
#>   and visualising zoonotic TB
#> 
#> A BibTeX entry for LaTeX users is
#> 
#>   @Article{,
#>     title = {EstZoonoticTB: an R package for estimating and visualising zoonotic TB},
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
