

# ICC paper: Sample size calc
# DN Borg
# Feb, 2022

# Packages
library(ICC.Sample.Size)
library(ggplot2)
library(dplyr)
library(janitor)

# Sample size calculation; null icc = 0.6
data_list <- list(0.85,0.9,0.95)

results_list <- list()

for(i in 1:length(data_list)){
  
  # calculation
  new_model <- calculateIccSampleSize(p = data_list[[i]], p0 = 0.80, k = 4, alpha = 0.05, tails = 2, power = seq(0.05, 0.95, by = 0.001)) %>%
    as.data.frame() %>%
    group_by(N) %>%
    filter(power == min(power)) %>%
    ungroup()
  # save results to list
  results_list <- c(results_list, list(new_model))
}

# Pull results
d_pwr <- rbind(results_list[[1]], results_list[[2]], results_list[[3]]) %>%
  mutate(ICC = as.factor(p),
         ICC = recode_factor(ICC, '0.85'='0.85', '0.9'='0.90', '0.9'='0.95'))


d_pwr %>% ggplot() +
  geom_line(aes(x = N, y = power*100, group = ICC, colour = ICC), size = 0.75) +
  scale_y_continuous(limits = c(0,100), n.breaks = 10, expand = c(0,0)) +
  scale_x_continuous(n.breaks = 10) +
  geom_hline(yintercept = 80, size = 0.35, colour = 'grey60', linetype = "longdash") +
  geom_hline(yintercept = 90, size = 0.35, colour = 'grey60', linetype = "longdash") +
  labs(x = 'Sample size', y = 'Power (%)') +
  theme(legend.position = 'bottom') +
  theme_classic(base_size = 10) +
  scale_colour_brewer(palette = 'Dark2') -> p

p + theme(legend.position = c(0.85, 0.3)) -> p1
p1

ggsave(file = "Figure1.pdf", units="in", width = 4.5, height = 3, dpi = 600)
ggsave(file = "Figure1.tiff", units="in", width = 4, height = 2.75, dpi = 600, compression = 'lzw')

# Value check
d_pwr %>% mutate(id = row_number()) %>%
  clean_names() %>%
  slice(190,372,255,375) %>%
  mutate(power = round(power, digits = 1)) %>%
  arrange(power, n)

#### End
