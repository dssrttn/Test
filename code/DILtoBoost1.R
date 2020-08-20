
DIL_mean_boxplot <- distinct(DIL_mean_boxplot, Mittelwert) # aus dem ursprünglichen tibble wird nur die column Mittelwert behalten
DIL_mean_boxplot <- DIL_mean_boxplot %>% select(Mittelwert_DIL = Mittelwert)
#DIL_mean_boxplot

DILtoBoost_1_mean_boxplot <- DIL_mean_boxplot %>% add_column(Mittelwert_Boost = Boost_mean_boxplot$Mittelwert)
#DILtoBoost_1_mean_boxplot

DILtoBoost_1_mean_table <- ddply(DILtoBoost_1_mean_boxplot, .(), transform, DILtoBoost_1 = (Mittelwert_DIL/ Mittelwert_Boost[1]))
#DILtoBoost_1_mean_table

DILtoBoost_1_mean_table <- DILtoBoost_1_mean_table %>% mutate(.id = row_number())
DILtoBoost_1_mean_table <- DILtoBoost_1_mean_table %>% rename('Fraction' = '.id') #renmae column '.id' with 'Fraction'
DILtoBoost_1_mean_table

y <- DILtoBoost_1_mean_table$DILtoBoost_1

DILtoBoost_1 <-ggplot(DILtoBoost_1_mean_table, aes(x=""
                                                   ,y=y)) +
  geom_boxplot(width=0.4) +
  stat_boxplot(geom = "errorbar", width = 0.2) +
  boxplottheme

DILtoBoost_1_mean_table <- cut(DILtoBoost_1_mean_table$DILtoBoost_1, c(-Inf, 0.95, 0.96, 0.97, 0.98, 0.99, 1.00, 1.01, 1.02, 1.03, 1.04, 1.05, Inf), labels=c('<95%', '95-96%', '96-97%', '97-98%', '98-99%', '99-100%', '100-101%', '101-102%', '102-103%', '103-104%', '104-105%', '>105%'))  # benutzt dplyr, 7 Intervalle

