Kevin Magnan
11/3/2020

<br>

``` r
ikea <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2020/2020-11-03/ikea.csv')

p <- ggplotly(
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
) %>% 
  layout(annotations = list(x = 40,
                            y = 1200,
                            showarrow = F,
                            text = "Hover for more details!"))
```

<!--html_preserve-->

<iframe src="C:/Users/kEVIN/Documents/GitHub/tidytuesday/Week_45/index.html" width="100%" height="600" scrolling="no" seamless="seamless" frameBorder="0">

</iframe>

<!--/html_preserve-->
