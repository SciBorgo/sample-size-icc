

# Search results
# DN Borg
# November, 2021

# Packages
library(readxl)
library(dplyr)
library(ggplot2)
library(janitor)
library(tidyr)
library(binom)
library(stringr)
library(irr)

# Set WD
setwd("~/Dropbox/Research projects/Review - ICC Paper")


#### Agreement between reviewers
# Load data
d <- read_xlsx('Reliability search_12-02-22.xlsx') %>%
  clean_names() %>%
  filter(included_in_review == '1') %>%
  select(included_r1,
         included_r2)

# Check agreement
d$agree = d$included_r1-d$included_r2

N <- as.numeric(nrow(d))
tab = table(d$agree)
tab

tab[[2]]/N




#### Main text analysis
# Load data
d <- read_xlsx('Reliability search_12-02-22.xlsx') %>%
  clean_names() %>%
  mutate(sample_size = as.numeric(sample_size_final),
         study_id = pdf_number_db,
         icc = mean_icc_final)

# Rows
nrow(d)

# Sample size
d %>% filter(sample_size < 100) %>%
  ggplot() +
  geom_histogram(aes(x = sample_size), colour = 'white') +
  theme_bw()

summary(d$sample_size, digits = 2)

# Number of trials
d %>% ggplot() +
  geom_histogram(aes(x = as.integer(number_of_trials_final)), colour = 'white') +
  theme_bw()

tab <- table(d$number_of_trials_final)
tab
N <- as.numeric(nrow(d))

binom.confint(x = tab[[2]],
              n = N,
              conf.level = 0.95,
              methods = 'exact') %>%
  as_tibble() # 2 trials

# Sample size calculations
d_samp <- d %>% filter(icc_sample_size_final == 'TRUE')
samp <- as.numeric(nrow(d_samp))
N <- as.numeric(nrow(d))

binom.confint(x = samp,
              n = N,
              conf.level = 0.95,
              methods = 'exact') %>%
  as_tibble()

# Confidence interval reporting
N <- as.numeric(nrow(d))
tab <- table(d$ci_level_final)
tab

binom.confint(x = (tab[[1]] + tab[[2]]),
              n = N,
              conf.level = 0.95,
              methods = 'exact') %>%
  as_tibble()

# Reporting of p-values
d_pval <- d %>% filter(!p_value_final == 'FALSE')
d_pval

d_pval %>% select(study_id,
                  p_value_final,
                  ci_level_final)

pval <- as.numeric(nrow(d_pval))
N <- as.numeric(nrow(d))

binom.confint(x = pval,
              n = N,
              conf.level = 0.95,
              methods = "exact") %>%
  as_tibble()



# Confidence intervals descriptive
table(d$ci_level_final)
d_95ci <- d %>% filter(ci_level_final == '0.95') %>%
  mutate(lower_ci = as.numeric(lower_ci_final),
         upper_ci = as.numeric(upper_ci_final),
         ci_width = upper_ci-lower_ci)

summary(d_95ci$lower_ci, digits = 2) # Lower bound
summary(d_95ci$upper_ci, digits = 2) # Upper bound
summary(d_95ci$ci_width, digits = 2) # Width

# Confidence interval plot
d_95ci %>%
  mutate(id = 1:nrow(d_95ci)) %>%
  filter(lower_ci < 0.8) %>%
  ggplot() +
  geom_linerange(aes(y = reorder(id, lower_ci), xmin = lower_ci, xmax = upper_ci)) +
  theme_bw(base_size = 8) +
  geom_vline(aes(xintercept = 0.8), colour = 'red', size = 0.35) +
  geom_vline(aes(xintercept = 0.6), colour = 'orange', size = 0.35) +
  geom_vline(aes(xintercept = 0.4), colour = 'pink', size = 0.35) +
  scale_y_discrete(labels = d_95ci$conclusion_final) +
  theme_classic()

# Median sample size and ICC of studies that reports CIs
d_ci = d %>% filter(ci_level_final %in% c(0.9,0.95))
summary(d_ci$sample_size, digits = 2)
summary(d_ci$icc, digits = 2)

# Median sample size and ICC of studies that did not report CIs
d_no_ci = d %>% filter(!ci_level_final %in% c(0.9,0.95))
summary(d_no_ci$sample_size, digits = 2)
summary(d_no_ci$icc, digits = 2)



# P-value descriptives
d_pval <- d %>% filter(!p_value_final == 'FALSE') %>%
  mutate(lower_ci = as.numeric(lower_ci_final),
         upper_ci = as.numeric(upper_ci_final),
         conclusion = conclusion_final)

d_pval %>% select(study_id,
                  p_value_final,
                  icc,
                  lower_ci_final,
                  upper_ci_final,
                  conclusion_final)

d_pval %>%
  mutate(id = 1:nrow(d_pval)) %>%
  ggplot() +
  geom_linerange(aes(y = reorder(id, lower_ci), xmin = lower_ci, xmax = upper_ci)) +
  theme_bw(base_size = 8) +
  geom_vline(aes(xintercept = 0.8), colour = 'red', size = 0.35) +
  geom_vline(aes(xintercept = 0.6), colour = 'orange', size = 0.35) +
  geom_vline(aes(xintercept = 0.4), colour = 'pink', size = 0.35) +
  scale_y_discrete(labels = d_pval$conclusion) +
  labs(x = 'icc value') +
  theme_classic()



#### End
