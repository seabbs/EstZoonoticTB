
library(pkgnet)
library(dplyr)
## remotes::install_github("jimhester/itdepends")
library(itdepends)

## Declare paths explicitly as currently required by pkgnet
pkg_path <- system.file(package = "EstZoonoticTB")
report_path <- file.path(getwd(), "EstZoonoticTB_report.html")

## Generate pkg report
report <- CreatePackageReport("EstZoonoticTB",
                              report_path = report_path)




## Look at functions used using itdepends 
dep_usage_pkg("EstZoonoticTB") %>% 
  count(pkg) %>% 
  arrange(desc(n))

## Currently little scope for removing packages as those with few uses either play a critical role or 
## are depended on in turn by packages that see more use (i.e tidyr and dplyr).