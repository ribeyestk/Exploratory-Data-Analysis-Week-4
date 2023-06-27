library(dplyr)

## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Tidying the Data 
total <- NEI %>% select(Emissions, year) %>%
  group_by(year) %>%
  mutate(year = factor(year)) %>%
  summarize(total_em = sum(Emissions))

png(filename = "plot1.png")

# create bar plot with base R
with(
  total,
  barplot(
    total_em,
    names = year,
    xlab = "Years",
    ylab = "Emissions",
    main = "Emissions over the years"
  )
)


dev.off()