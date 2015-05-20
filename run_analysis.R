## Getting and Cleaning Data
## Jesus Martin Course Project

tempdata <- tempfile()

download.file("http://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip",
              tempdata)

unzip(tempdata)

train <- read.table("UCI HAR Dataset/train/X_train.txt")
test <- read.table("UCI HAR Dataset/test/X_test.txt")

tt <- rbind(train,test)
