Boost_mean_boxplot <- Boost
DIL_mean_boxplot <- DIL

#DILtoBoost_1 = (Mittelwert_DIL/ Mittelwert_Boost[1]))




DIL_n_Boost_1_mean_boxplot <- DIL_mean_boxplot %>%
  # aus dem ursprünglichen tibble wird nur die column Mittelwert behalten
  #select(Mittelwert_DIL = Mittelwert)
  distinct(Mittelwert)  %>%
  # Kolumne Mittelwert in Kolumne DIL_Mean umbenannt
  rename('DIL_Mean' = 'Mittelwert')  %>%
  # Kolumne Boost_Mean aus Boost_nean_boxplot-Dataframe wird hinzugefügt
  add_column(Boost_Mean = Boost_mean_boxplot$Mittelwert) %>%
  # Rechnung DIL_Mean/ Boost_Mean in Kolumne DILtoBoost_n wird durchgeführt
  transform(DILtoBoost_1 = (DIL_Mean/ Boost_Mean[1])) %>%
  mutate(.id = row_number()) %>%
  rename('Fraction' = '.id') %>%
  select(Fraction, everything()) # changes position of column "Fraction" to first place


DIL_n_Boost_1_mean_boxplot   %>%
  knitr::kable(align = c("cccc"), format ='html', caption = "", col.names = c("Fraction", "DIL_Mean", "Boost_Mean", "DIL_n to Boost_1 relation")) %>%
  kable_styling(bootstrap_options = c("striped", "hover", "condensed"), full_width = FALSE)

max <-max(DIL_n_Boost_1_mean_boxplot$DILtoBoost_1) # _1 für 1. Fraktion
min <-min(DIL_n_Boost_1_mean_boxplot$DILtoBoost_1)

par(bty="n") # keinen Rahmen
par(family="serif") # Schriftart
par(mar = c(2, 6.5, 2, 2)) # Abstände um den Plot. 2. Position y-Achse
par(mgp=c(5,1,0)) # mpg: Abstand Label zu Achse
boxplot(DIL_n_Boost_1_mean_boxplot$DILtoBoost_1,
        ylab= "DIL[n] to Boost[1]", #y-Achse-Beschriftung
        #yaxt="n", #suppresses y-axis. Brauch ich das?
        col="transparent", #Farbe des Boxplots
        las = 2, # horizontale Markierung der Tick-Beschriftungen
        #ylim = c(0, 1),
        ylim=c(min(0.995*min), max(1.005*max)), # y-Achse range
        cex.lab = 2, # Größe Label-Beschriftung
        cex.axis = 1.5, # Größe Achsenbeschriftungen
        mgp=c(2.5,0.2,0) # mpg: Abstand Label zu Achse
        # , xpd = TRUE
        #labels = FALSE
)


DIL_n_Boost_1_mean_boxplot <- cut(DIL_n_Boost_1_mean_boxplot$DILtoBoost_1, c(-Inf, 0.95, 0.96, 0.97, 0.98, 0.99, 1.00, 1.01, 1.02, 1.03, 1.04, 1.05, Inf), labels=c('<95%', '95-96%', '96-97%', '97-98%', '98-99%', '99-100%', '100-101%', '101-102%', '102-103%', '103-104%', '104-105%', '>105%'))  # benutzt dplyr, 7 Intervalle


DIL_n_Boost_1_mean_boxplot <- as.data.frame(DIL_n_Boost_1_mean_boxplot) %>%
  group_by(DIL_n_Boost_1_mean_boxplot, .drop = FALSE) %>% #.drop = FALSE ansonsten Fehlermeldung, weil  empty categories are dropped by default. You can change this behavior by adding .drop = FALSE
  dplyr::summarise(Numbers = n())  #%>% # %>% #=n())
#mutate(Nummers = rowSums(.[-1]))


DIL_n_Boost_1_mean_boxplot %>%
  knitr::kable(format ='html', caption = "", col.names = c("DIL_n to Boost_1 relation", "Numbers")) %>%
  kable_styling(bootstrap_options = c("striped", "hover", "condensed"), full_width = FALSE)
