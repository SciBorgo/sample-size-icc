

# 95% CI interpretation
# DN Borg
# February, 2021

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


#### 95% CI interpretation
# Load data
d <- read_xlsx('Confidence interval interpretation.xlsx') %>%
  clean_names()

# Variables
names(d)
head(d,10)

# Categories crossed based on paper criteria
d %>% group_by(categories_crossed_paper_criteria) %>%
  count()

table(d$criteria_used[d$criteria_used=='None stated'])
table(d$criteria_used[d$criteria_used=='NA - lower bound >0.9'])

# Summary:
# n=20 studies with 95%CI that crossed >1 category
# n=13 studies crossed 2 categories
# n=6 studies crossed 3 categories
# n=1 study crossed 4 categories
# n=11 studies with a 95% CI lower than 0.90 but did not report any interpretation criteria
# n=13 studies not looked at because the lower bound of the 95% CI was >0.90

# Categories crossed based on slight 0.11–0.40, fair 0.41–0.60, moderate 0.61–0.80, and substantial >0.80 reliability (https://doi.org/10.1177/096228029800700306)
d %>% group_by(categories_crossed_our_criteria) %>%
  count()

# Summary:
# n=21 studies with 95%CI that crossed >1 category
# n=14 studies crossed 2 categories
# n=6 studies crossed 3 categories
# n=1 study crossed 4 categories
# All 21 studies that crossed <1 category based this interpretation on the ICC point estimate rather than the lower bound



#### End