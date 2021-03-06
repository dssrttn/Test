DIL_mean <-  DIL
DIL_mean_rel <- DIL_mean
DIL_mean_rel <- distinct(DIL_mean_rel, Mittelwert) # aus dem ursprünglichen tibble wird nur die column Mittelwert behalten


#ddply(DIL_absolut, .(), transform, relchange2 = ((100 / Mittelwert[1]) * Mittelwert) - 100) # alternative Berechnung fuer relative Differenzen zum Ausgangswert in der 1. Reihe

DIL_mean_rel <- ddply(DIL_mean_rel, .(), transform, relchange = ((Mittelwert - Mittelwert[1]) / Mittelwert[1]) * 100) # relative Differenzen zum Ausgangswert in der 1. Reihe werden berechnet

DIL_mean_rel_table <- ddply(DIL_mean_rel, .(), transform, relchange = ((Mittelwert - Mittelwert[1]) / Mittelwert[1]) * 100)


DIL_mean_rel_table <- DIL_mean_rel_table %>% rename('Mean' = 'Mittelwert') #renmae column 'Mittelwert' with 'Mean'
DIL_mean_rel_table <- DIL_mean_rel_table %>% rename('Fraction' = '.id') #renmae column '.id' with 'Fraction'
DIL_mean_rel_table <- DIL_mean_rel_table %>% rename('Relative change' = 'relchange')  #renmae column 'relchange' with 'Relative change'

DIL_mean_rel_table[1:14, 1] = (1:14)

DIL_mean_rel_table %>%
  kable(align = c("ccccccccc"), escape = FALSE, format ='html', caption = "DIL descriptive statistics") %>%
  kable_styling(bootstrap_options = c("striped", "hover", "condensed"),
                full_width = TRUE)
