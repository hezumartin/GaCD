## Getting and Cleaning Data
## Jesus Martin Course Project

# 1.Get all the data and merge it in one dataset
tempdata <- tempfile()

download.file("http://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip",
              tempdata)

unzip(tempdata)

xtrain <- read.table("UCI HAR Dataset/train/X_train.txt",header=FALSE)
ytrain <- read.table("UCI HAR Dataset/train/Y_train.txt",header=FALSE)
strain <- read.table("UCI HAR Dataset/train/subject_train.txt",header=FALSE)
xtest <- read.table("UCI HAR Dataset/test/X_test.txt",header=FALSE)
ytest <- read.table("UCI HAR Dataset/test/Y_test.txt",header=FALSE)
stest <- read.table("UCI HAR Dataset/test/subject_test.txt",header=FALSE)
xdata <- rbind(xtrain, xtest)
ydata <- rbind(ytrain, ytest)
sdata <- rbind(strain, stest)

# 2.Extract only mean and std measurements
featurestemp <- read.table("UCI HAR Dataset/features.txt",header=FALSE)
features <- featurestemp[,2]
meanstd <- grep("-(mean|std)\\(\\)", features)
xdatameanstd <- xdata[, meanstd]
names(xdatameanstd) <- features[meanstd]

# 3.Name activities

activities <- read.table("UCI HAR Dataset/activity_labels.txt",header=FALSE)
ydata[, 1] <- activities[ydata[, 1], 2]
names(ydata) <- "activity"

# 4.Label the data set

names(sdata) <- "subject"
data <- cbind(xdata, ydata, sdata)
head(data)

# 5.Create dataset with average of each variable for each activity and subject

library(plyr)
meandata <- ddply(data, .(subject, activity), function(x) colMeans(x[,1:561]))
write.table(meandata, "meandata.txt", row.name=FALSE)
