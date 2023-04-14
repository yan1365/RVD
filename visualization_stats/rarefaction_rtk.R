install.packages('rtk', repos = "http://cran.us.r-project.org")
library(rtk)

data <- read.csv('../abundance_table_raw.tsv', sep = '\t')[,2:976]
print(1)
data.r <- rtk(data, ReturnMatrix = 1, depth = min(colSums(data)))
# collectors curve on dataframe/matrix
svg("~/rtk.svg", width = 3, height = 3)
par(mar = c(2, 2, 0.5, 1))

collectors.curve(data, xlab = "", ylab = "", bin = 1, fit = "michaelis-menten", cex.axis=0.8, col = 'black')


dev.off() 


