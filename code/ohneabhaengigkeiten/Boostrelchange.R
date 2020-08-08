Boost_mean <- Boost
Boost_mean_rel <- Boost_mean
Boost_mean_rel <- distinct(Boost_mean_rel, Mittelwert) # aus dem ursprünglichen tibble wird nur die column Mittelwert behalten


#ddply(DIL_absolut, .(), transform, relchange2 = ((100 / Mittelwert[1]) * Mittelwert) - 100) # alternative Berechnung fuer relative Differenzen zum Ausgangswert in der 1. Reihe

Boost_mean_rel <- ddply(Boost_mean_rel, .(), transform, relchange = ((Mittelwert - Mittelwert[1]) / Mittelwert[1]) * 100) # relative Differenzen zum Ausgangswert in der 1. Reihe werden berechnet

Boost_mean_rel_table <- ddply(Boost_mean_rel, .(), transform, relchange = ((Mittelwert - Mittelwert[1]) / Mittelwert[1]) * 100)


Boost_mean_rel_table <- Boost_mean_rel_table %>% rename('Mean' = 'Mittelwert') #renmae column 'Mittelwert' with 'Mean'
Boost_mean_rel_table <- Boost_mean_rel_table %>% rename('Fraction' = '.id') #renmae column '.id' with 'Fraction'
Boost_mean_rel_table <- Boost_mean_rel_table %>% rename('Relative change' = 'relchange')  #renmae column 'relchange' with 'Relative change'

Boost_mean_rel_table[1:14, 1] = (1:14)

Boost_mean_rel_table %>%
  kable(align = c("ccccccccc"), escape = FALSE, format ='html', caption = "Boost descriptive statistics") %>%
  kable_styling(bootstrap_options = c("striped", "hover", "condensed"),
                full_width = TRUE)
