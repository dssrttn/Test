

beta_mean_boxplot <- beta
alpha_mean_boxplot <- alpha

beta_mean_boxplot
alpha_mean_boxplot


alpha_mean_boxplot <- distinct(alpha_mean_boxplot, mean) # aus dem ursprünglichen tibble wird nur die column mean behalten
alpha_mean_boxplot <- alpha_mean_boxplot %>% select(mean_alpha = mean)
alpha_mean_boxplot

alphatobeta_1_mean_boxplot <- alpha_mean_boxplot %>% add_column(mean_beta = beta_mean_boxplot$mean)
alphatobeta_1_mean_boxplot

alphatobeta_1_mean_table <- ddply(alphatobeta_1_mean_boxplot, .(), transform, alphatobeta_1 = (mean_alpha/ mean_beta[1]))
alphatobeta_1_mean_table


alphatobeta_1_mean_table <- alphatobeta_1_mean_table %>% mutate(.id = row_number())
alphatobeta_1_mean_table <- alphatobeta_1_mean_table %>% rename('Fraction' = '.id') #renmae column '.id' with 'Fraction'
alphatobeta_1_mean_table

y <- alphatobeta_1_mean_table$alphatobeta_1

alphatobeta_1 <-ggplot(alphatobeta_1_mean_table, aes(x=""
                                                     ,y=y)) +
  geom_boxplot(width=0.4) #+
  #stat_boxplot(geom = "errorbar", width = 0.2) +
  #boxplottheme




alphatobeta_1_mean_table <- cut(alphatobeta_1_mean_table$alphatobeta_1, c(-Inf, 0.95, 0.96, 0.97, 0.98, 0.99, 1.00, 1.01, 1.02, 1.03, 1.04, 1.05, Inf), labels=c('<95%', '95-96%', '96-97%', '97-98%', '98-99%', '99-100%', '100-101%', '101-102%', '102-103%', '103-104%', '104-105%', '>105%'))  # benutzt dplyr, 7 Intervalle


alphatobeta_1_mean_table <- as.data.frame(alphatobeta_1_mean_table) %>%
  group_by(alphatobeta_1_mean_table, .drop = FALSE) %>% #.drop = FALSE ansonsten Fehlermeldung, weil  empty categories are dropped by default. You can change this behavior by adding .drop = FALSE
  dplyr::summarise(Numbers = n())  #%>% # %>% #=n())
#mutate(Nummers = rowSums(.[-1]))


alphatobeta_1_mean_table %>%
  knitr::kable(format ='html', caption = "", col.names = c("alpha minus beta", "Numbers")) %>%
  kable_styling(bootstrap_options = c("striped", "hover", "condensed"), full_width = FALSE)



