DIL_mean <-  DIL
DIL_mean_rel <- DIL_mean
DIL_mean_rel <- distinct(DIL_mean_rel, Mittelwert) # aus dem ursprünglichen tibble wird nur die column Mittelwert behalten


#ddply(DIL_absolut, .(), transform, relchange2 = ((100 / Mittelwert[1]) * Mittelwert) - 100) # alternative Berechnung fuer relative Differenzen zum Ausgangswert in der 1. Reihe

DIL_mean_rel <- ddply(DIL_mean_rel, .(), transform, relchange = ((Mittelwert - Mittelwert[1]) / Mittelwert[1]) * 100) # relative Differenzen zum Ausgangswert in der 1. Reihe werden berechnet

HistogramDILrelchange <- ddply(DIL_mean_rel, .(), transform, relchange = ((Mittelwert - Mittelwert[1]) / Mittelwert[1]) * 100)