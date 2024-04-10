#' @title Median Wage by Municipalities in Portugal
#'
#' @description The Dataset information about the median Portuguese wage in 2019, by Municipalities.
#' These summary statistics were taken from Quadros de Pessoal by INE.
#' The average wage refers to the total wage but not including the 13th and 14th month.
#' It's before taxes and Social Security contributions.
#'
#' @format A tibble with 308 rows and 4 variables:
#' \describe{
#'   \item{\code{cod}}{Unique ID of the municipality.}
#'   \item{\code{level}}{Municipalities.}
#'   \item{\code{name}}{Name of the municipality.}
#'   \item{\code{median_wage}}{Median wage of the region.}
#'}
#'
#' @source {INE, 2019. Comes from Quadros de Pessoal. Some data changes:
#' ine_municip_wage <- read_excel("draft/destaque_rend_2019_pt.xlsx",
#'                                sheet = 10,
#'                                range = "A2:D341")
#' 
#' names(ine_municip_wage) <- c("cod", "level", "name", "median_wage")
#' 
#' ine_municip_wage %<>% filter(level == "Municipio") (tem de ser bem escrito)
#' 
#' ine_municip_wage$median_wage %<>% as.integer()
#' 
#' 
#' }
#'
#' @examples
#' data(ine_municip_wage) # lazy loading. The RAM will not be immediately occupied.
"ine_municip_wage"