# R works like a calculator
1 + 1
5 * 5

# R is object-oriented; create objects, manipulate them, have them interact with one another
# object can be numeric vectors...
vec01 <- 1:5
vec02 <- 6:10
# ... or character vectors
vec03 <- c("a","b","c","d","e")

# We can manipulate objects with functions
# some functions have few, simple arguments...
length(vec01)
mean(vec01)
# ... some require more arguments
rnorm(n = 100, mean = 0, sd = 1)

# Unsure about how a function works? Use a preceding question mark to open up the documentation
?rnorm

# We can use functions to create new objects
# Dataframes are two dimensional objects
dframe01 <- data.frame(vec01, vec02, vec03)
dframe01

# Here are some basic functions for exploring data in a dataframe
# How many rows? Columns?
nrow(dframe01)
ncol(dframe01)
dim(dframe01)

# We can grab individual columns (called variables) from a dataframe using the dollar sign syntax
dframe01$vec01

# We can subset columns and rows (called observations) using square indexing brackets
# grab the first column
dframe01[,1]

# grab the first row
dframe01[1,]

# grab the first two rows
dframe01[1:2,]

# grab the value in the first row and second column
dframe01[1,2]

# grab the rows for which vec01 values are greater than 3
dframe01[dframe01$vec01 > 3,]

# Note that what you've done in the above line is nest a conditional statement within the indexing brackets; this creates a boolean (TRUE/FALSE) vector
dframe01$vec01 > 3

# Other conditional statements... greater than or equal to
dframe01$vec01 >= 3

# equal to... notice the syntax is a double equal sign
dframe01$vec01 == 3

# not equal to
dframe01$vec01 != 3

# or you can specify specific values from a numeric variable...
dframe01$vec01 %in% c(1,3,5)

# or specific values from a categorical variable
dframe01$vec03 %in% c("b","d")

# remember that these resulting boolean vectors can be nested within brackets to subset rows
dframe01[dframe01$vec01 %in% c(1,3,5),]

########################################################################################################
# More practice with dataframes; Intro to base R plotting

# make a bigger (more rows) dataframe 
varA <- c(rep("siteX",100), rep("siteY",100), rep("siteZ",100))
varB <- 1:300
varC <- rnorm(300)
varD <- runif(300)
dframe02 <- data.frame(varA, varB, varC, varD)

# check out dimensions and first few rows
nrow(dframe02)
ncol(dframe02)
dim(dframe02)
head(dframe02)

# make a histogram of varA and varB
hist(dframe02$varB)
hist(dframe02$varC)
hist(dframe02$varD)

# make a scatterplot of a few variable pairs
plot(dframe02$varB, dframe02$varC)
plot(dframe02$varB, dframe02$varD)
plot(dframe02$varC, dframe02$varD)

# make boxplots relating the categorical variable (varA) to the three numerical variables
boxplot(dframe02$varB ~ dframe02$varA)
boxplot(dframe02$varC ~ dframe02$varA)
boxplot(dframe02$varD ~ dframe02$varA)

########################################################################################################
# aggregating data

# use aggregate function to get mean of numerical variables based on levels of the categorical variable
aggregate(varB ~ varA, dframe02, mean)
aggregate(varC ~ varA, dframe02, mean)
aggregate(varD ~ varA, dframe02, mean)

# you can perform other functions too
aggregate(varD ~ varA, dframe02, median)
aggregate(varD ~ varA, dframe02, sd)      # standard deviation
aggregate(varD ~ varA, dframe02, min)
aggregate(varD ~ varA, dframe02, max)

# notice that the black lines in this boxplot...
boxplot(dframe02$varB ~ dframe02$varA)

# ... are the same values as in this table
aggregate(varB ~ varA, dframe02, mean)
