# Senka Drobac
# Week 6 - wrangling part


library(dplyr)
library(tidyr)


# 1.  Load the data sets (BPRS and RATS) into R using as the source the GitHub repository of MABS, where they are given in the wide form

# Read the data
BPRS <- read.table("https://raw.githubusercontent.com/KimmoVehkalahti/MABS/master/Examples/data/BPRS.txt", sep  =" ", header = T)
RATS <- read.table("https://raw.githubusercontent.com/KimmoVehkalahti/MABS/master/Examples/data/rats.txt", header = T)

# Look at the (column) names
names(BPRS)
names(RATS)

# Look at the structure
str(BPRS)
str(RATS)

# Print out summaries of the variables
summary(BPRS)
summary(RATS)


# TODO create some brief summaries of the variables, so that you understand the point of the wide form data.

# 2. Convert the categorical variables of both data sets to factors. (1 point)
# Access the packages dplyr and tidyr


# Factor treatment & subject
BPRS$treatment <- factor(BPRS$treatment)
BPRS$subject <- factor(BPRS$subject)

RATS$ID <- factor(RATS$ID)
RATS$Group <- factor(RATS$Group)

# 3. Convert the data sets to long form. Add a week variable to BPRS and a Time variable to RATS. (1 point)

# Convert to long form
BPRSL <-  BPRS %>% gather(key = weeks, value = bprs, -treatment, -subject)
# Extract the week number
BPRSL <-  BPRSL %>% mutate(week = as.integer(substr(BPRSL$weeks, 5,6)))


# Convert data to long form
RATSL <- RATS %>%
  gather(key = WD, value = Weight, -ID, -Group) %>%
  mutate(Time = as.integer(substr(WD, 3,4 ))) 



# 4. Now, take a serious look at the new data sets and compare them with their wide form versions:
#   check the variable names, view the data contents and structures, and create some brief summaries of the variables.
# Make sure that you understand the point of the long form data and the crucial difference between the wide and the long
# forms before proceeding the to Analysis exercise. (2 points)


names(BPRS)
names(BPRSL)

str(BPRS)
str(BPRSL)

glimpse(BPRS)
glimpse(BPRSL)
## All week columns (week1, week2, ...) are now in one column called Weeks and data has been shifted from columns to rows


# Take a glimpse at the BPRSL data
names(RATS)
names(RATSL)

str(RATS)
str(RATSL)

glimpse(RATS)
glimpse(RATSL)

## Similarly, WD columns (WD1, WD8, ...) are now in one column called WD and data has been shifted from columns to rows

write.table(RATSL, file = "D:/Senka/Work/IODS-project/data/ratsl.txt", row.names=TRUE)
write.table(BPRSL, file = "D:/Senka/Work/IODS-project/data/bprsl.txt", row.names=TRUE)
