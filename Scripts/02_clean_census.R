# ============================================================
# File: Scripts/02_clean_census.R
# Purpose:
# Read and clean Census population data.
# Save cleaned Census dataset as an .Rdata object.
# ============================================================

# Run setup script
source("Scripts/01_setup.R")

# Read Census CSV data
census <- read_csv(
  "data_raw/ACSDP5Y2022.DP05-2026-05-04T185629.csv"
) |>
  clean_names()

# Inspect row labels to identify population row
head(census$label_grouping)

# Clean Census data
# The dataset is originally wide, so reshape into long format
census_clean <- census |>
  
  # Remove extra spaces from labels
  mutate(
    label_grouping = str_trim(label_grouping)
  ) |>
  
  # Keep only total population row
  filter(label_grouping == "Total population") |>
  
  # Keep county estimate columns
  select(label_grouping, ends_with("_estimate")) |>
  
  # Convert counties from columns into rows
  pivot_longer(
    cols = -label_grouping,
    names_to = "county",
    values_to = "population"
  ) |>
  
  # Clean county names and population values
  mutate(
    county = str_remove(
      county,
      "_county_california_estimate"
    ),
    county = str_replace_all(county, "_", " "),
    county = str_to_title(county),
    population = parse_number(
      as.character(population)
    )
  ) |>
  
  # Keep only needed variables
  select(county, population)

# Inspect cleaned data
head(census_clean)

# Save cleaned Census dataset
save(
  census_clean,
  file = "data_clean/census_clean.Rdata"
)