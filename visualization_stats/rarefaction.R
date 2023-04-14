library(vegan)
library(tidyverse)
df <- read.csv('../abundance_table_raw.tsv', sep = '\t')
df2 <- mutate_all(df, function(x) as.integer(as.character(x)))

sp1 <- specaccum(df2, 'rarefaction')

svg("~/votu_rarefaction.svg", width = 3, height = 3)
plot(sp1, ci.type="poly", col="blue", lwd=2, ci.lty=0, ci.col="lightblue",  xlab = "Number of metagenomes", ylab = "Species vOTUs", cex.lab = 1, cex.axis = 1)
dev.off() 
