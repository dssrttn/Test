XVI_tibble <-  XVI
XVI_tibble
XVI_tibble <- XVI_tibble %>% rename('Date' = 'X1')
XVI_tibble <- XVI_tibble %>% rename('Right-Left' = 'Re-li')
XVI_tibble <- XVI_tibble %>% rename('Inferior-Superior' = 'Inf-sup')
XVI_tibble <- XVI_tibble %>% rename('Posterior-Anterior' = 'Post-ant')


XVI_tibble_date <- XVI_tibble


XVI_tibble_date %>%
  kable(align = c("ccccccccc"), escape = FALSE, format ='html', caption = "") %>%
  kable_styling(bootstrap_options = c("striped", "hover", "condensed"),
                full_width = TRUE)


XVI_tibble <- XVI_tibble %>% mutate(Date = NULL)    # remove date column _after_ table

XVI_tibble <- describe(XVI_tibble)


XVI_tibble <- XVI_tibble %>% rename('Numbers' = n, Mean = mean, 'Standard deviation' = sd, Median = median, 'Standard errors' = se, Minimum = min, Maximum = max, Range = range)

XVI_tibble <- XVI_tibble %>%
  select(Numbers,   Mean,   'Standard deviation',   Median, Minimum,    Maximum, Range, 'Standard errors')
