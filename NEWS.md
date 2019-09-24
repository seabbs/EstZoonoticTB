# EstZoonoticTB 0.1.0

## Feature updates

* Imported [`getTBinR::get_tb_burden()`](https://www.samabbott.co.uk/getTBinR/reference/get_tb_burden.html) in order to surface WHO TB burden estimates.
* Added FAO estimates of population demographics to the package. 
* Added OIE estimates for zoonostic TB presence in domesticated and wild animals.
* Added FAO demographic estimates for cattle.
* Added data on zoonotic TB incidence in humans from [this](https://www.ncbi.nlm.nih.gov/pmc/articles/PMC4816377/) systematic review.
* Added a data sources vignette detailing available data, sources, and cleaning steps taken.
* Added `EstZoonoticTB::link_data` to link the various relevant datasets. By default using built in datasets but custom datasets (using the same formatting) can also be supplied.

## Package updates

* Set up package using existing infrastructure from [getTBinR](https://github.com/seabbs/getTBinR).
* Documentation building set up using Travis CI.
* Added tests for all datasets.