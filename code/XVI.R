XVI_tibble <-  XVI
XVI_tibble <- XVI_tibble %>% rename('Fraction' = 'X1') #renmae column 'X1' with 'Fraction'
XVI_tibble <- XVI_tibble %>% mutate(Fraction = row_number())
XVI_tibble <- XVI_tibble %>% rename(c('Right-Left' = 'Re-li', 'Inferior-Superior' = 'Inf-sup', 'Posterior-Anterior' = 'Post-ant'))
#XVI_tibble <- XVI_tibble %>% rename('Inferior-Superior' = 'Inf-sup')
#XVI_tibble <- XVI_tibble %>% rename('Posterior-Anterior' = 'Post-ant')


XVI_tibble_date <- XVI_tibble


XVI_tibble_date %>%
  kable(align = c("ccccccccc"), escape = FALSE, format ='html', caption = "") %>%
  kable_styling(bootstrap_options = c("striped", "hover", "condensed"),
                full_width = TRUE)

XVI_tibble_date

XVI_tibble <- XVI_tibble %>% mutate(Fraction = NULL)    # remove fraction column _after_ table

XVI_tibble <- describe(XVI_tibble)


XVI_tibble <- XVI_tibble %>% rename('Numbers' = n, Mean = mean, 'Standard deviation' = sd, Median = median, 'Standard errors' = se, Minimum = min, Maximum = max, Range = range)

XVI_tibble <- XVI_tibble %>%
  select(Numbers,   Mean,   'Standard deviation',   Median, Minimum,    Maximum, Range, 'Standard errors')
