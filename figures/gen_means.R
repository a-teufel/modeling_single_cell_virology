#draws generation means (Fig. S9)
rm(list = ls())
library(ggplot2)
library(cowplot)
library(ggridges)
require(reshape2)
library(plyr)

name <-
  paste(
    "data/105/Est_gen_ABC.txt"
  )
temp <- scan(name)
gen <- rbind(temp)
#the error code was zero, so just take these out
g <- gen[gen > 0]


name <-
  paste(
    "data/104/Est_gen_ABC.txt"
  )
temp <- scan(name)
gen1 <- rbind(temp)
g1 <- gen1[gen1 > 0]


name <-
  paste(
    "data/106/Est_gen_ABC.txt"
  )
temp <- scan(name)
gen2 <- rbind(temp)
g2 <- gen2[gen2 > 0]



name <-
  paste(
    "data/107/Est_gen_ABC.txt"
  )
temp <- scan(name)
gen3 <- rbind(temp)
g3 <- gen3[gen3 > 0]


D_104 <- data.frame(generations = g1)
D_105 <- data.frame(generations = g)
D_106 <- data.frame(generations = g2)
D_107 <- data.frame(generations = g3)

D_104 <- as.data.frame(D_104)
D_104$experiment <- "no drug  "

D_105 <- as.data.frame(D_105)
D_105$experiment <- "rupintrivir  "

D_106 <- as.data.frame(D_106)
D_106$experiment <- "2'-C-meA  "

D_107 <- as.data.frame(D_107)
D_107$experiment <- "ganetespib  "

#set up colors
cbPalette <-
  c(
    "#999999",
    "#E69F00",
    "#56B4E9",
    "#009E73",
    "#F0E442",
    "#0072B2",
    "#D55E00",
    "#CC79A7"
  )
darkPalette <-
  c("#4c4c4c",
    "#734f00",
    "#12608d",
    "#004f39",
    "#8d840b",
    "#003859",
    "#6a2f00")

all_alpha = 0.1
all_size = .75
line_size = 1
adjust=1
#do all combinations and add in p-values
combined <- rbind.fill(D_104, D_105, D_106,D_107)




#p <-
#  format(ks.test(D_104$generations, D_105$generations)$p.value,
#         digits = 2)

g1 <-
  ggplot(D_104,
         aes(generations, colour = experiment, fill = experiment)) + geom_density(alpha =
                                                                                    all_alpha, size = all_size,adjust=adjust) + scale_fill_manual(values = cbPalette[1]) + scale_colour_manual(values =
                                                                                                                                                                                                 cbPalette[1]) + scale_y_continuous(expand = c(0.001, 0)) + scale_x_continuous(expand = c(0.001, 0)) +
  xlim(c(0, 12.5))+
  geom_vline(
    size = line_size,
    xintercept = c(median(D_104$generations)),
    linetype = "dashed",
    color = c(cbPalette[1])
  ) +coord_cartesian(clip = 'off')


p <-
  format(ks.test(D_104$generations, D_105$generations)$p.value,
         digits = 2)

g2 <-
  ggplot(D_105,
         aes(generations, colour = experiment, fill = experiment)) + geom_density(alpha =
                                                                                    all_alpha, size = all_size,adjust=adjust) + scale_fill_manual(values = c(cbPalette[2])) + scale_colour_manual(values =
                                                                                                                                                                                                    c(cbPalette[2])) + scale_y_continuous(expand = c(0.001, 0)) +
  scale_x_continuous(expand = c(0.001, 0)) + xlim(c(0, 12.5)) +
  geom_vline(
    size = line_size,
    xintercept = c(median(D_105$generations),median(D_104$generations)),
    linetype = "dashed",
    color = c(cbPalette[2],cbPalette[1])
  ) +coord_cartesian(clip = 'off') +
  annotate(
    geom = 'text',
    label = c(paste("  p =", p)),
    x = -Inf,
    y = Inf,
    hjust = 0,
    vjust = 1,
    parse = FALSE
  )



p <-
  format(ks.test(D_104$generations, D_106$generations)$p.value,
         digits = 2)

g3 <-
  ggplot(D_106,
         aes(generations, colour = experiment, fill = experiment)) + geom_density(alpha =
                                                                                    all_alpha, size = all_size,adjust=adjust) + scale_fill_manual(values = c(cbPalette[3])) + scale_colour_manual(values =
                                                                                                                                                                                                    c(cbPalette[3])) + scale_y_continuous(expand = c(0.001, 0)) +
  scale_x_continuous(expand = c(0.001, 0)) + xlim(c(0, 12.5)) +
  geom_vline(
    size = line_size,
    xintercept = c(median(D_106$generations),median(D_104$generations)),
    linetype = "dashed",
    color = c(cbPalette[3],cbPalette[1])
  ) + coord_cartesian(clip = 'off') +
  annotate(
    geom = 'text',
    label = c(paste("  p =", p)),
    x = -Inf,
    y = Inf,
    hjust = 0,
    vjust = 1,
    parse = FALSE
  )


p <-
  format(ks.test(D_104$generations, D_107$generations)$p.value,
         digits = 2)

g4 <-
  ggplot(D_107,
         aes(generations, colour = experiment, fill = experiment)) + geom_density(alpha =
                                                                                    all_alpha, size = all_size,adjust=adjust) + scale_fill_manual(values = c(cbPalette[4])) + scale_colour_manual(values =
                                                                                                                                                                                                    c(cbPalette[4])) + scale_y_continuous(expand = c(0.001, 0)) +
  scale_x_continuous(expand = c(0.001, 0)) + xlim(c(0, 12.5)) +
  geom_vline(
    size = line_size,
    xintercept = c(median(D_107$generations),median(D_104$generations)),
    linetype = "dashed",
    color = c(cbPalette[4],cbPalette[1])
  ) +coord_cartesian(clip = 'off') +
  annotate(
    geom = 'text',
    label = c(paste("  p =", p)),
    x = -Inf,
    y = Inf,
    hjust = 0,
    vjust = 1,
    parse = FALSE
  )



pp <-
  plot_grid(
    g1 + theme(legend.position =  c(0.8, 0.8),legend.title = element_blank()),
    g2 + theme(legend.position =  c(0.8, 0.8),legend.title = element_blank()),
    g3 + theme(legend.position =  c(0.8, 0.8),legend.title = element_blank()),
    g4 + theme(legend.position =  c(0.8, 0.8),legend.title = element_blank()),
    labels = c("A", "B", "C", "D"),
    align = 'vh',
    hjust = -1,
    nrow = 4
  )

ggplot2::ggsave(
  "C:/Users/User/Documents/Polio_data_104/generations_means.pdf",
  plot = pp,
  width = 12,
  height = 12,
  units = "in"
)
