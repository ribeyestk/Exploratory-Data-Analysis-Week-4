library(dplyr)
library(ggplot2)
library(stringr)

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

##Filtering for rows with word coml
SCC_Coal_Combustian <- SCC %>%
  filter(str_detect(SCC.Level.One, "[Cc]omb")) %>%
  filter(str_detect(SCC.Level.Three, "[Cc]oal")) %>%
  filter(str_detect(SCC.Level.Four, "[Cc]oal"))

NEI_coal_comb <- filter(NEI, SCC %in% SCC_Coal_Combustian$SCC)

##Creating the Plot
g4 <- ggplot(NEI_coal_comb, aes(factor(year), Emissions)) +
  geom_bar(stat = "identity", fill = "blue") +
  theme_bw(base_family = "Helvetica") +
  labs(x = "Years", y = "Total Emissions", 
       title = "Coal Combustion Source emissions across US from 1999 to 2008")

# Save the plot
ggsave("plot4.png", plot = g4, width = 30, height = 30, units = "cm")

dev.off()