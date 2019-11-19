library(tidyverse)
library(lubridate)
library(here)

so_spatial_all <- read_csv(here("raw", "spat_diet_SO.csv"),
                       guess_max = 20000)
        
so_spatial <- so_spatial_all %>% 
  mutate(kingdom = "Animalia", 
         length.corr = NA,
         sample.int = NA) %>% 
  select(ufn, sample.int, dry.content.w, wet.content.w, corrected.ww, 
         fullness.cat, fullness.mean, fullness.est, kingdom, phylum, 
         class, order, infraorder, family, genus, species_1, plot.taxon.g, plot.taxon.d,
         plot.taxon, life.stage, sex, DI, count, size, length.min, length.max,
         length.avg, length.corr, group.weight, corrected.weight, comment) %>% 
        mutate(fullness.est = as.numeric(fullness.est),
               corrected.weight = as.numeric(corrected.weight))


so_temporal_all <- read_csv(here("raw", "temp_diet_SO.csv"), guess_max = 20000)

so_temporal <- so_temporal_all %>% 
        mutate(kingdom = "Animalia") %>%
  select(ufn, sample.int, dry.content.w, wet.content.w, corrected.ww, fullness.cat,
         fullness.mean, fullness.est, kingdom, phylum, class, order, infraorder, family,
         genus, species_1, plot.taxon.g, plot.taxon.d, plot.taxon, life.stage, sex,
         DI, count, size, length.min, length.max, length.avg, length.corr, group.weight,
         corrected.weight, comment)
 
rm(so_temporal_all, so_spatial_all)

sockeye_diets <- bind_rows(so_spatial, so_temporal)

write_csv(sockeye_diets, here("processed", "tidy_raw_sockeye_diets_for_jsp.csv"))
