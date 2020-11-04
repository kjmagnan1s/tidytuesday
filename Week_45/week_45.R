pacman::p_load(
  tidyverse,
  tidytuesdayR,
  plotly
)

ikea <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2020/2020-11-03/ikea.csv')

ggplotly(
  ikea %>%
    mutate(price_usd = price * 0.27) %>%
    select(item_id, name, category, price_usd) %>% 
    group_by(category, name) %>% 
    summarise(name_count = n(), 
              price_per_unit = round(mean(price_usd), 2)) %>%
    ggplot(aes(x = name_count, y = price_per_unit, text = paste(
      "Ikea Category:", category,
      "<br>", "Number of items in", category,"category:", name_count, name,
      "<br>", "Price per unit: $", price_per_unit
    ))) +
    geom_point(aes(size = price_per_unit, color = category)) +
    theme(legend.title = element_blank()) +
    labs(title = "TidyTuesday Week 45: Ikea Furniture | Made by @KevinMagnan",
         x = "Count of Ikea Furniture By Name",
         y = "Price Per Unit"
    ), tooltip = "text"
)