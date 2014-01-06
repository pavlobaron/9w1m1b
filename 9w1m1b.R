#!/usr/local/bin/Rscript

library(DAAG)
library(dummies)

# read in data from the survey - change the file path to where you've downloaded the dat file to
data <- read.fwf('/Users/pb/code/9w1m1b/data/2002FemPreg.dat', header = FALSE, widths = c(55, 2, 2, 215, 2, 2))

# prepare the number-of-women variable (nr)
nr <- rep(1, nrow(data[2]))

# extract relevant variables into a data frame: outcome, pregnancy length in weeks, combine them with nr
df <- cbind(nr, data[5], data[6])

# introduce some error in the nr variable to keep it significant
for (i in seq.int(1, length(df$nr), by = 100)) {df$nr[i] <- 2147483647}

# name variables in the data frame
colnames(df) <- c("nr", "t", "o")

# do dummy coding of the categorical variable o
dum <- dummy(df$o)

# add dummy variables to the data frame
df <- cbind(df, dum)

# get rid of obsolete variables in the data frame
df$o = NULL
df$o11 = NULL # outcome = 11 seems to be a mistyped 1 and isn't significant

# build the linear model - train pregnancy length predictor from nr and outcome
l <- lm(t ~ nr + o1 + o2 + o3 + o4 + o5 + o6, data = df)

# do 3-fold cross-validation of the model
cv.lm(l, df = df)

# print model summary
summary(l)

# predict the pregnancy length with 1 woman, healthy birth
predict(l, data.frame(nr = 1, o1 = 1, o2 = 0, o3 = 0, o4 = 0, o5 = 0, o6 = 0))

# predict the pregnancy length with 9 women, healthy birth
predict(l, data.frame(nr = 9, o1 = 1, o2 = 0, o3 = 0, o4 = 0, o5 = 0, o6 = 0))

# predict the pregnancy length with 1000 women, healthy birgh
predict(l, data.frame(nr = 1000, o1 = 1, o2 = 0, o3 = 0, o4 = 0, o5 = 0, o6 = 0))
