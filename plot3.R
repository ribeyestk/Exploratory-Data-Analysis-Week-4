library(dplyr)
library(ggplot2)

NEI <- readRDS("summarySCC_PM25.rds")

Baltimore_Type <- NEI %>% select(type, fips, Emissions, year) %>%
  filter(fips == '24510')

## Bar plot depicting total emissions by year and source in Baltimore
g3 <- ggplot(Baltimore_Type, aes(factor(year), Emissions, fill = type)) +
  geom_bar(stat = "identity") +
  theme_bw(base_family = "Times New Roman") +
  facet_grid(.~type, scales = "free", space = "free") +
  labs(x = "Years",
       y = "Total Emissions",
       title = "Total Emissions in Baltimore City by Source types") +
  scale_fill_manual(values = c("red", "blue", "green", "orange"))

# Save the plot
ggsave(filename = "plot3.png", plot = g3, width = 30, height = 30, units = "cm")

dev.off() 
