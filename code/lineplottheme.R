lineplottheme <-  list(
  c(scale_y_continuous(expand=c(0.1, .01), breaks = pretty_breaks(), labels=function(x) paste0(x,"%"))),  #labels=function(x) paste0(x,"%") adds percent symbol, but without multiplying it with 100, like when one does: scale_y_continuous(labels = scales::percent)
    geom_abline(intercept = 0, slope = 0, lty=1, col='orange')  # horizontale Linie ohne Steigung, da slope = 0
    )
