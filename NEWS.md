# EstZoonoticTB 0.2.0

## Feature updates

* Added `global_map` function for plotting country level data for a single variable.
* Added`get_latest_data` conveniance function for extracting the lastest data for a given variable.
* Added `get_latest_combined_data` conveniance function for extracting the lastest data for each variable of interest and then joining this data into a single dataframe with year flags indicating when data is from.
* Improved quality of data linkage so that fewer zoonotic TB proportion studies are implicitly dropped.

## Package updates

* Added tests (including `{vidffr}` image tests) for `global_map`.
* Updated package logo.
* Update travis and Appveyor to work with `{sf}`.
* Dropped MacOs Travis testing as not clear how to automate.
* Added required packages to suggests for using `{sf}`.

# EstZoonoticTB 0.1.0

## Feature updates

* Imported [`getTBinR::get_tb_burden()`](https://www.samabbott.co.uk/getTBinR/reference/get_tb_burden.html) in order to surface WHO TB burden estimates.
* Added FAO estimates of population demographics to the package. 
* Added OIE estimates for zoonostic TB presence in domesticated and wild animals.
* Added FAO demographic estimates for cattle.
* Added data on zoonotic TB incidence in humans from [this](https://www.ncbi.nlm.nih.gov/pmc/articles/PMC4816377/) systematic review.
* Added a data sources vignette detailing available data, sources, and cleaning steps taken.
* Added `EstZoonoticTB::link_data` to link the various relevant datasets. By default using built in datasets but custom datasets (using the same formatting) can also be supplied.
* Added `vignettes/data-exploration.Rmd` and `vignettes/data-mapping.Rmd` vignettes to explore linked data.

## Package updates

* Set up package using existing infrastructure from [getTBinR](https://github.com/seabbs/getTBinR).
* Documentation building set up using Travis CI.
* Added tests for all datasets.