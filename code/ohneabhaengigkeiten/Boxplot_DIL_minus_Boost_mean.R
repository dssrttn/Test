Boost_mean_boxplot
DIL_mean_boxplot

DIL_mean_boxplot <- distinct(DIL_mean_boxplot, Mittelwert_DIL) # aus dem ursprünglichen tibble wird nur die column Mittelwert behalten
#DIL_mean_boxplot <- DIL_mean_boxplot %>% select(Mittelwert_DIL = Mittelwert)
DIL_mean_boxplot

DIL_minus_Boost_mean_boxplot <- DIL_mean_boxplot %>% add_column(Mittelwert_Boost = Boost_mean_boxplot$Mittelwert)
DIL_minus_Boost_mean_boxplot

DIL_minus_Boost_mean_table <- ddply(DIL_minus_Boost_mean_boxplot, .(), transform, dilminusboost = (Mittelwert_DIL-Mittelwert_Boost)/(Mittelwert_DIL[1]-Mittelwert_Boost[1]))
DIL_minus_Boost_mean_table

DIL_minus_Boost_mean_table <- DIL_minus_Boost_mean_table %>% rename('Fraction' = '.id') #renmae column '.id' with 'Fraction'
DIL_minus_Boost_mean_table[1:14, 1] = (1:14)
DIL_minus_Boost_mean_table



max <-max(DIL_minus_Boost_mean_table$dilminusboost)
min <-min(DIL_minus_Boost_mean_table$dilminusboost)

par(bty="n") # keinen Rahmen
par(family="serif") # Schriftart
par(mar = c(5, 6.5, 2, 2)) # Abstände um den Plot. 2. Position y-Achse
par(mgp=c(5,1,0)) # mpg: Abstand Label zu Achse
boxplot(DIL_minus_Boost_mean_table$dilminusboost,
        ylab= "Relation Dil minus Boost", #y-Achse-Beschriftung
        #yaxt="n", #suppresses y-axis. Brauch ich das?
        col="transparent", #Farbe des Boxplots
        las = 2, # horizontale Markierung der Tick-Beschriftungen
        #ylim = c(0, 1),
        ylim=c(min(0.85), max(1.15)), # y-Achse range
        cex.lab = 2, # Größe Label-Beschriftung
        cex.axis = 1.5, # Größe Achsenbeschriftungen
        mgp=c(2.5,0.2,0) # mpg: Abstand Label zu Achse
        # , xpd = TRUE
        #labels = FALSE
)





DIL_minus_Boost_mean_table <- cut(DIL_minus_Boost_mean_table$dilminusboost, c(-Inf, 0.95, 0.96, 0.97, 0.98, 0.99, 1.00, 1.01, 1.02, 1.03, 1.04, 1.05, Inf), labels=c('<0.95%', '95-96%', '96-97%', '97-98%', '98-99%', '99-100%', '100-101%', '101-102%', '102-103%', '103-104%', '104-105%', '>105%'))  # benutzt dplyr, 7 Intervalle


DIL_minus_Boost_mean_table <- as.data.frame(DIL_minus_Boost_mean_table) %>%
  group_by(DIL_minus_Boost_mean_table, .drop = FALSE) %>% #.drop = FALSE ansonsten Fehlermeldung, weil  empty categories are dropped by default. You can change this behavior by adding .drop = FALSE
  dplyr::summarise(Numbers = n())  #%>% # %>% #=n())
#mutate(Nummers = rowSums(.[-1]))


DIL_minus_Boost_mean_table %>%
  knitr::kable(format ='html', caption = "", col.names = c("DIL minus boost", "Numbers")) %>%
  kable_styling(bootstrap_options = c("striped", "hover", "condensed"), full_width = FALSE)
