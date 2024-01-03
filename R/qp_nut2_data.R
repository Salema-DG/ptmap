
#' @title Average Wage by NUTII in Portugal
#'
#' @description The Dataset information about the average Portuguese wage from 1991 to 1019.
#' (except for 2001).
#' These summary statistics were taken from Quadros de Pessoal.
#' The average wage refers to the total wage (base wage, all subsidies and extra hours payments).
#' It's also deflated with a local price index. It's thus a price purchasing power comparison.
#' All other data restriction made in Miguel Salema's QP_stand cleaning are applicable.
#'
#' @format A tibble with 203 rows and 4 variables:
#' \describe{
#'   \item{\code{year}}{Year of data collection. October from 1993 onwards and March before.}
#'   \item{\code{nut_2_est}}{NUT2 location of the establishment where the worker is employed at. The codes match the asceding order of the true codes.}
#'   \item{\code{region}}{Name of the NUT2 location.}
#'   \item{\code{mean_real_wage}}{Real average wage of the region.}
#'}
#'
#' @source {Quadros de Portugal, MTSSS.}
#'
#' @examples
#' data(qp_nut2_data) # lazy loading. The RAM will not be immediately occupied.
"qp_nut2_data"



