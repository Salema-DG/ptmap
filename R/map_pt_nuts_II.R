
#' @title Plot NUTS2 in Portugal
#'
#' @description This function creates a map with information for Portugal at the NUT2 level.
#' The function automatically places the islands next to mainland Portugal.
#' It has the feature nut_var_qp, that should be TRUE if the user is using QP data with the cleaning of Miguel Salema.
#'
#' @param data A tibble with the nut2 level information and a nut2 column.
#' @param main_var The variable with the NUT2 level info. E.g., average wage by nut. Not a string.
#' @param nut2_var Name of the column that has the info about the nuts. Not a string.
#' @param pal A palette to be used in the colors of the plot
#' @param coordinates This list contains the coordinates for mainland portugal, madeira and a?ores.
#' @param map What is the base map that should be used.
#' @param nut_var_qp If true, that means that the NUT2 classification in the variable is not correct, but yes as in my QP cleaning (1, 2,...). If this is TRUE, it automatically transforms this variable.
#'
#' @return A ggplot object with the map. The theme can still be changed and other options/geoms added.
#'
#' @export
#'
#' @author Miguel Salema
#'
#' @importFrom magrittr "%>%"
#' @importFrom magrittr "%<>%"
#' @importFrom rlang ":="
#' @importFrom rlang ".data"
#'
#' @examples
#' library(dplyr)
#' data(qp_nut2_data) # load wage data from Portugal at NUT2 level
#'
#' # create a tibble with only one year, 2019.
#' df19 <- qp_nut2_data %>%
#'   filter(year == 2019)
#'
#' # Apply the function
#' map_pt_19 <- df19 %>%
#'   map_pt_nuts_II(main_var = mean_real_wage,
#'                  nut2_var = nut_2_est,
#'                  nut_var_qp = T)
#'
#' # The output is a ggplot map that can be easily altered
#' map_pt_19 +
#'   labs(fill = "Real Average Wage") # changes the title of the legend
#'
#' # we can put 2 graphs next to each other
#' df93 <- qp_nut2_data %>%
#'   filter(year == 1993)
#'
#' map_pt_93 <- df93 %>%
#'   map_pt_nuts_II(main_var = mean_real_wage,
#'                  nut2_var = nut_2_est,
#'                  nut_var_qp = TRUE)
#'
#' library(gridExtra)
#' grid.arrange(map_pt_93,
#'              map_pt_19,
#'              ncol=2)
#'
map_pt_nuts_II <- function(data,
                           main_var,
                           nut2_var,
                           pal  = NULL,
                           coordinates = list(
                             x_continent = c(-12, -6),
                             y_continent = c(36.7, 42),
                             x_madeira = c(-17.5, -16),
                             y_madeira = c(32.5, 33.2),
                             x_acores = c(-31, -25.5),
                             y_acores = c(37, 39.5)
                           ),
                           map = ptmap::europe,
                           nut_var_qp = FALSE) {



  if (is.null(pal)) {
    pal <- RColorBrewer::brewer.pal(4,"BrBG")
  }

  # create a dataset with portugal only and NUTS 2
  pt <- map %>%
    dplyr::filter(c(CNTR_CODE) == "PT") %>% # Portugal
    dplyr::filter(stringr::str_length(c(NUTS_ID)) == 4) # only the NUTs2
  # the sf package has methods that mimic tidyverse sintax
  # because of this masking, I must put sf as a dependency

  # correct the nut2 varaible if it comes from my qp cleaning
  if (nut_var_qp == TRUE) {
    data %<>%
      dplyr::mutate({{nut2_var}} := dplyr::case_when(
        nut_2_est == 1 ~ "PT11",
        nut_2_est == 2 ~ "PT15",
        nut_2_est == 3 ~ "PT16",
        nut_2_est == 4 ~ "PT17",
        nut_2_est == 5 ~ "PT18",
        nut_2_est == 6 ~ "PT20",
        nut_2_est == 7 ~ "PT30",
      ))
  }

  # add the information to the map
  by <- dplyr::join_by(NUTS_ID == {{nut2_var}})

  df_graph <- pt %>%
    dplyr::left_join(
      data,
      by = by # I must change this, this variable must be chosen at some point
    )

  # The base plot
  map_base <-
    # Start with a full european map, for the coordinates to make sense
    map %>%
    ggplot2::ggplot() +
    ggplot2::geom_sf() +
    # then add the data of portugal
    ggplot2::geom_sf(
      data = df_graph,
      ggplot2::aes(fill = {{main_var}}),
      color = "white") +
    #facet_grid(cols = vars(year)) +
    ggplot2::theme_classic() +
    ggplot2:: theme(
      legend.position = "top",
      panel.background = ggplot2::element_rect(
        fill = "lightblue" # add blue for the sea
      )) +
    ggplot2::scale_fill_gradientn(colours = pal) # the palette

  # devide the territories
  # In this codes, to make the xlim and ylim be coordinates, it's essensial to have a crs code
  # This one is a code that encompasses almost the entire globe

  map_continente <-
    map_base +
    ggplot2::coord_sf(
      crs = sf::st_crs(4326),
      xlim = coordinates[[1]],
      ylim = coordinates[[2]],
      expand = TRUE#, datum = NA
    )

  map_madeira <-
    map_base +
    ggplot2::theme(
      legend.position = "none",
      plot.background = ggplot2::element_rect(fill = "lightblue")
    ) +
    ggplot2::coord_sf(crs = sf::st_crs(4326),
             xlim = coordinates[[3]],
             ylim = coordinates[[4]],
             expand = TRUE,
             datum = NA
    )

  map_acores <-
    map_base +
    ggplot2::theme(
      legend.position = "none",
      plot.background = ggplot2::element_rect(fill = "lightblue")
    ) +
    ggplot2::coord_sf(
      crs = sf::st_crs(4326),
      xlim = coordinates[[5]],
      ylim = coordinates[[6]],
      expand = TRUE,
      datum = NA
    )


  #join them all. I can further add some dynamism here too
  full_portugal <- map_continente +
    ggplot2::annotation_custom(
      grob = ggplot2::ggplotGrob(map_madeira),
      xmin = -12,
      xmax = -10,
      ymin = 37,
      ymax = 39
    ) +
    ggplot2::annotation_custom(
      grob = ggplot2::ggplotGrob(map_acores),
      xmin = -12,
      xmax = -9,
      ymin = 40,
      ymax = 42
    )

  return(full_portugal)
}

# This allows me to set the variable as coming from a dataset in the package
# # this makes the function pass in devtools::check
globalVariables(c("NUTS_ID", "CNTR_CODE"))





