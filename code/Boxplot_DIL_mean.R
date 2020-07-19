Boost_mean_boxplot

DIL_mean_boxplot <- distinct(DIL_mean_boxplot, Mittelwert) # aus dem ursprünglichen tibble wird nur die column Mittelwert behalten
DIL_mean_boxplot <- DIL_mean_boxplot %>% select(Mittelwert_DIL = Mittelwert)
DIL_mean_boxplot



DIL_Boost_mean_boxplot <- DIL_mean_boxplot %>% add_column(Mittelwert_Boost = Boost_mean_boxplot$Mittelwert)
DIL_Boost_mean_boxplot

DIL_Boost_mean_relation <- ddply(DIL_Boost_mean_boxplot, .(), transform, DILtoBoost_1 = (Mittelwert_DIL/ Mittelwert_Boost[1]))
DIL_Boost_mean_relation

DIL_Boost_mean_relation <- DIL_Boost_mean_relation %>% rename('Fraction' = '.id') #renmae column '.id' with 'Fraction'
DIL_Boost_mean_relation[1:14, 1] = (1:14)
DIL_Boost_mean_relation



max <-max(DIL_Boost_mean_relation$DILtoBoost_1)
min <-min(DIL_Boost_mean_relation$DILtoBoost_1)

par(bty="n") # keinen Rahmen
par(family="serif") # Schriftart
par(mar = c(0, 6.5, 2, 2)) # Abstände um den Plot. 2. Position y-Achse
par(mgp=c(5,1,0)) # mpg: Abstand Label zu Achse
boxplot(DIL_Boost_mean_relation$DILtoBoost_1,
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



DIL_Boost_mean_relation %>%
  kable(align = c("cc"), escape = FALSE, format ='html', caption = "DIL durch Boost[1") %>%
  kable_styling(bootstrap_options = c("striped", "hover", "condensed"),
                full_width = TRUE)

DIL_Boost_mean_relation <- cut(DIL_Boost_mean_relation$DILtoBoost_1, c(-Inf, 0.95, 0.96, 0.97, 0.98, 0.99, 1.00, 1.01, 1.02, 1.03, 1.04, 1.05, Inf), labels=c('<95%', '95-96%', '96-97%', '97-98%', '98-99%', '99-100%', '100-101%', '101-102%', '102-103%', '103-104%', '104-105%', '>105%'))  # benutzt dplyr, 7 Intervalle


DIL_Boost_mean_relation <- as.data.frame(DIL_Boost_mean_relation) %>%
  group_by(DIL_Boost_mean_relation, .drop = FALSE) %>% #.drop = FALSE ansonsten Fehlermeldung, weil  empty categories are dropped by default. You can change this behavior by adding .drop = FALSE
  dplyr::summarise(Numbers = n())  #%>% # %>% #=n())
#mutate(Nummers = rowSums(.[-1]))
