# ============================================================
# File: Scripts/01_setup.R
# Purpose:
# Load required packages and create output folders.
# ============================================================

# Load required packages
library(tidyverse)
library(readxl)
library(janitor)
library(maps)

# Create folder for saved figures
dir.create("Images", showWarnings = FALSE)

# Create folder for cleaned data
dir.create("data_clean", showWarnings = FALSE)