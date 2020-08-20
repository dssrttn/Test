Boost_mean_boxplot <- Boost
DIL_mean_boxplot <- DIL

#Boost_mean_boxplot
#DIL_mean_boxplot


DIL_mean_boxplot <- distinct(DIL_mean_boxplot, Mittelwert) # aus dem ursprünglichen tibble wird nur die column Mittelwert behalten
DIL_mean_boxplot <- DIL_mean_boxplot %>% select(Mittelwert_DIL = Mittelwert)
#DIL_mean_boxplot

DILtoBoost_1_mean_boxplot <- DIL_mean_boxplot %>% add_column(Mittelwert_Boost = Boost_mean_boxplot$Mittelwert)
#DILtoBoost_1_mean_boxplot

DILtoBoost_n_mean_table <- ddply(DILtoBoost_1_mean_boxplot, .(), transform, DILtoBoost_n = (Mittelwert_DIL/ Mittelwert_Boost))
#DILtoBoost_1_mean_table

DILtoBoost_n_mean_table <- DILtoBoost_n_mean_table %>% mutate(.id = row_number())
DILtoBoost_n_mean_table <- DILtoBoost_n_mean_table %>% rename('Fraction' = '.id') #renmae column '.id' with 'Fraction'
DILtoBoost_n_mean_table

y <- DILtoBoost_n_mean_table$DILtoBoost_n

DILtoBoost_1 <-ggplot(DILtoBoost_n_mean_table, aes(x=""
                                                   ,y=y)) +
  geom_boxplot(width=0.4) +
  stat_boxplot(geom = "errorbar", width = 0.2) +
  boxplottheme



DILtoBoost_n_mean_table <- cut(DILtoBoost_n_mean_table$DILtoBoost_n, c(-Inf, 0.95, 0.96, 0.97, 0.98, 0.99, 1.00, 1.01, 1.02, 1.03, 1.04, 1.05, Inf), labels=c('<95%', '95-96%', '96-97%', '97-98%', '98-99%', '99-100%', '100-101%', '101-102%', '102-103%', '103-104%', '104-105%', '>105%'))  # benutzt dplyr, 7 Intervalle


DILtoBoost_n_mean_table <- as.data.frame(DILtoBoost_n_mean_table) %>%
  group_by(DILtoBoost_n_mean_table, .drop = FALSE) %>% #.drop = FALSE ansonsten Fehlermeldung, weil  empty categories are dropped by default. You can change this behavior by adding .drop = FALSE
  dplyr::summarise(Numbers = n())  #%>% # %>% #=n())
#mutate(Nummers = rowSums(.[-1]))


DILtoBoost_n_mean_table %>%
  knitr::kable(format ='html', caption = "", col.names = c("DIL to boost", "Numbers")) %>%
  kable_styling(bootstrap_options = c("striped", "hover", "condensed"), full_width = FALSE)



