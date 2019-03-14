#Title:
#Description:
#Inputs:
#Outputs:

library(jpeg)
library(grid)
library(ggplot2)
library(dplyr)

col_types <- c("integer", "character", "character", "integer", "integer", "integer", "integer", "character", "factor", "factor", "integer", "character",
               "integer", "integer", "character", "integer")
shots_data <- read.csv("C:/Berkeley/Spring19/stat133/workout01/data/shots-data.csv", colClasses = col_types)
court_file <- "C:/Berkeley/Spring19/stat133/workout01/images/nba-court.jpg"
court_image <- rasterGrob(readJPEG(court_file), width = unit(1, "npc"), height = unit(1, "npc"))

#Shot chart of Andre Iguodala 
andre <- filter(shots_data, name == "Andre Iguodala")
andre_shot_chart <- ggplot(data = andre) +
  annotation_custom(court_image, -250, 250, -50, 420) +
  geom_point(aes(x = x, y = y, color = shot_made_flag)) +
  ylim(-50, 420) +
  ggtitle('Shot Chart: Andre Iguodala (2016 season)') +
  theme_minimal()
andre_shot_chart

#Shot chart of Draymond Green 
draymond <- filter(shots_data, name == "Draymond Green")
draymond_shot_chart <- ggplot(data = draymond) +
  annotation_custom(court_image, -250, 250, -50, 420) +
  geom_point(aes(x = x, y = y, color = shot_made_flag)) +
  ylim(-50, 420) +
  ggtitle('Shot Chart: Draymond Green (2016 season)') +
  theme_minimal()
draymond_shot_chart

#Shot chart of Kevin Durant
kevin <- filter(shots_data, name == "Kevin Durant")
kevin_shot_chart <- ggplot(data = kevin) +
  annotation_custom(court_image, -250, 250, -50, 420) +
  geom_point(aes(x = x, y = y, color = shot_made_flag)) +
  ylim(-50, 420) +
  ggtitle('Shot Chart: Kevin Durant (2016 season)') +
  theme_minimal()
kevin_shot_chart

#Shot chart of Klay Thompson
klay <- filter(shots_data, name == "Klay Thompson")
klay_shot_chart <- ggplot(data = klay) +
  annotation_custom(court_image, -250, 250, -50, 420) +
  geom_point(aes(x = x, y = y, color = shot_made_flag)) +
  ylim(-50, 420) +
  ggtitle('Shot Chart: Klay Thompson (2016 season)') +
  theme_minimal()
klay_shot_chart

#Shot chart of Stephen Curry
stephen <- filter(shots_data, name == "Stephen Curry")
stephen_shot_chart <- ggplot(data = stephen) +
  annotation_custom(court_image, -250, 250, -50, 420) +
  geom_point(aes(x = x, y = y, color = shot_made_flag)) +
  ylim(-50, 420) +
  ggtitle('Shot Chart: Stephen Curry (2016 season)') +
  theme_minimal()
stephen_shot_chart

#Shot charts of GSW
shot_charts <- ggplot(data = shots_data) +
  annotation_custom(court_image, -250, 250, -50, 420) +
  geom_point(aes(x = x, y = y, color = shot_made_flag)) +
  ylim(-50, 420) +
  facet_wrap(~name)+
  ggtitle('Shot Chart: GSW (2016 season)')+
  theme_minimal()
shot_charts
