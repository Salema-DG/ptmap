Miguel Salema

<!-- README.md is generated from README.Rmd. Please edit that file -->

# ptmap

<!-- badges: start -->
<!-- badges: end -->

`ptmap` facilitates the creation of maps of Portuguese NUTs. For now, it
only supports NUTs 2.

## Installation

You can install the development version of ptmap from
[GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("Salema-DG/ptmap")
```

## Example

This is a basic example which shows you how to solve a common problem:

``` r
library(ptmap)
library(dplyr)
library(ggplot2)

data(qp_nut2_data) # load wage data from Portugal at NUT2 level

# create a tibble with only one year, 2019.
df19 <- qp_nut2_data %>%
 filter(year == 2019)

# Apply the function
map_pt_19 <- df19 %>%
 map_pt_nuts_II(main_var = mean_real_wage,
                nut2_var = nut_2_est,
                nut_var_qp = T,
                round_to = 0,
                unit = "")
```

``` r
# The output is a ggplot map that can be easily altered
map_pt_19 +
  labs(title = "Real Average Wage by Region") # changes the title of legend
```

<img src="man/figures/README-unnamed-chunk-3-1.png" style="width:100.0%"
data-fig-pos="center" />
