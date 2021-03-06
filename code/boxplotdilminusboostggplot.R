Boost_mean_boxplot <- Boost
DIL_mean_boxplot <- DIL

Boost_mean_boxplot
DIL_mean_boxplot


DIL_mean_boxplot <- distinct(DIL_mean_boxplot, Mittelwert) # aus dem ursprünglichen tibble wird nur die column Mittelwert behalten
DIL_mean_boxplot <- DIL_mean_boxplot %>% select(Mittelwert_DIL = Mittelwert)
DIL_mean_boxplot

DIL_minus_Boost_mean_boxplot <- DIL_mean_boxplot %>% add_column(Mittelwert_Boost = Boost_mean_boxplot$Mittelwert)
DIL_minus_Boost_mean_boxplot

DIL_minus_Boost_mean_table <- ddply(DIL_minus_Boost_mean_boxplot, .(), transform, dilminusboost =  (Mittelwert_DIL-Mittelwert_Boost)/(Mittelwert_DIL[1]-Mittelwert_Boost[1]))
DIL_minus_Boost_mean_table

DIL_minus_Boost_mean_table <- DIL_minus_Boost_mean_table %>% mutate(.id = row_number())
DIL_minus_Boost_mean_table <- DIL_minus_Boost_mean_table %>% rename('Fraction' = '.id') #renmae column '.id' with 'Fraction'
DIL_minus_Boost_mean_table

y <- DIL_minus_Boost_mean_table$dilminusboost

DILminusboost <-ggplot(DIL_minus_Boost_mean_table, aes(x=""
                                       ,y=y)) +
  geom_boxplot(width=0.4) +
  stat_boxplot(geom = "errorbar", width = 0.2) +
 boxplottheme



DIL_minus_Boost_mean_table <- cut(DIL_minus_Boost_mean_table$dilminusboost, c(-Inf, 0.95, 0.96, 0.97, 0.98, 0.99, 1.00, 1.01, 1.02, 1.03, 1.04, 1.05, Inf), labels=c('<95%', '95-96%', '96-97%', '97-98%', '98-99%', '99-100%', '100-101%', '101-102%', '102-103%', '103-104%', '104-105%', '>105%'))  # benutzt dplyr, 7 Intervalle


DIL_minus_Boost_mean_table <- as.data.frame(DIL_minus_Boost_mean_table) %>%
  group_by(DIL_minus_Boost_mean_table, .drop = FALSE) %>% #.drop = FALSE ansonsten Fehlermeldung, weil  empty categories are dropped by default. You can change this behavior by adding .drop = FALSE
  dplyr::summarise(Numbers = n())  #%>% # %>% #=n())
#mutate(Nummers = rowSums(.[-1]))


DIL_minus_Boost_mean_table %>%
  knitr::kable(format ='html', caption = "", col.names = c("DIL minus boost", "Numbers")) %>%
  kable_styling(bootstrap_options = c("striped", "hover", "condensed"), full_width = FALSE)



