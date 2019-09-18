
# Load packages -----------------------------------------------------------

library(hexSticker)
library(magrittr)
library(ggplot2)


# Make image --------------------------------------------------------------

map <- ggplot()

# Make sticker ------------------------------------------------------------

sticker(map, 
        package = "EstZoonoticTB", 
        p_size = 18, 
        p_color = "#FFFFFFDD",
        s_x = 1,
        s_y=.75, 
        s_width=1.6, 
        s_height=0.8,
        h_fill = "#b3ccff",
        h_color = "#646770",
        filename="./man/figures/logo.png",
        url = "https://samabbott.co.uk/EstZoonoticTB",
        u_color = "#FFFFFFDD",
        u_size = 3.5)


