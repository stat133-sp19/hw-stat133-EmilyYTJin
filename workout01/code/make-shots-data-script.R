#Title: The Script of Data Prepartion of shots_data.csv
#Description: the modification of several data files and the combination of all data 
#inputs: andre-iguodala.csv, draymond-green.csv, kevin-durant.csv, klay-thompson.csv, stephen-curry.csv
#outputs: andre-iguodala-summary.txt, draymond-green-summary.txt, kevin-durant-summary.txt, klay-thompson-summary.txt, stephan-curry-summary.txt, shots-data-summary.txt, shots-data.csv 

library(dplyr)
col_types <- c("character", "character", "integer", "integer", "integer", "integer", "character", "factor", "factor", "integer", "character",
               "integer", "integer")

#Data preparation for Andre Iguodala
iguodala <- read.csv("C:/Berkeley/Spring19/stat133/workout01/data/andre-iguodala.csv", colClasses = col_types)
iguodala <- mutate(iguodala, name = "Andre Iguodala")
iguodala$shot_made_flag[iguodala$shot_made_flag == "n"] <- "shot_no"
iguodala$shot_made_flag[iguodala$shot_made_flag == "y"] <- "shot_yes"
iguodala <- mutate(iguodala, minute = 12 * period - minutes_remaining)
sink("C:/Berkeley/Spring19/stat133/workout01/output/andre-iguodala-summary.txt")
summary(iguodala)
sink()

#Data preparation for Draymond Green
green <- read.csv("C:/Berkeley/Spring19/stat133/o/data/draymond-green.csv", colClasses = col_types)
green <- mutate(green, name = "Draymond Green")
green$shot_made_flag[green$shot_made_flag == "n"] <- "shot_no"
green$shot_made_flag[green$shot_made_flag == "y"] <- "shot_yes"
green <- mutate(green, minute = 12 * period - minutes_remaining)
sink("C:/Berkeley/Spring19/stat133/workout01/output/draymond-green-summary.txt")
summary(green)
sink()

#Data preparation for Kevin Durant
durant <- read.csv("C:/Berkeley/Spring19/stat133/workout01/data/kevin-durant.csv", colClasses = col_types)
durant <- mutate(durant, name = "Kevin Durant")
durant$shot_made_flag[durant$shot_made_flag == "n"] <- "shot_no"
durant$shot_made_flag[durant$shot_made_flag == "y"] <- "shot_yes"
durant <- mutate(durant, minute = 12 * period - minutes_remaining)
sink("C:/Berkeley/Spring19/stat133/workout01/output/kevin-durant-summary.txt")
summary(durant)
sink()

#Data preparation for Klay Thompson
thompson <- read.csv("C:/Berkeley/Spring19/stat133/workout01/data/klay-thompson.csv", colClasses = col_types)
thompson <- mutate(thompson, name = "Klay Thompson")
thompson$shot_made_flag[thompson$shot_made_flag == "n"] <- "shot_no"
thompson$shot_made_flag[thompson$shot_made_flag == "y"] <- "shot_yes"
thompson <- mutate(thompson, minute = 12 * period - minutes_remaining)
sink("C:/Berkeley/Spring19/stat133/workout01/output/klay-thompson-summary.txt")
summary(thompson)
sink()

#Data preparation for Stephen Curry
curry <- read.csv("C:/Berkeley/Spring19/stat133/workout01/data/stephen-curry.csv", colClasses = col_types)
curry <- mutate(curry, name = "Stephen Curry")
curry$shot_made_flag[curry$shot_made_flag == "n"] <- "shot_no"
curry$shot_made_flag[curry$shot_made_flag == "y"] <- "shot_yes"
curry <- mutate(curry, minute = 12 * period - minutes_remaining)
sink("C:/Berkeley/Spring19/stat133/workout01/output/stephan-curry-summary.txt")
summary(curry)
sink()

#Combination of all the tables 
shots_data <- rbind(iguodala, green, durant, thompson, curry)
sink("C:/Berkeley/Spring19/stat133/workout01/output/shots-data-summary.txt")
summary(shots_data)
sink()

#Export the data
write.csv(shots_data, file = "C:/Berkeley/Spring19/stat133/workout01/data/shots-data.csv")
