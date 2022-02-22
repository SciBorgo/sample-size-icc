

# Borg et al (2018) reanalysis
# Borg DN
# December, 2021

# Packages
library(dplyr)
library(psych)


# Runners 10 km performance time
# Data
id <- c(1,2,3,4,5)
t1 <- c(1059.73, 1065.99, 1116.66, 1105.69, 1188.53)
t2 <- c(1025.94, 1046.37, 1082.19, 1064.83, 1153.91)
t3 <- c(1017.68, 1048.38, 1071.90, 1097.89, 1157.89)
t4 <- c(1028.33, 1024.91, 1076.06, 1058.31, 1156.93)

d <- cbind(id,t1,t2,t3,t4) %>% as_tibble()
d

# Calculate CIs
icc <- ICC({d %>% select(-id)}, alpha = .05)
icc

