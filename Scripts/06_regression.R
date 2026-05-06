# ============================================================
# File: Scripts/06_regression.R
# Purpose:
# Estimate regression model relating population
# to arrest rates per 100,000 people.
# Save regression output as an image.
# ============================================================

# Run setup script
source("Scripts/01_setup.R")

# Load merged analysis dataset
load("data_clean/analysis_data.Rdata")

# ------------------------------------------------------------
# Estimate regression model
# ------------------------------------------------------------

model <- lm(
  arrest_rate_per_100k ~ population,
  data = analysis_data
)

# Print regression output
print(model)

# Display regression results in console
summary(model)

# Save regression model object
save(
  model,
  file = "data_clean/regression_model.Rdata"
)

# ------------------------------------------------------------
# Save regression output as image
# ------------------------------------------------------------

png("Images/regression_results.png", width = 800, height = 600)

# Print regression summary into the image
plot.new()
text(
  x = 0,
  y = 1,
  paste(
    capture.output(summary(model)), 
    collapse = "\n"),
  adj = c(0, 1),
  family = "mono",
  cex = 0.8
)

dev.off()
