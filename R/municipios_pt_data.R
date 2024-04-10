#' @title Shape file with the map of Portuguese Municipalities
#'
#' @description The Dataset has information with maps of municipalities in Portugal.
#'
#' @format A tibble with 308 rows and 8 variables:
#' \describe{
#'   \item{\code{ID_1}}{ID for District.}
#'   \item{\code{NAME_1}}{Name of the District.}
#'   \item{\code{ID_2}}{ID of the municipalities.}
#'   \item{\code{NAME_2}}{Name of the Municipalities.}
#'   \item{\code{HASC_2}}{}
#'   \item{\code{CCN_2}}{}
#'   \item{\code{CCA_2}}{Main unique ID of the municipality.}
#'   \item{\code{geometry}}{Contains the multipolygons.}
#'}
#'
#' @source {
#' Portuguese Government.
#' Some cleaning was used to the data. 
#' pt_municip <- sf::st_read("path/concelhos.shp") 
#' There is a mistake in the names that was changed: 
#' use the code of conselhos
#' https://sites.google.com/site/codigosdasfreguesiasdeportugal/lista
#' pt_municip %<>% mutate(NAME_2 = case_when(
#'   CCA_2 == "0308" ~ "Guimaraes", (have to write it correctly to run code)
#'   CCA_2 == "0814" ~ "Tavira",
#'   TRUE ~ NAME_2
#' )) %>% 
#'   select(ID_1, NAME_1, ID_2, NAME_2, HASC_2, CCN_2, CCA_2, geometry)
#' }
#' 
#' @examples
#' data(pt_municip) # lazy loading. The RAM will not be immediately occupied.
"pt_municip"