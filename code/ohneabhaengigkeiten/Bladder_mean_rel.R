Bladder_mean_rel <- Bladder

Bladder_mean_rel <- distinct(Bladder_mean_rel, Mittelwert) # aus dem ursprünglichen tibble wird nur die column Mittelwert behalten


#ddply(DIL_absolut, .(), transform, relchange2 = ((100 / Mittelwert[1]) * Mittelwert) - 100) # alternative Berechnung fuer relative Differenzen zum Ausgangswert in der 1. Reihe

Bladder_mean_rel <- ddply(Bladder_mean_rel, .(), transform, relchange = ((Mittelwert - Mittelwert[1]) / Mittelwert[1]) * 100) # relative Differenzen zum Ausgangswert in der 1. Reihe werden berechnet

Bladder_mean_rel_table <- ddply(Bladder_mean_rel, .(), transform, relchange = ((Mittelwert - Mittelwert[1]) / Mittelwert[1]) * 100)


Bladder_mean_rel_table <- Bladder_mean_rel_table %>% rename('Fraction' = '.id') #renmae column '.id' with 'Fraction'
Bladder_mean_rel_table <- Bladder_mean_rel_table %>% rename('Relative change' = 'relchange')  #renmae column 'relchange' with 'Relative change'

Bladder_mean_rel_table[1:14, 1] = (1:14)

Bladder_mean_rel_table %>%
  kable(align = c("ccccccccc"), escape = FALSE, format ='html', caption = "Bladder mean descriptive statistics") %>%
  kable_styling(bootstrap_options = c("striped", "hover", "condensed"),
                full_width = TRUE)


x <- (1:14)
y <- Bladder_mean_rel$relchange
