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



DILtoBoost_2percent_mean_table <- cut(DILtoBoost_n_mean_table$DILtoBoost_n, c(-Inf, 0.98, 1.02, Inf), labels=c('<98%', '98-102%', '>102%'))  # benutzt dplyr, 7 Intervalle


DILtoBoost_2percent_mean_table <- as.data.frame(DILtoBoost_2percent_mean_table) %>%
  group_by(DILtoBoost_2percent_mean_table, .drop = FALSE) %>% #.drop = FALSE ansonsten Fehlermeldung, weil  empty categories are dropped by default. You can change this behavior by adding .drop = FALSE
  dplyr::summarise(Numbers = n())  #%>% # %>% #=n())
#mutate(Nummers = rowSums(.[-1]))


DILtoBoost_2percent_mean_table %>%
  knitr::kable(format ='html', caption = "", col.names = c("DIL to boost", "Numbers")) %>%
  kable_styling(bootstrap_options = c("striped", "hover", "condensed"), full_width = FALSE)
