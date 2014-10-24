# You should create one R script called run_analysis.R that does the following.
# Merges the training and the test sets to create one data set.
# Extracts only the measurements on the mean and standard deviation for each measurement. 
# Uses descriptive activity names to name the activities in the data set
# Appropriately labels the data set with descriptive variable names. 
# Creates a second, independent tidy data set with the average of each variable for each activity and each subject.

##Create a directory
## setwd("/Users/isa/Documents/Courses/Johns Hopkins/Getting & Cleaning Data/Project")
## getwd()

# You should create one R script called run_analysis.R that does the following.
run_analysis <- function(){
        
        
        #Download zip the file        
        url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
        
        # Download the file.
        download.file(url, "UCI-HAR-dataset", method="curl")
        
        
        # 1. Merges the training and the test sets to create one data set.
        features <- read.table("./UCI HAR Dataset/features.txt")
        X_test <- read.table("./UCI HAR Dataset/test/X_test.txt", col.names=features[,2])
        X_train <- read.table("./UCI HAR Dataset/train/X_train.txt", col.names=features[,2])
        mergedData <- rbind(X_test, X_train)
        
        # 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
        someFeature <- features[grep("(std|mean)\\(", features[,2]),]
        mean_and_std <- mergedData[,someFeature[,1]]
        
        # 3. Uses descriptive activity names to name the activities in the data set
        y_test <- read.table("./UCI HAR Dataset/test/y_test.txt", col.names = c('activity'))
        y_train <- read.table("./UCI HAR Dataset/train/y_train.txt", col.names = c('activity'))
        y <- rbind(y_test, y_train)
        
        labels <- read.table("./UCI HAR Dataset/activity_labels.txt")
        for (i in 1:nrow(labels)) {
                code <- as.numeric(labels[i, 1])
                name <- as.character(labels[i, 2])
                y[y$activity == code, ] <- name
        }
        
        # 4. Label the data set with descriptive activity names. 
        mergedData_with_labels <- cbind(y, mergedData)
        mean_and_std_with_labels <- cbind(y, mean_and_std)
        
        # 5. Creates a second, independent tidy data set with the average of each variable 
        #    for each activity and each subject. 
        subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt", col.names = c('subject'))
        subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt", col.names = c('subject'))
        subject <- rbind(subject_test, subject_train)
        averages <- aggregate(mergedData, by = list(activity = y[,1], subject = subject[,1]), mean)
        
        write.csv(averages, file='tidy_data.txt', row.names=FALSE)
}
