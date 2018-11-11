# Senka Drobac
# 11.11.2018.
# data wrangling file, data description: http://www.helsinki.fi/~kvehkala/JYTmooc/JYTOPKYS3-meta.txt

# 2.
# reading data from the web
lrn14 <- read.table("http://www.helsinki.fi/~kvehkala/JYTmooc/JYTOPKYS3-data.txt", sep="\t", header=TRUE)

# checking dimensions (rows (observations), columns(the variables))
dim(lrn14) # data has 183 observations and 60 variables


# checking data strucvture
str(lrn14) # most of the variables are integers, only gender is Factor variable with 2 levels "F" and "M"



# 3.
# Create an analysis dataset with the variables gender, age, attitude, deep, stra, surf and points
# by combining questions in the learning2014 data
# Scale all combination variables to the original scales (by taking the mean). Exclude observations
# where the exam points variable is zero. 

# install.packages("dplyr", dependencies = TRUE)   # I needed to install this first

# Access the dplyr library
library(dplyr)
# questions related to deep, surface and strategic learning
deep_questions <- c("D03", "D11", "D19", "D27", "D07", "D14", "D22", "D30","D06",  "D15", "D23", "D31")
surface_questions <- c("SU02","SU10","SU18","SU26", "SU05","SU13","SU21","SU29","SU08","SU16","SU24","SU32")
strategic_questions <- c("ST01","ST09","ST17","ST25","ST04","ST12","ST20","ST28")

# select the columns related to deep learning and create column 'deep' by averaging
deep_columns <- select(lrn14, one_of(deep_questions))
lrn14$deep <- rowMeans(deep_columns)

# select the columns related to surface learning and create column 'surf' by averaging
surface_columns <- select(lrn14, one_of(surface_questions))
lrn14$surf <- rowMeans(surface_columns)

# select the columns related to strategic learning and create column 'stra' by averaging
strategic_columns <- select(lrn14, one_of(strategic_questions))
lrn14$stra <- rowMeans(strategic_columns)


# create column 'attitude' by scaling the column "Attitude"
lrn14$attitude <- lrn14$Attitude / 10

# choose a handful of columns to keep
keep_columns <- c("gender","Age","attitude", "deep", "stra", "surf", "Points")

# select the 'keep_columns' to create a new dataset
learning2014 <- select(lrn14, one_of(keep_columns))


# Change column names
colnames(learning2014)
colnames(learning2014)[2] <- "age"
colnames(learning2014)[7] <- "points"


# select rows where points is greater than zero
learning2014 <- filter(learning2014, points > 0) 
# dim(learning2014)
# learning2014

# see the stucture of the new dataset
# str(learning2014)

# 4.
# Set the working directory of you R session the iods project folder (study how to do this with RStudio).
# Save the analysis dataset to the ‘data’ folder, using for example write.csv() or write.table() functions.
# You can name the data set for example as learning2014(.txt or .csv). See ?write.csv for help or search 
# the web for pointers and examples. Demonstrate that you can also read the data again by using read.table() or read.csv().
# (Use `str()` and `head()` to make sure that the structure of the data is correct).  (3 points)

setwd("D:/Senka/Work/IODS-project")
write.table(learning2014, file="data/learning2014.txt")

testData <- read.table("data/learning2014.txt")
str(testData)
head(testData)
