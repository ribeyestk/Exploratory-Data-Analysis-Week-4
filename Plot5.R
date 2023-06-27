library(dplyr)
library(ggplot2)
library(stringr)

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

##Filtering for word vehicle and where SCC column matches SCC value in vehicleSCC
vehicleSCC <- filter(SCC, str_detect(SCC.Level.Two, "[Vv]ehicle"))
vehicleNEI <- filter(NEI, SCC %in% vehicleSCC$SCC)

balt_vehicleNEI <- filter(vehicleNEI, fips=="24510")

# Create the plot
g5 <- ggplot(balt_vehicleNEI, aes(factor(year), Emissions)) +
  geom_bar(stat="identity", fill = "yellow") +
  theme_bw(base_family = "Times New Roman") +
  labs(x="Years", y="Total emissions", 
       title="Motor Vehicle Sources Emissions in Baltimore from 1999 to 2008")

# Save the plot to a file
ggsave("plot5.png", plot = g5, width = 30, height = 30, units = "cm")

dev.off()