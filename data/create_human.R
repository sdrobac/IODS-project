# Week 4
# Senka Drobac
# 25.11.2018.


library(dplyr)

# 2. Read the “Human development” and “Gender inequality” datas into R. 
hd <- read.csv("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/human_development.csv", stringsAsFactors = F)
gii <- read.csv("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/gender_inequality.csv", stringsAsFactors = F, na.strings = "..")


# 3. Explore the datasets: see the structure and dimensions of the data. Create summaries of the variables.
str(hd)
str(gii)

dim(hd)
dim(gii)


# 4. Look at the meta files and rename the variables with (shorter) descriptive names. 
colnames(hd) <- c("rank","country","hdi","lifeExp","eduExp","eduMean","gni","gni_minus_rank")
colnames(gii) <- c("rank", "country", "gii","matMortal","abr","parl","secEduF","secEduM","LabF","LabM")
colnames(hd)
colnames(gii)


# 5. Mutate the “Gender inequality” data and create two new variables. The first one should be the ratio of Female and Male
# populations with secondary education in each country. (i.e. edu2F / edu2M). 
# The second new variable should be the ratio of labour force participation of females and males in each country (i.e. labF / labM).


gii <- mutate(gii, secEduFM = secEduF/secEduM)
gii <- mutate(gii, LabFM = LabF/LabM)


# 6. Join together the two datasets using the variable Country as the identifier. Keep only the countries in both data sets
# (Hint: inner join). The joined data should have 195 observations and 19 variables. Call the new joined data "human" and 
# save it in your data folder. (1 point)


human <- inner_join(hd, gii, by = "country")
dim(human) #  195 observations and 19 variables

write.table(human, file = "D:/Senka/Work/IODS-project/data/human.txt")

