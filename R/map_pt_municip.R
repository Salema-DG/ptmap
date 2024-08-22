
#' @title Plot Municipalities in Portugal
#'
#' @description This function creates a map with information for Portugal at the municipality level.
#' The function automatically places the islands next to mainland Portugal.
#'
#' @param data A tibble with the municipality level information and a minicipality code column.
#' @param main_var The variable with the municipality level info. E.g., median wage by municipality. Not a string.
#' @param municip_var Unique ID of the Municipality
#' @param pal A palette to be used in the colors of the plot
#' @param coordinates This list contains the coordinates for mainland portugal, madeira and a?ores.
#' @param map What is the base map that should be used.
#' @param map_europe An attempt to draw Spain
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
#' data(ine_municip_wage)
#' 
#' ine_municip_wage %>% 
#'   map_pt_municip(median_wage,
#'                  cod)
#'
map_pt_municip <- function(data,
                           main_var,
                           municip_var,
                           pal  = NULL,
                           coordinates = list(
                             x_continent = c(-12, -6),
                             y_continent = c(36.7, 42),
                             x_madeira = c(-17.5, -16),
                             y_madeira = c(32.5, 33.2),
                             x_acores = c(-31, -25.5),
                             y_acores = c(37, 39.5)
                           ),
                           map = ptmap::pt_municip,
                           map_europe = ptmap::europe,
                           extra = NULL
                           ) {



  if (is.null(pal)) {
    pal <- RColorBrewer::brewer.pal(4,"BrBG")
  }

  # add the information to the map
  by <- dplyr::join_by(CCA_2 == {{municip_var}})

  df_graph <- map %>%
    dplyr::left_join(
      data,
      by = by # I must change this, this variable must be chosen at some point
    )

  # The base plot
  map_base <-
    # Start with a full european map, for the coordinates to make sense
    map_europe %>%
    ggplot2::ggplot() +
    #ggplot2::geom_sf() +
    # then add the data of portugal
    ggplot2::geom_sf(
      data = df_graph,
      ggplot2::aes(fill = {{main_var}}),
      color = "white",
      linewidth = 0.05) +
    #facet_grid(cols = vars(year)) +
    ggplot2::theme_classic() +
    ggplot2:: theme(
      #legend.position = "none",
      axis.title = ggplot2::element_blank(),
      panel.background = ggplot2::element_rect(
        fill = "lightblue" # add blue for the sea
      )) +
    ggplot2::scale_fill_gradientn(colours = pal)  # the palette
    
  # add the extra stuff
  if (!is.null(extra)) {
    map_base <- 
      map_base + 
      extra
  }


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





