# Senka Drobac
# 18.11.2918
# Week 3 - Data wrangling part
# Data: https://archive.ics.uci.edu/ml/datasets/Student+Performance

library(dplyr)

#3
#reading data
math=read.table("D:/Senka/Work/IODS-project/data/student-mat.csv",sep=";",header=TRUE)
por=read.table("D:/Senka/Work/IODS-project/data/student-por.csv",sep=";",header=TRUE)

# explore the structure and dimensions of the data
structure(math)
dim(math)

structure(por)
dim(por)


#4 Join the two data sets
join_by <- c("school","sex","age","address","famsize","Pstatus","Medu","Fedu","Mjob","Fjob","reason","nursery","internet")
# join the two datasets by the selected identifiers
math_por <- inner_join(math, por, by = join_by, suffix = c(".math", ".por") )

# Keep only the students present in both data sets.
# create a new data frame with only the joined columns
alc <- select(math_por, one_of(join_by))

# glimpse at the new combined data
glimpse(alc)
# Explore the structure and dimensions of the joined data. 
str(alc)
dim(alc)

# 5
# the columns in the datasets which were not used for joining the data
notjoined_columns <- colnames(math)[!colnames(math) %in% join_by]

# for every column name not used for joining...
for(column_name in notjoined_columns) {
  # select two columns from 'math_por' with the same original name
  two_columns <- select(math_por, starts_with(column_name))
  # select the first column vector of those two columns
  first_column <- select(two_columns, 1)[[1]]
  
  # if that first column vector is numeric...
  if(is.numeric(first_column)) {
    # take a rounded average of each row of the two columns and
    # add the resulting vector to the alc data frame
    alc[column_name] <- round(rowMeans(two_columns))
  } else { # else if it's not numeric...
    # add the first column vector to the alc data frame
    alc[column_name] <- first_column
  }
}

# glimpse at the new combined data
glimpse(alc)

# 6
# define a new column alc_use by combining weekday and weekend alcohol use
alc <- mutate(alc, alc_use = (Dalc + Walc) / 2)

# define a new logical column 'high_use'
alc <- mutate(alc, high_use = alc_use > 2)




# 7
glimpse(alc)
dim (alc)
write.table(alc, file="D:/Senka/Work/IODS-project/data/alc.txt")
