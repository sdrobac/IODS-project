# Senka Drobac
# Data wrangling part, Week 4 & 5
# Link to the original data: http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/human1.txt
# More about the dataset: http://hdr.undp.org/en/content/human-development-index-hdi


library(dplyr)
# Week 4:

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



# Week 5

# Load the ‘human’ data into R. Explore the structure and the dimensions of the data and describe the dataset briefly,
# assuming the reader has no previous knowledge of it (this is now close to the reality, since you have named the variables yourself).
human <- read.table(file = "D:/Senka/Work/IODS-project/data/human.txt", header = TRUE)
dim(human) # 195  19

str(human)

# This dataset is joined dataset from of two datasets (“Human development” and “Gender inequality”).
# They vere joied by Variable "country" as an identifier.

# About HDI: http://hdr.undp.org/en/content/human-development-index-hdi
# About GII: http://hdr.undp.org/sites/default/files/hdr2015_technical_notes.pdf

# Variables:
#   
# rank.x       = HDI rank
# country      = Country name
# hdi          = Human Development Index
# lifeExp      = Life expectancy at birth 
# eduExp       = Expected years of schooling 
# eduMean       = Mean Years of Education
# gni           = Gross National Income per capita 
# gni_minus_rank = GNI per Capita Rank Minus HDI Rank
# rank.y       =  GII rank
# gii           = Gender Inequality Index
# matMortal     = Maternal mortality ratio
# abr           = Adolescent Birth Rate
# parl          = Percent Representation in Parliament
# secEduF       = Proportion of females with at least secondary education
# secEduM       = Proportion of males with at least secondary education
# LabF          = Proportion of females in the labour force
# LabM          = Proportion of males in the labour force
# secEduFM      = secEduF / secEduM
# LabFM         = LabF / LabM


# 1.  Mutate the data: transform the Gross National Income (GNI) variable to numeric (Using string manipulation.
# Note that the mutation of 'human' was not done on DataCamp). (1 point)

# access the stringr package
library(stringr)

# look at the structure of the GNI column in 'human'
str(human$gni)

# remove the commas from GNI and print out a numeric version of it
gni_numeric <- str_replace(human$gni, pattern=",", replace ="") %>% as.numeric

# mutate
human <- mutate(human, gni = gni_numeric)

human$gni

# 2.  Exclude unneeded variables: keep only the columns matching the following variable names (described in the meta file above):
# "Country", "Edu2.FM", "Labo.FM", "Edu.Exp", "Life.Exp", "GNI", "Mat.Mor", "Ado.Birth", "Parli.F" (1 point)


# columns to keep
keep <- c("country", "secEduFM", "LabFM", "lifeExp", "eduExp", "gni", "matMortal", "abr", "parl")

# select the 'keep' columns
human <- dplyr::select(human, one_of(keep))

colnames(human)


# 3. Remove all rows with missing values (1 point).


# print out a completeness indicator of the 'human' data
complete.cases(human)

# print out the data along with a completeness indicator as the last column
data.frame(human[-1], comp = complete.cases(human))

# filter out all rows with NA values
human <- filter(human, complete.cases(human) == TRUE)

complete.cases(human)

 
# 4. Remove the observations which relate to regions instead of countries. (1 point)
# look at the last 10 observations of human
tail(human, 10)

# define the last indice we want to keep
last <- nrow(human) - 7

# choose everything until the last 7 observations
human <- human[1:last, ]


 
# 5. Define the row names of the data by the country names and remove the country name column from the data.
# The data should now have 155 observations and 8 variables. Save the human data in your data folder including the row names.
# You can overwrite your old ‘human’ data. (1 point)
 
# add countries as rownames
rownames(human) <- human$country

# remove the country variable
human <- select(human, -country)

dim(human) # 155   8

# Save the human data in your data folder including the row names. You can overwrite your old 'human' data. 
write.table(human, file = "D:/Senka/Work/IODS-project/data/human-new.txt", row.names=TRUE)
