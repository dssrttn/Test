Rectum_mean_rel <- Rectum

Rectum_mean_rel <- distinct(Rectum_mean_rel, Mittelwert) # aus dem ursprünglichen tibble wird nur die column Mittelwert behalten


#ddply(DIL_absolut, .(), transform, relchange2 = ((100 / Mittelwert[1]) * Mittelwert) - 100) # alternative Berechnung fuer relative Differenzen zum Ausgangswert in der 1. Reihe

Rectum_mean_rel <- ddply(Rectum_mean_rel, .(), transform, relchange = ((Mittelwert - Mittelwert[1]) / Mittelwert[1]) * 100) # relative Differenzen zum Ausgangswert in der 1. Reihe werden berechnet

Rectum_mean_rel_table <- ddply(Rectum_mean_rel, .(), transform, relchange = ((Mittelwert - Mittelwert[1]) / Mittelwert[1]) * 100)


Rectum_mean_rel_table <- Rectum_mean_rel_table %>% rename('Fraction' = '.id') #renmae column '.id' with 'Fraction'
Rectum_mean_rel_table <- Rectum_mean_rel_table %>% rename('Relative change' = 'relchange')  #renmae column 'relchange' with 'Relative change'

Rectum_mean_rel_table[1:14, 1] = (1:14)

Rectum_mean_rel_table %>%
  kable(align = c("ccccccccc"), escape = FALSE, format ='html', caption = "Rectum mean descriptive statistics") %>%
  kable_styling(bootstrap_options = c("striped", "hover", "condensed"),
                full_width = TRUE)


x <- (1:14)
y <- Rectum_mean_rel$relchange
