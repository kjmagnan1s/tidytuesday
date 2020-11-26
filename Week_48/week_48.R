pacman::p_load(tidyverse,
               readr,
               ggridges)
pacman::p_load_gh("clauswilke/ggridges")

hike_data <- readr::read_rds(url('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2020/2020-11-24/hike_data.rds')) %>% 
  mutate(trip = case_when(
    grepl("roundtrip", length) ~ "roundtrip",
    grepl("one-way", length) ~ "one-way",
    grepl("of trails", length) ~ "trails"),
    trail_length = parse_number(length),
    ## decided not to double one way and, instead, filter out for personal reasons/thoughts
    ## old method:
    ## trail_length = as.numeric(gsub("(\\d+[.]\\d+).*", "\\1", length)) * ((trip == "one-way") + 1),
    gain = as.numeric(gain),
    highpoint = as.numeric(highpoint),
    location_general = gsub("(.*)\\s[-][-].*", "\\1", location)
    )

hike_data %>% 
  filter(trip %in% "roundtrip") %>% 
  mutate(grp_rating = case_when(
    rating < 1 ~ "< 1",
    rating >= 1 & rating <= 2 ~ "1 - 2",
    rating > 2 & rating <= 3 ~ "2 - 3",
    rating > 3 & rating <= 4 ~ "3  -4",
    rating > 4 ~ "4 - 5"
  )) %>%
  ggplot(aes(x = trail_length,
             y = location_general,
             fill = grp_rating)) +
    geom_density_ridges(alpha = 0.25) +
    #theme(legend.position = "none") +
    labs( title = "Washington State Hikes",
          x = "Trail Length (Miles)",
          y = "Washington State Regions",
          fill = "Difficulty Rating",
          caption = "Design: @KevinMagnan | Data: Washington Trails Assocation (wta.org)
          #TidyTuesday Week 48") + 
    theme(panel.grid = element_blank()) +
  ggsave(filename = "~/GitHub/tidytuesday/Week_48/week_48.png", dpi = 180)