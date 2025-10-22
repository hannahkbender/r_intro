# Description

# Author: Hannah
# Version: 2025-10-31

# Clear environment
rm(list = ls())

# Clean console
cat("\014")

# Packages
library(janitor)
library(glue)
library(tidyverse)

# Set directories
project <- "~/econ_phd/code/projects/r_intro/data"
import <- glue("{project}/import")
build <- glue("{project}/build")
export <- glue("{project}/export")

# =======================================================
# Intro to R Practice Program: Iris Dataset
# =======================================================

# 1. Basic exploration
head(iris)          # first few rows
summary(iris)       # summary statistics

# 2. Mild cleaning and new var
iris_clean <- iris %>% 
  clean_names() %>% 
  mutate(sepal_ratio = sepal_length/sepal_width)

# 3. Descriptive statistics 
summary_stats <- iris_clean %>%
  group_by(species) %>%
  summarize(
    mean_length = mean(sepal_length),
    mean_width  = mean(sepal_width),
    sd_length   = sd(sepal_length),
    sd_width    = sd(sepal_length),
    count = n()
    )

# 4. Plot with ggplot2
plot <- ggplot(iris_clean, aes(x = sepal_length, y = petal_length, color = species)) +
  geom_point(size = 2) +
  labs(
    title = "Iris: Sepal vs Petal Length",
    x = "Sepal Length (cm)",
    y = "Petal Length (cm)"
  ) +
  theme_minimal()

plot

# 5. Save processed data
write.csv(iris_clean, file.path(build, "iris_with_ratio.csv"), row.names = FALSE)

# 6. Save summary stats and plot
write_excel_csv(summary_stats, file.path(export, "summary_stats.xlsx")) # object then path
ggsave(file.path(export, "sepal_v_petal_length_plot.png"), plot)        # path then object



