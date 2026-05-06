# ============================================================
# File: Scripts/05_visualizations.R
# Purpose:
# Create and save project visualizations.
# ============================================================

# Run setup script
source("Scripts/01_setup.R")

# Load merged analysis dataset
load("data_clean/analysis_data.Rdata")

# ------------------------------------------------------------
# Figure 1:
# Top 10 California counties by arrest rate
# ------------------------------------------------------------

# Select top 10 counties
top_10 <- analysis_data |>
  arrange(desc(arrest_rate_per_100k)) |>
  slice_head(n = 10)

# Create bar chart
plot1 <- ggplot(top_10, aes(
  x = reorder(county, arrest_rate_per_100k),
  y = arrest_rate_per_100k
)) +
  geom_col() +
  coord_flip() +
  labs(
    title = "Top 10 California Counties by Arrest Rate",
    x = "County",
    y = "Arrests per 100,000 People"
  )


# Print the visualization
print(plot1)

# Save figure
ggsave(
  "Images/top_10_arrest_rates.png",
  plot1,
  width = 8,
  height = 5
)

# ------------------------------------------------------------
# Figure 2:
# Population vs total arrests
# ------------------------------------------------------------

plot2 <- ggplot(analysis_data, aes(
  x = population,
  y = total_arrests
)) +
  geom_point() +
  geom_smooth(method = "lm", se = FALSE) +
  labs(
    title = "Population vs Total Arrests",
    x = "Population",
    y = "Total Arrests"
  )

# Print figure 2
print(plot2)


# Save figure
ggsave(
  "Images/population_vs_total_arrests.png",
  plot2,
  width = 8,
  height = 5
)

# ------------------------------------------------------------
# Figure 3:
# Population vs arrest rate
# ------------------------------------------------------------

plot3 <- ggplot(analysis_data, aes(
  x = population,
  y = arrest_rate_per_100k
)) +
  geom_point() +
  geom_smooth(method = "lm", se = FALSE) +
  labs(
    title =
      "Population vs Arrest Rate Across California Counties",
    x = "County Population",
    y = "Arrests per 100,000 People"
  )

# Print plot3
print(plot3)

# Save figure
ggsave(
  "Images/population_vs_arrest_rate.png",
  plot3,
  width = 8,
  height = 5
)

