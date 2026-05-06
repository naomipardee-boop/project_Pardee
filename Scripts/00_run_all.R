# ============================================================
# File: Scripts/00_run_all.R
# Purpose:
# Run all project scripts in order.
# ============================================================

# 01. Clean Census data
source("Scripts/02_clean_census.R")

# 02. Clean arrest data
source("Scripts/03_clean_arrests.R")

# 03. Merge datasets
source("Scripts/04_merge_data.R")

# 04. Create visualizations
source("Scripts/05_visualizations.R")

# 05. Run regression analysis
source("Scripts/06_regression.R")

# 06. Create county map
source("Scripts/07_mapping.R")

# Complete spatial visualization challenge
source("Scripts/07_mapping+challenge.R")
list.files("data_clean")
list.files("Images")


