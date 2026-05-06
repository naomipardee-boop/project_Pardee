# ============================================================
# File: Scripts/04_merge_data.R
# Purpose:
# Merge cleaned arrest and Census datasets.
# Calculate arrest rates per 100,000 people.
# Save merged analysis dataset.
# ============================================================

# Run setup script
source("Scripts/01_setup.R")

# Load cleaned datasets
load("data_clean/census_clean.Rdata")
load("data_clean/arrests_clean.Rdata")

# Merge arrest and population data
analysis_data <- arrests_clean |>
  
  # Merge by county name
  inner_join(census_clean, by = "county") |>
  
  # Calculate arrest rate per 100,000 people
  mutate(
    arrest_rate_per_100k =
      (total_arrests / population) * 100000
  )

# Inspect merged dataset
head(analysis_data)

# Summary of arrest rates
summary(analysis_data$arrest_rate_per_100k)

# Create top counties table
top_counties <- analysis_data |>
  arrange(desc(arrest_rate_per_100k)) |>
  select(
    county,
    total_arrests,
    population,
    arrest_rate_per_100k
  ) |>
  slice_head(n = 10)

# Save merged analysis dataset
save(
  analysis_data,
  file = "data_clean/analysis_data.Rdata"
)

# Save top counties table
save(
  top_counties,
  file = "data_clean/top_counties.Rdata"
)