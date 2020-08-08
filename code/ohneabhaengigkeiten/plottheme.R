plottheme <- list(
  theme_classic() +
    theme(
      legend.title = element_blank(),
      legend.text = element_text(color = "black", size = rel(1)),
      plot.title =  element_blank(),  #element_text(color="black", size=14, face="bold.italic", family ="serif"), # Titel des Graphen
      axis.text.x = element_text(margin = unit(c(1.5, 0, 0, 0), "mm"), family = "serif", size=rel(2)), # X-Achsen-Bezeichnungs-Parameter
      axis.text.y = element_text(margin = unit(c(0, 1.5, 0, 0), "mm"), family = "serif", size=rel(2)), # Y-Achsen-Bezeichnungs-Parameter
      axis.title.x = element_text(margin = unit(c(1.5, 0, 0, 0), "mm"), family = "serif", size=rel(2)),
      # X-Achsen-Beschriftungs-(groß)-Parameter
      axis.title.y = element_text(margin = unit(c(0, 2, 0, 0), "mm"), family = "serif", size=rel(2)), # Y-Achsen-Beschriftungs-(groß)-Parameter
      plot.margin = margin(0.5, 0.5, 0.5, 0.5, "cm"), # Abstände um den Graphen in top-right-bottom-left Orientierung
      axis.ticks = element_line(color = 'black', size = 0.5, linetype = 1), axis.ticks.length = unit(0.2, "cm"), # Teilstriche
      axis.line = element_line(color = 'black', size = 0.3, linetype = 1) # Achsenlinie
    )
)
