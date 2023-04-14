#!/usr/bin/env Rscript
 
setwd("/fs/scratch/PAS0439/Ming/virome_ecology_core_prkaryotes/results/R_project")

library(tidyverse)
library(vegan)
library(ggpubr)
library(rstatix)
library(phyloseq)
library(ape)
library(pairwiseAdonis)
library(data.table)
library(gggenes)
library(gghighlight)
library(cowplot)
library(gridExtra) 

 
table_beta_ecology <- fread("for_beta_diversity_ecology.csv")
metadata_eco <- read_csv("metadata_ecology.csv")


retained_species <- metadata_eco %>% group_by(species) %>% summarise(n  = n()) %>% filter(n > 80) %>% select(species) %>% unlist()
retained_geography <- metadata_eco %>% group_by(geography) %>% summarise(n  = n()) %>% filter(n > 80) %>% select(geography) %>% unlist()
retained_id <- metadata_eco %>% filter(species %in% retained_species) %>% filter(geography %in% retained_geography) %>% select(id) %>% unlist()
table_beta_ecology_ready <- table_beta_ecology %>% filter(index %in% retained_id) 
metadata_eco_ready <- metadata_eco %>% filter(id %in% retained_id)

bray <- vegdist(table_beta_ecology_ready[, -"index"], method = "bray")
PCOA <- pcoa(bray, correction = "cailliez")
PCOA
PCOA_tmp <- as.data.frame(PCOA$vectors[, c(1,2)])
rownames(PCOA_tmp) <- retained_id
PCOA_tmp$x_explained <-  round(PCOA$values$Cum_corr_eig[1]*100, 2)
PCOA_tmp$y_explained <-  round((PCOA$values$Cum_corr_eig[2] - PCOA$values$Cum_corr_eig[1])*100, 2)

round(variance_explained[variance_explained$liter==literature,"x"]*100, 2)

permanova_tmp <-  data.frame(matrix(ncol = 6, nrow = 1))
colnames(permanova_tmp) <- c("p_species","p_geo","p_project","r2_species","r2_geo","r2_project")
beta_res <- adonis2(bray ~ metadata_eco_ready$species + metadata_eco_ready$geography + metadata_eco_ready$project)

beta_res

permanova_tmp$p_species <- beta_res$`Pr(>F)`[1] 
permanova_tmp$p_geo <- beta_res$`Pr(>F)`[2]
permanova_tmp$p_project <- beta_res$`Pr(>F)`[3] 
permanova_tmp$r2_species <- beta_res$`R2`[1]
permanova_tmp$r2_geo <- beta_res$`R2`[2] 
permanova_tmp$r2_project <- beta_res$`R2`[3] 

write.csv(PCOA_tmp, "pcoa_species.csv") 
write.csv(permanova_tmp, "permanova_ecology.csv")