# ============================================================
# File: Scripts/07_mapping.R
# Purpose:
# Create California county arrest rate map.
# Save map figure and map objects.
#install.packages(c(
  #   "tidyverse",
  #   "readxl",
  #   "janitor",
  #   "maps",
  #   "plotly",
  #   "htmlwidgets"
  # ))
# ============================================================

# Run setup script
source("Scripts/01_setup.R")
load("data_clean/analysis_data.Rdata")


# Load merged analysis dataset
load("data_clean/analysis_data.Rdata")

# Get California county map data
ca_map <- map_data("county") |>
  
  # Keep only California counties
  filter(region == "california") |>
  
  # Standardize county names
  mutate(
    county = str_to_title(subregion)
  )

# Merge map data with arrest data
map_data_joined <- ca_map |>
  inner_join(analysis_data, by = "county")

# Create county static map
map_plot <- ggplot(map_data_joined, aes(
  x = long,
  y = lat,
  group = group,
  fill = arrest_rate_per_100k
)) +
  geom_polygon(
    color = "white",
    linewidth = 0.2
  ) +
  coord_fixed(1.3) +
  scale_fill_viridis_c() +
  labs(
    title =
      "Arrest Rates per 100,000 by California County",
    x = "",
    y = "",
    fill = "Arrest Rate"
  )

# Print the map
print(map_plot)

# Save map figure
ggsave(
  "Images/arrest_rate_map.png",
  map_plot,
  width = 8,
  height = 6
)

# Save map objects
save(
  map_data_joined,
  map_plot,
  file = "data_clean/map_outputs.Rdata"
)


# Run setup script
source("Scripts/01_setup.R")

# Load cleaned merged analysis data
load("data_clean/analysis_data.Rdata")

# Get California county map data
ca_map <- map_data("county") |>
  filter(region == "california") |>
  mutate(
    county = str_to_title(subregion)
  )

# Join map data with arrest rate data
map_data_joined <- ca_map |>
  inner_join(analysis_data, by = "county")

# Create county-level arrest rate map
map_plot <- ggplot(map_data_joined, aes(
  x = long,
  y = lat,
  group = group,
  fill = arrest_rate_per_100k
)) +
  geom_polygon(
    color = "white",
    linewidth = 0.2
  ) +
  coord_fixed(1.3) +
  scale_fill_viridis_c() +
  labs(
    title = "Arrest Rates per 100,000 by California County",
    x = "",
    y = "",
    fill = "Arrest Rate"
  )

# Print map to Plots pane
print(map_plot)

# Save map to Images folder
ggsave(
  filename = "Images/arrest_rate_map.png",
  plot = map_plot,
  width = 8,
  height = 6
)

# Save map data and map object
save(
  map_data_joined,
  map_plot,
  file = "data_clean/challenge_map_outputs.Rdata"
)

# Show saved image files
list.files("Images")

# ============================================================
# Interactive map challenge using plotly
# ============================================================


# Convert static ggplot map into interactive map
interactive_map <- ggplotly(map_plot)

# Print interactive map in Viewer pane
print(interactive_map)

# Save interactive map as standalone HTML file
saveWidget(
  interactive_map,
  "Images/interactive_arrest_rate_map.html"
)

# Check saved files in Images folder
list.files("Images")