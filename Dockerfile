## Start with the shiny docker image
FROM rocker/geospatial:latest

MAINTAINER "Sam Abbott" contact@samabbott.co.uk

ADD . /home/rstudio/EstZoonoticTB

## Install pkgdown for website generation
RUN Rscript -e 'devtools::install_github("r-lib/pkgdown")'

## Install hexsticker to generate package badge.
RUN Rscript -e 'install.packages("hexSticker")'

## Install dev deps
RUN Rscript -e 'devtools::install_dev_deps("home/rstudio/EstZoonoticTB")'

## Install the package
RUN Rscript -e 'devtools::install("home/rstudio/EstZoonoticTB")'