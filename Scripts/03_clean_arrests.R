# ============================================================
# File: Scripts/03_clean_arrests.R
# Purpose:
# Read and clean California arrest data.
# Aggregate arrests to county level.
# Save cleaned arrest dataset as an .Rdata object.
# ============================================================

# Run setup script
source("Scripts/01_setup.R")

# Read arrest Excel dataset
arrests <- read_excel(
  "data_raw/raw_OnlineArrestData1980-2024.xlsx"
)

# Clean arrest data
arrests_clean <- arrests |>
  
  # Standardize variable names
  clean_names() |>
  
  # Clean county names and create total arrests
  mutate(
    county = str_remove(county, " County"),
    county = str_to_title(county),
    
    # Combine felony, misdemeanor, and status totals
    total_arrests = f_total + m_total + s_total
  ) |>
  
  # Aggregate arrests to county level
  group_by(county) |>
  summarise(
    total_arrests = sum(
      total_arrests,
      na.rm = TRUE
    ),
    .groups = "drop"
  )

# Inspect cleaned arrest data
head(arrests_clean)

# Save cleaned arrest dataset
save(
  arrests_clean,
  file = "data_clean/arrests_clean.Rdata"
)