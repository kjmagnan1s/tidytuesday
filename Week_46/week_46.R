pacman::p_load(tidyverse,
               janitor,
               countrycode,  ## converts long country name into different coding schemes
               tidytuesdayR, ## load tidy tuesday data from github
               dygraphs) 

tuesdata <- tt_load(2020, week=46)

mobile <- tuesdata$mobile
landline <- tuesdata$landline

mobile_clean <- mobile %>% 
  clean_names() %>% 
  filter(year >= 1990 & year <= 2013) %>% ## most yearly counts ended in 2013 :shrug:
  filter(code %in% "USA") %>% 
  group_by(year) %>% 
  summarise(mobile_subs)

landline_clean <- landline %>% 
  clean_names() %>%
  filter(year >= 1990 & year <= 2017) %>%  ## most yearly counts ended in 2017 :shrug:
  filter(code %in% "USA") %>% 
  group_by(year) %>%
  summarise(landline_subs)

landline_clean %>% 
  left_join(mobile_clean, by = "year") %>% 
  dygraph(main = "USA Phone Subscriptions, 1990 - 2017") %>% 
  dySeries("mobile_subs", label = "Mobile Subscriptions per 100") %>%
  dySeries("landline_subs", label = "Landline Subscriptions per 100") %>% 
  #dyHighlight(highlightSeriesOpts = list(strokeWidth = 3)) %>% 
  dyRangeSelector() %>% 
  dyMultiColumn() %>% 
  dyLegend(show = "follow")

