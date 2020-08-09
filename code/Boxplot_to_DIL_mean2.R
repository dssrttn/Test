

Boost_mean_boxplot <- Boost
DIL_mean_boxplot <- DIL

Boost_mean_boxplot
DIL_mean_boxplot


DIL_mean_boxplot <- distinct(DIL_mean_boxplot, Mittelwert) # aus dem ursprünglichen tibble wird nur die column Mittelwert behalten
DIL_mean_boxplot <- DIL_mean_boxplot %>% select(Mittelwert_DIL = Mittelwert)
DIL_mean_boxplot

DIL_Boost_mean_relation_boxplot <- DIL_mean_boxplot %>% add_column(Mittelwert_Boost = Boost_mean_boxplot$Mittelwert)
DIL_Boost_mean_relation_boxplot

DIL_Boost_mean_relation_table <- ddply(DIL_Boost_mean_relation_boxplot, .(), transform, DILtoBoost_1 = (Mittelwert_DIL/ Mittelwert_Boost[1]))
DIL_Boost_mean_relation_table

DIL_Boost_mean_relation_table <- DIL_Boost_mean_relation_table %>% mutate(.id = row_number())
DIL_Boost_mean_relation_table

y <- DIL_Boost_mean_relation_table$DILtoBoost_1

ggplot(DIL_Boost_mean_relation_table, aes(x="" #1:nrow(DIL_minus_Boost_mean_table)
                                       ,y=y)) +
  geom_boxplot() +
  plottheme +
  axis.text.x=element_blank() +
  axis.ticks.x=element_blank()





DIL_Boost_mean_relation_table <- cut(DIL_Boost_mean_relation_table$DILtoBoost_1, c(-Inf, 0.95, 0.96, 0.97, 0.98, 0.99, 1.00, 1.01, 1.02, 1.03, 1.04, 1.05, Inf), labels=c('<0.95%', '95-96%', '96-97%', '97-98%', '98-99%', '99-100%', '100-101%', '101-102%', '102-103%', '103-104%', '104-105%', '>105%'))  # benutzt dplyr, 7 Intervalle


DIL_Boost_mean_relation_table <- as.data.frame(DIL_Boost_mean_relation_table) %>%
  group_by(DIL_Boost_mean_relation_table, .drop = FALSE) %>% #.drop = FALSE ansonsten Fehlermeldung, weil  empty categories are dropped by default. You can change this behavior by adding .drop = FALSE
  dplyr::summarise(Numbers = n())  #%>% # %>% #=n())
#mutate(Nummers = rowSums(.[-1]))


DIL_Boost_mean_relation_table %>%
  knitr::kable(format ='html', caption = "", col.names = c("DIL minus boost", "Numbers")) %>%
  kable_styling(bootstrap_options = c("striped", "hover", "condensed"), full_width = FALSE)

