
# Load packages -----------------------------------------------------------

library(hexSticker)
library(magrittr)
library(ggplot2)


# Get data ----------------------------------------------------------------

data <- suppressWarnings(
        EstZoonoticTB::link_data(verbose = FALSE) %>% 
                dplyr::filter(!is.na(tb_z_prop)) %>% 
                dplyr::mutate(country = country %>% 
                                      as.character) %>% 
                dplyr::group_by(country) %>% 
                dplyr::arrange(desc(year)) %>% 
                dplyr::slice(1) %>% 
                dplyr::ungroup()
)


# Make image --------------------------------------------------------------
## Coastlines
continents <- rnaturalearth::ne_coastline(scale = "medium", 
                                          returnclass = "sf") 

## Remake package map
map <- global_map(data, variable = "tb_z_prop", 
                  trans = "sqrt",
                  show_caption = FALSE, 
                  viridis_palette = "cividis")$data %>% 
        ggplot() +
        geom_sf(ggplot2::aes(fill = tb_z_prop), col = "white", size = 0.05) +
        geom_sf(data = continents, col = "darkgrey", alpha = 0.6, size = 0.05) +
        theme(legend.position = "none") +
        theme_void() + theme_transparent() +
        theme(legend.position = "none",
              panel.background = element_blank()) +
        ggplot2::scale_fill_viridis_c(
                begin = 0,
                end = 0.9,
                trans = "identity",
                direction = -1, 
                option = "plasma",
                na.value = "lightgrey"
        )


# Make sticker ------------------------------------------------------------

sticker(map, 
        package = "EstZoonoticTB", 
        p_size = 18, 
        p_color = "#FFFFFFDD",
        s_x = 1,
        s_y= 0.75, 
        s_width=1.6, 
        s_height=0.8,
        h_fill = "#646770",
        h_color = "#b3ccff",
        filename="./man/figures/logo.png",
        url = "https://samabbott.co.uk/EstZoonoticTB",
        u_color = "#FFFFFFDD",
        u_size = 3.5,
        dpi = 330,
        asp = 1)


