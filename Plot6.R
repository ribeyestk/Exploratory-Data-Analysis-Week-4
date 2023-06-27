## Load libraries
library(dplyr)
library(ggplot2)
library(stringr)

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

## Sub-setting data frames based on Vehicle Sources  
vehicleSCC <- filter(SCC, str_detect(SCC.Level.Two, "[Vv]ehicle"))
vehicleNEI <- filter(NEI, SCC %in% vehicleSCC$SCC)

balt_la <- vehicleNEI %>% filter(fips %in% c("24510", "06037"))

facet_labels <- as_labeller(c(`24510` = "Baltimore City", `06037` = "Los Angeles County"))

# Create the plot
g6 <- ggplot(balt_la, aes(factor(year), Emissions, fill = fips)) +
  geom_bar(stat = "identity") +
  theme_bw(base_family = "Times New Roman") +
  facet_grid(. ~ fips, labeller = facet_labels) +
  labs(x = "Years", y = "Total emissions", 
       title = "Motor Vehicle Emissions between Baltimore & LA County from 1999 to 2008") +
        scale_fill_manual(values = c("red", "blue"))

# Save the plot to a file
ggsave("plot6.png", plot = g6, width = 30, height = 30, units = "cm")

dev.off()