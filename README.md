Miguel Salema

<!-- README.md is generated from README.Rmd. Please edit that file -->

# peerest

<!-- badges: start -->
<!-- badges: end -->

The goal of peerest is to …

Estimate peer effects in high-dimensional networks

## Installation

You can install the development version of peerest from
[GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("Salema-DG/ptmap")
```

## Example

This is a basic example which shows you how to solve a common problem:

``` r
library(ptmap)
#> Loading required package: sf
#> Linking to GEOS 3.10.2, GDAL 3.4.1, PROJ 7.2.1; sf_use_s2() is TRUE
## basic example code

library(dplyr)
#> Warning: package 'dplyr' was built under R version 4.1.3
#> 
#> Attaching package: 'dplyr'
#> The following objects are masked from 'package:stats':
#> 
#>     filter, lag
#> The following objects are masked from 'package:base':
#> 
#>     intersect, setdiff, setequal, union
data(qp_nut2_data) # load wage data from Portugal at NUT2 level

# create a tibble with only one year, 2019.
df19 <- qp_nut2_data %>%
 filter(year == 2019)

# Apply the function
map_pt_19 <- df19 %>%
 map_pt_nuts_II(main_var = mean_real_wage,
                nut2_var = nut_2_est,
                nut_var_qp = T)
```

``` r
# can the figure show up?
map_pt_19
```

<img src="man/figures/README-unnamed-chunk-3-1.png"
style="width:100.0%" />
